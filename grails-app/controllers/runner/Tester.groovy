package runner

import simulatorcontest.ContestGroup
import simulatorcontest.TestCase

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
    def oracleFile
    def timeout // in seconds
    def result = ""

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
        outputFile = "output_" + index;

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

    def command() {
        if (memoryFile && memoryFile.isEmpty()) {
            return " -i " + instructionFile + " -o " + outputFile
        } else {
            return " -i " + instructionFile + " -m " + memoryFile + " -o " + outputFile
        }
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
        def executionCommand = "time timeout " + timeout + "s " + program + command()
        println executionCommand
        def executionProcess = executionCommand.execute()
        executionProcess.waitFor()
        String resultText = executionProcess.err.text
        println executionProcess.in.text
        println resultText
        println executionProcess.exitValue()
        if (executionProcess.exitValue() == 0) {
            // successfully execute
            // Parse the result
            if (compare() == 0) {
                // The result is right
                //TODO parse the result of execution time
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
            else
                result = resultText
            return -1
        }
    }

}

class TestRunner {

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
            test.outputFile = compiler.programPath + File.separator + test.outputFile
            int r = test.execute(compiler.programPath + "/DLXSimulator" + (group.identity.intValue()<10?"0":"") + group.identity.toString())
            result += "The execution of test case " + it.index
            if (r == -1)
                result += " fails\n"
            else
                result += " succeeds\n"
            result += test.result
            result += "\n"
        }

        // remove the temp folder recursively
//        def folder = new File(compiler.programPath)
//        if (folder.exists()) {
//            folder.deleteDir()
//        }

        return 0;
    }

}

//def r = new TestRunner(
//        tarFileName: "/Users/czb/Development/SimulatorContest/src/main/webapp/uploadFiles/simulator1.tar",
//        result: "")
//r.test(testSuite)
//println r.result
//new STestCase("","","","", 3).execute("sleep 10")