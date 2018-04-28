package simulatorcontest

import runner.ParserTestSuite
import runner.STestCase
import runner.STestSuite
import runner.TestRunner
import runner.FLRunner

class RunnerController {

    def testFile(UploadFile f) {
        String result = ""
        def tester = new TestRunner(tarFileName:f.path, result:"")
        tester.fileObject = f  // attach the file object
        def testSuite = new ParserTestSuite().getSuite(servletContext["testsuite"])
        def oldSuite = null
        if (servletContext["testsuite"] == "003") {
            oldSuite = new ParserTestSuite().getSuite("002")
        }
        /// do the current test suite
        tester.test(testSuite, f.group)
        f.result = tester.result
        result = tester.result
        ///println tester.result

        /// do the Regression testing if possible
        if (oldSuite != null) {
            tester.result = ""
            tester.test(oldSuite, f.group)
            f.result += "--------------------------Results of the 2nd testsuite (Regression Testing)-----------------------------\n"
            f.result += tester.result
            result = f.result
        }
        f.save(flush:true)
        return result
    }

    def flFile(UploadFile f) {
        def fl = new FLRunner(tarFileName:f.path, result:"")
        fl.fileObject = f  // attach the file object
        def testSuite = new ParserTestSuite().getSuite(servletContext["testsuite"])
        def debugOraclePath = servletContext.getRealPath("/DebugFiles/")
        fl.fl(testSuite, f.group, debugOraclePath, servletContext["testsuite"])
        String result = fl.result

        result += "\n\n"
        result += "-------------------------------The Following is the fault localization result of 2nd test suite\n\n"

        testSuite = new ParserTestSuite().getSuite("002")
        fl.fl(testSuite, f.group, debugOraclePath, "002")
        result += fl.result

        return result
    }


    def sTestAll() {
        if (params["pd"] != null && params.int("pd") == 752) {
            def glist = ContestGroup.findAll([sort:"identity", order:"asc"])
            glist.each { it ->
                if (it.files && it.files.size() > 0) {
                    def f = it.files[0] /// latest file
                    println "-------- start to test group " + it.id + " ----------"
                    testFile(f)
                    println "-------- end to test group " + it.id + " ----------"
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
                        println "-------- start to test group " + it.id + " ----------"
                        testFile(f)
                        println "-------- end to test group " + it.id + " ----------"
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
            //if (session["group"].identity == 75){
                renderResult(testFile(f))
            //} else {
                //render "You cannot do this, please!!!"
            //}
        } else {
            render "The upload file of this ID does not exist!"
        }
    }

    def fl() {
        if (!params["fid"] || !session["group"]) {
            redirect(uri:"/")
            return
        }

        def f = UploadFile.findById(params.int("fid"))
        if (f) {
            //if (session["group"].identity == 75){
            //renderResult(testFile(f))
            def result = flFile(f)
            renderResult(result)
            //} else {
            //render "You cannot do this, please!!!"
            //}
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
                            if (it.testcase.suite == servletContext["testsuite"]) {
                                result += "The result of executing test case " + i + " is : \n"
                                //println it.result + "-------"
                                result += "Output: " + it.result
                                if (it.result.charAt(it.result.size() - 1) != '\n') result += "\n"
                                result += "Time: " + it.time + "s\n"
                                result += "\n"
                                i++
                            }
                        }

                        result += "--------------------------Results of the 2nd testsuite (Regression Testing)-----------------------------\n\n"
                        i = 1
                        rList.each { it ->
                            if (it.testcase.suite == "002") {
                                result += "The result of executing test case " + i + " is : \n"
                                //println it.result + "-------"
                                result += "Output: " + it.result
                                if (it.result.charAt(it.result.size() - 1) != '\n') result += "\n"
                                result += "Time: " + it.time + "s\n"
                                result += "\n"
                                i++
                            }
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
                def regressionList = []
                // just load the results of current test suite
                allList.each { r ->
                    if (r.testcase.suite == servletContext["testsuite"]) {
                        resultList.add(r)
                    }

                    /// get the results of the 2nd testsuite
                    if (r.testcase.suite == "002") {
                        regressionList.add(r)
                    }
                }

                if (resultList.size() > 0) {
                    size = resultList.size()
                    def gResult = new ArrayList()
                    /// add the 3rd testing results
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
                    /// add the 2nd testing results
                    if (regressionList.size() > 0) {
                        size += regressionList.size()
                        regressionList.each { re ->
                            //println re.result
                            if (re.isSuccess()) {
                                gResult.add(re.time.toString())
                            } else if (re.isTimeout()) {
                                gResult.add("Timeout")
                            } else {
                                gResult.add("Fails")
                            }
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
            //println g
            //println rList
            for (int i = 0; i < rList.size(); i++) {
                if (rList[i] != "Fails" && rList[i] != "Timeout") {
                    /// normal results
                    if (i >= 0 && i <=9 ) { /// only consider the 3rd testsuite for ranking
                        grade = grade + rList[i].toString().toFloat().floatValue() * weightMap[i]
                    }
                } else {
                    if ((i >= 0 && i <= 6) || (i >= 10 && i <= 19)) {
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
        for (int j = 1 ; j <= 10; j++) {
            result  = result + "<th>T" + j + "</th>"
        }
        result += "<th>Rank</th>"
        for (int j = 1 ; j <= 10; j++) {
            result  = result + "<th>T" + j + "</th>"
        }
        result += "</tr>"
        int r = 1
        boolean under = false
        rankMap.keySet().each { g ->
            def rList = rankMap[g]

            if (gradeMap[g] == Float.MAX_VALUE && under == false) { /// add the separator
                result += "<tr>"
                for (int i = 0; i < 22; i++) {
                    result += "<th>-</th>"
                }
                result += "</tr>"
                result += "<tr>"
                for (int i = 0; i < 22; i++) {
                    result += "<th>-</th>"
                }
                result += "</tr>"
                under = true
            }

            result += "<tr>"
            result += "<th>Group" + (g.id.intValue()<10?"00":g.id.intValue()<100?"0":"") + g.id.toString() + "</th>"
            rList.eachWithIndex { rstr, index ->
                result += "<th>" + rstr + "</th>"
                if (index == 9) { /// add the rank
                    result += "<th>" + r + "</th>"
                }
            }
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
