package runner

import simulatorcontest.ContestGroup
import simulatorcontest.TestCase
import simulatorcontest.TestResult

import javax.servlet.ServletContext

class Compiler {
    def programPath = ""
    def result = ""

    def compile(def tarFileName) {
        // extract the tar file
        def f = new File(tarFileName)
        def destination = f.parentFile.path + "/" + f.name.replace(".tar", "")
        def newFolder = new File(destination)
        if (!newFolder.exists()) {
            newFolder.mkdirs()
        } else {
            // if already exists, remove the folder (also the files in the folder) and create the folder
            newFolder.deleteDir()
            newFolder.mkdirs()
        }

        def tarCommand = "tar -xf " + tarFileName + " -C " + destination
        def tarProcess = tarCommand.execute()
        def out = new StringBuffer()
        def err = new StringBuffer()
        tarProcess.consumeProcessOutput(out, err)
        tarProcess.waitFor()
        if (tarProcess.exitValue() != 0) {
            result += out.toString()
            result += err.toString()
            return -1
        }

        println "End to unpack " + tarFileName

        // enter the folder and execute make to compiler
        def makeCommand = "make -C " + destination
        def makeProcess = makeCommand.execute()
        makeProcess.consumeProcessOutput(out, err)
        makeProcess.waitFor()
        if (makeProcess.exitValue() != 0) {
            result += out.toString()
            result += err.toString()
            return -1
        }

        println "End to compile " + destination
        programPath = destination
        return 0
    }

}

///
class STestSuite {

    /**
     *
     * Return a list of test cases
     * @param suiteName
     */
    def getSuite(String suiteName) {

    }

}

class ParserTestSuite extends STestSuite {

    def getSuite(String suiteName) {
        def caseList = TestCase.findAllBySuite(suiteName, [sort:"id", order:"asc"])

        List suite = new ArrayList()

        int i = 1
        caseList.each { it ->
            def c = new STestCase()
            c.index = i
            c.construct(it)
            c.caseObject = it // attach the database object
            suite.add(c)
            i++
        }

        return suite
    }

}

class AbstractTestCase {
    def construct(TestCase c) {}
    def command() {}
    def compare() {}
    def execute(String program) {}
}

class STestCase extends AbstractTestCase {
    // Need to provide the absolute paths of all files
    def index
    def instructionFile
    def memoryFile
    String outputFile
    String debugFile = ""
    def oracleFile
    def timeout // in seconds
    def result = ""
    def caseObject
    Float executionTime = -1

    STestCase(){}

    STestCase(STestCase it) {
        index = it.index
        instructionFile = it.instructionFile
        memoryFile = it.memoryFile
        outputFile = new String(it.outputFile) // should new a String to ensure concurrent accesses
        oracleFile = it.oracleFile
        timeout = it.timeout
    }

    STestCase(int i, String insf, String mf, String opf, String orf, int to) {
        index = i
        instructionFile = insf
        memoryFile = mf
        outputFile = opf
        oracleFile = orf
        timeout = to
    }

    def construct(TestCase c) {

        timeout = c.timeout
        outputFile = "output_" + index

        c.paras.each { it->
            if (it.name == "-i") {
                instructionFile = it.path
            }
            if (it.name == "-m") {
                memoryFile = it.path
            }
            if (it.name == "-o") {
                oracleFile = it.path
            }
        }

    }

    /// copy instruction and memory files
    /// set the instrudctionFile and memoryFile to the copied files
    def copyFiles(String folder) {
        // println folder
        // copy instruction file
        if (instructionFile) {
            def icpCommand = "cp " + instructionFile.toString() + " "
            instructionFile = folder + "/program_" + index
            icpCommand += instructionFile
            /// do copy
            // println icpCommand
            def icpProcess = icpCommand.execute()
            icpProcess.waitFor()
        }

        // copy memory file
        if (memoryFile) {
            def cpCommand = "cp " + memoryFile + " "
            memoryFile = folder + "/memory_" + index
            cpCommand += memoryFile
            /// do copy
            def cpProcess = cpCommand.execute()
            cpProcess.waitFor()
        }
    }

