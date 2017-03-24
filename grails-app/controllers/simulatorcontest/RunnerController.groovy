package simulatorcontest

import runner.ParserTestSuite
import runner.STestCase
import runner.STestSuite
import runner.TestRunner

class RunnerController {

    def testFile(UploadFile f) {
        def tester = new TestRunner(tarFileName:f.path, result:"")
        tester.fileObject = f  // attach the file object
        def testSuite = new ParserTestSuite().getSuite(servletContext["testsuite"])
        tester.test(testSuite, f.group)
        f.result = tester.result
        ///println tester.result
        f.save(flush:true)
        return tester.result
    }

    def sTestAll() {
        if (params["pd"] != null && params.int("pd") == 752) {
            def glist = ContestGroup.findAll([sort:"identity", order:"asc"])
            glist.each { it ->
                if (it.files && it.files.size() > 0) {
                    def f = it.files[0] /// latest file
                    println "-------- start to test group " + it.identity + " ----------"
                    testFile(f)
                    println "-------- end to test group " + it.identity + " ----------"
                }
            }
            render "all tested"
        } else {
            render "not allowed!!"
        }
        render("N")
    }

    def testAll() {

        if (!session["group"]) {
            redirect(uri:"/")
            return
        }

        if (session["group"].identity == 75) {

            def glist = ContestGroup.findAll([sort:"identity", order:"asc"])
            glist.each { it ->
                if (it.files && it.files.size() > 0) {
                    def f = it.files[0] /// latest file
                    if (!f.result) {
                        println "-------- start to test group " + it.identity + " ----------"
                        testFile(f)
                        println "-------- end to test group " + it.identity + " ----------"
                    }
                }
            }

            render "End of testAll"

        } else {
            render "You cannot do this, please!!!"
        }

    }

    def test() {
        if (!params["fid"] || !session["group"]) {
            redirect(uri:"/")
            return
        }

        def f = UploadFile.findById(params.int("fid"))
        if (f) {
            if (session["group"].identity == 75){
                renderResult(testFile(f))
            } else {
                render "You cannot do this, please!!!"
            }
        } else {
            render "The upload file of this ID does not exist!"
        }
    }

    def renderResult(String resultStr) {
        String output=""
        resultStr.readLines().each {it->
            output += (it + "<br>")
        }
        render output
    }

    def result() {
        if (!params["fid"] || !session["group"]) {
            redirect(uri:"/")
            return
        }

        def f = UploadFile.findById(params.int("fid"))
        if (f) {
            println  session["group"].identity
            if (f.group.id == session["group"].id || session["group"].identity == 75) {
                if (f.result && !f.result.isEmpty()) {
                    def rList = TestResult.findAllByFile(f, [sort:"id", order:"asc"])
                    if (rList.size() > 0) {
                        int i = 1
                        String result = ""
                        rList.each { it ->
                            result += "The result of executing test case " + i + " is : \n"
                            //println it.result + "-------"
                            result += "Output: " + it.result
                            if (it.result.charAt(it.result.size() - 1) != '\n') result += "\n"
                            result += "Time: " + it.time + "s\n"
                            result += "\n"
                            i++
                        }
                        renderResult(result)
                    } else {
                        renderResult(f.result)
                    }
                } else {
                    render "No result until now"
                }
            } else {
                render "Not your file, please!!!"
            }
        } else {
            render "The upload file of this ID does not exist!"
        }
    }

    def rank() {
        if (!session["group"]) {
            redirect(uri:"/")
            return
        }

        // get the result table first [group -> resultList]
        def resultTable = [:]
        def gList = ContestGroup.findAll([sort:"identity", order:"asc"])
        int size = 0
        gList.each {it ->
            if (it.identity != 75 && it.files && it.files.size() > 0) { //TODO: the file after...
                def f = it.files[0] // latest file
                def allList = TestResult.findAllByFile(f, [sort:"id", order:"asc"])
                def resultList = []
                // just load the results of current test suite
                allList.each { r ->
                    if (r.testcase.suite == servletContext["testsuite"]) {
                        resultList.add(r)
                    }
                }
                if (resultList.size() > 0) {
                    size = resultList.size()
                    def gResult = new ArrayList()
                    resultList.each { re ->
                        //println re.result
                        if (re.isSuccess()) {
                            gResult.add(re.time.toString())
                        } else if (re.isTimeout()) {
                            gResult.add("Timeout")
                        } else {
                            gResult.add("Fails")
                        }
                    }
                    resultTable[it] = gResult
                }
            }
        }

        // Order or rank the groups
        def weightMap = [0:1, 1:1, 2:1, 3:1, 4:1, 5:1, 6:1, 7:3, 8:3, 9:3]
        def gradeMap = [:]   //resultTable
        // Generate the grade (only failing or timeout is considered)
        resultTable.keySet().each { g ->
            def rList = resultTable[g]
            float grade = 0
            for (int i = 0; i < rList.size(); i++) {
                if (rList[i] != "Fails" && rList[i] != "Timeout") {
                    /// normal results
                    grade = grade + rList[i].toString().toFloat().floatValue() * weightMap[i]
                } else {
                    if (i >= 0 && i <= 7) {
                        /// the first 7 cases
                        grade = Float.MAX_VALUE
                        break
                    } else {
                        /// timeout (120s)
                        grade = grade + 120 * weightMap[i]
                    }
                }
            }
            gradeMap[g] = grade
        }
        // sort the map
        gradeMap = gradeMap.sort {it.value}

        // println gradeMap
        // get the ranked map
        def rankMap = [:]
        gradeMap.each {
            rankMap.put(it.key, resultTable[it.key])
        }

        // generate the result table
        String result = "<table><tr><th></th>"
        for (int j = 1 ; j <= size; j++) {
            result  = result + "<th>T" + j + "</th>"
        }
        result += "<th>Rank</th>"
        result += "</tr>"
        int r = 1
        rankMap.keySet().each { g ->
            def rList = rankMap[g]
            result += "<tr>"
            result += "<th>Group" + g.identity + "</th>"
            rList.each { rstr ->
                result += "<th>" + rstr + "</th>"
            }
            result += "<th>" + r + "</th>"
            result += "</tr>"
            r++
        }

        result += "</table>"

        render result
    }

    def index() {
        render "index of runner"
    }
}
