package simulatorcontest

import runner.ParserTestSuite
import runner.STestCase
import runner.STestSuite
import runner.TestRunner

class RunnerController {

    def testFile(UploadFile f) {
        def tester = new TestRunner(tarFileName:f.path, result:"")
        tester.fileObject = f  // attach the file object
        def testSuite = new ParserTestSuite().getSuite("2") // get the second suite
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
                    if (!f.result) {
                        println "-------- start to test group " + it.identity + " ----------"
                        testFile(f)
                        println "-------- end to test group " + it.identity + " ----------"
                    }
                }
            }
            render "all tested"
        } else {
            render "not allowed!!"
        }
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
                            println it.result + "-------"
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

    def index() {
        render "index of runner"
    }
}