    def command() {
        String cmd
        if (!memoryFile || memoryFile.isEmpty()) {
            cmd = " -i " + instructionFile + " -o " + outputFile
        } else {
            cmd = " -i " + instructionFile + " -m " + memoryFile + " -o " + outputFile
        }

        if (debugFile.isEmpty() == false) {
            cmd += " -d " + debugFile
        }

        return cmd
    }

    /**
     * compare the output file and oracle file
     * return 0 if equal, -1 otherwise
     */
    def compare() {
        def output = new File(outputFile)
        def oracle = new File(oracleFile)
        if (!output.exists() || !oracle.exists()) return -1

        List<String> outputLines = output.readLines()
        List<String> oracleLines = oracle.readLines()
        if (oracleLines.size() != outputLines.size()) return -1

        for (int i = 0; i < oracleLines.size(); i++) {
            if (outputLines[i].trim() != oracleLines[i].trim()) return -1
        }
        return 0
    }

    /**
     * Execute the test case
     * @param program
     */
    def execute(String program) {
        def str = "time timeout " + timeout + "s " + program + command()
        def executionCommand = ["/bin/bash", "-c", "ulimit -v 1024000; " + str ] // limit the memory to be 1G
        println executionCommand
        def executionProcess = executionCommand.execute()
        executionProcess.waitFor()
        String resultText = executionProcess.err.text
        String inResult = executionProcess.in.text
        println inResult
        println resultText
        println executionProcess.exitValue()
        if (executionProcess.exitValue() == 0) {
            // successfully execute
            // Parse the result
            if (compare() == 0) {
                // The result is right, parse the result of execution time
                String timeStr = resultText.substring(0, resultText.indexOf("user")) // Specially for ubuntu
                String[] r = timeStr.split("\t")
                if (r.length > 0) {
                    String time = r.last()
                    time = time.replace("s", "")
                    String[] l = time.split("m") // e.g., "00m01.00"
                    if (l.size() == 2) { // first part is minute, second part is second
                        executionTime = (l[0].toInteger().intValue() * 60 + l[1].toFloat().floatValue())
                    }
                }
                return 0
            } else {
                // The result is not right
                result = "The output of this test case is wrong"
                return -1
            }
        } else {
            // Fail or timeout, record the result
            if (executionProcess.exitValue() == 124)
                result = "The execution of this test case is timeout"
            else {
                if (resultText.readLines().size() >= 10) {
                    /// only last 10 lines
                    /// protect test case sources
                    result = ""
                    for (int i = 0; i < 10; i++) {
                        result += resultText.readLines()[i - 10 + i] + "\n"
                    }
                } else {
                    result = resultText
                }
            }
            return -1
        }
    }

}

class FLRunner {
    def fileObject

    def tarFileName
    def result = ""

