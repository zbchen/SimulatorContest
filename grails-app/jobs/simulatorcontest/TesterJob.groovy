package simulatorcontest

import runner.ParserTestSuite
import runner.TestRunner

class TesterJob {

    static triggers = {
      simple startDelay: 600000, repeatInterval: 2700000 // execute job once in 45 minutes
      //simple repeatInterval: 5000 // execute job once in 5 seconds
    }

    def execute() {
        // execute job
        println "-------- start to do the test of untested code ----------"
        def glist = ContestGroup.findAll([sort:"identity", order:"asc"])
        glist.each { it ->
            if (it.files && it.files.size() > 0) {
                def f = it.files[0] /// latest file
                if (!f.result) {
                    println "-------- start to test group " + it.identity + " ----------"
                    def tester = new TestRunner(tarFileName:f.path, result:"")
                    tester.fileObject = f  // attach the file object
                    def testSuite = new ParserTestSuite().getSuite(servletContext["testsuite"])
                    tester.test(testSuite, f.group)
                    f.result = tester.result
                    ///println tester.result
                    f.save(flush:true)
                    println "-------- end to test group " + it.identity + " ----------"
                }
            }
        }
        println "-------- end to do the test of untested code ----------"
    }
}
