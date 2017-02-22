package simulatorcontest

import runner.STestCase
import runner.TestRunner

class RunnerController {

    def test() {
        if (!params["fid"] || !session["group"]) {
            redirect(uri:"/")
            return
        }

        def f = UploadFile.findById(params.int("fid"))
        if (f) {
            if (f.group.id == session["group"].id || session["group"].identity == 75){
                def tester = new TestRunner(tarFileName:f.path, result:"")
                def testSuite = [
                        new STestCase(0, "", "", "", "", 3),
                        new STestCase(1, "", "", "", "", 3)
                ]
                tester.test(testSuite, f.group)
                f.result = tester.result
                ///println tester.result
                f.save(flush:true)
                renderResult(tester.result)
            } else {
                render "Not your file, please!!!"
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
                    renderResult(f.result)
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