    def fl(List<STestCase> tests, ContestGroup group, String debugFileFolder, String suiteName) {
        // compile
        def compiler = new Compiler()
        int i = compiler.compile(tarFileName)

        if (i != 0) {
            // compiling fails
            result = compiler.result
            return -1
        }

        // execute the simulator for test cases
        tests.each { it ->
            def test = new STestCase(it)

            if (test.index == 3 && suiteName == "002") { /// skip the third one of the testsuite 2
                return
            }

            if ((test.index in [1, 2, 5, 6, 7]) == false  && suiteName == "003") { /// skip the third one of the testsuite 2
                return
            }

            test.timeout *= 2 /// double the timeout for fault localization

            test.copyFiles(compiler.programPath) /// this step is important, copy test files to the local folders
            test.outputFile = compiler.programPath + File.separator + test.outputFile
            test.debugFile =  compiler.programPath + File.separator + "debug_" + test.index
            int r = test.execute(compiler.programPath + "/DLXSimulator" + (group.id.intValue()<10?"00":group.id.intValue()<100?"0":"") + group.id.toString())


            if (r == -1) {
                if (test.result.equals("The output of this test case is wrong")) {
                    /// we only consider the wrong case where output is not right

                    /// compare oracle debug file with the output file
                    String resultStr = "The fault localization w.r.t. the running of test case " + it.index + ": \n"

                    def output_debug_file = new File(test.debugFile)
                    def oracle_debug_file = new File(debugFileFolder + suiteName + "-" + test.index)
                    if (!output_debug_file.exists() || !oracle_debug_file.exists()) {
                        resultStr = "failed to localize"
                        result += resultStr
                        return
                    }

                    List<String> outputLines = output_debug_file.readLines()
                    List<String> oracleLines = oracle_debug_file.readLines()
                    //if (oracleLines.size() != outputLines.size()) return -1

                    for (int j = 0; j < oracleLines.size(); j++) {
                        String oracle = oracleLines[j].trim()
                        String output = outputLines[j].trim()
                        String[] oracle_strArrray = oracle.split("#")
                        String[] output_strArrray = output.split("#")
                        if (oracle_strArrray.size() >= 2 && output_strArrray.size() >= 2) {
                            String oracle_instr = oracle_strArrray[0].trim()
                            String oracle_rstate = oracle_strArrray[1].trim()
                            String output_instr = output_strArrray[0].trim()
                            String output_rstate = output_strArrray[1].trim()
                            if (oracle_instr.toLowerCase().equals(output_instr.toLowerCase())) {
                                if (oracle_rstate.equals(output_rstate) == false) {
                                    resultStr += "The following instruction is maybe not right: " + oracle_instr + "\n"
                                    if (j > 0) {
                                        String tmp = ""
                                        for (int k = 0; k < j ; k++) {
                                            tmp += oracleLines[k].substring(0, oracleLines[k].indexOf('#')) + ";"
                                        }
                                        resultStr += "The before instruction sequence is : " + tmp
                                        resultStr += "\n"
                                    }
                                    break
                                }
                            } else {
                                resultStr += "The instruction is different: " + oracle_instr + "(oracle):" + output_instr+"(yours)\n"
                                if (j > 0) {
                                    String tmp = ""
                                    for (int k = 0; k < j ; k++) {
                                        tmp += oracleLines[k].substring(0, oracleLines[k].indexOf('#')) + ";"
                                    }
                                    resultStr += "The before instruction sequence is : " + tmp

                                    resultStr += "\n"
                                }
                                break
                            }
                        }
                    }

                    result += resultStr
                    result += "--------------------------------------------\n"

                }
            }
        }

        // remove the temp folder recursively
//        def folder = new File(compiler.programPath)
//        if (folder.exists()) {
//            folder.deleteDir()
//        }

        return 0
    }

}

class TestRunner {

    def fileObject

    def tarFileName
    def result

    def test(List<STestCase> tests, ContestGroup group) {
        // compile
        def compiler = new Compiler()
        int i = compiler.compile(tarFileName)

        if (i != 0) {
            // compiling fails
            result = compiler.result
            return -1
        }

        // execute the simulator for test cases
        tests.each { it ->
            def test = new STestCase(it)
            test.copyFiles(compiler.programPath) /// this step is important, copy test files to the local folders
            test.outputFile = compiler.programPath + File.separator + test.outputFile
            int r = test.execute(compiler.programPath + "/DLXSimulator" + (group.id.intValue()<10?"00":group.id.intValue()<100?"0":"") + group.id.toString())

            String resultStr = "The execution of test case " + it.index

            if (r == -1)
                resultStr += " fails\n"
            else
                resultStr += " succeeds\n"

            if (!test.result.isEmpty())
                resultStr += test.result + "\n"

            result += resultStr
            result += "\n"

            /// Save the result
            def resultObject = TestResult.findByFileAndTestcase(fileObject, it.caseObject)

            if (resultObject) {
                resultObject.time = test.executionTime
                resultObject.result = resultStr
            } else {
//                println test.executionTime
//                println resultStr
//                println fileObject
//                println it.caseObject
                resultObject = new TestResult(time:test.executionTime, result:resultStr, file:fileObject, testcase: it.caseObject)
            }
//            println resultObject

            resultObject.save(true)

        }

        // remove the temp folder recursively
//        def folder = new File(compiler.programPath)
//        if (folder.exists()) {
//            folder.deleteDir()
//        }

        return 0
    }

}

//def r = new TestRunner(
//        tarFileName: "/Users/czb/Development/SimulatorContest/src/main/webapp/uploadFiles/simulator1.tar",
//        result: "")
//r.test(testSuite)
//println r.result
//new STestCase("","","","", 3).execute("sleep 10")