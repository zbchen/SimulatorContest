package simulatorcontest

class TestSuiteController {

    def create() {
        if (!session["group"] || session["group"].identity != 75) {
            redirect(uri:"/")
            return
        }

        def suite = new TestCase(suite:params["name"], timeout:params["timeout"])
        suite.save(true)
        render "Test case is added " + suite.id
    }

    def index() {
        render "index"
    }

    def remove(){
        if (!session["group"] || session["group"].identity != 75) {
            redirect(uri:"/")
            return
        }

        def suite = TestCase.findById(params.int("sid"))

        if (suite) {
            // delete the files
            suite.paras.each { it ->
                File f = new File(it.path)
                if (f.exists()) {
                    f.delete()
                }
            }
            suite.delete(flush:true)
            redirect(uri:"/testsuite")
        } else {
            render "Test case does not exist!!"
        }
    }

    def addcase() {

        if (!session["group"] || session["group"].identity != 75) {
            redirect(uri:"/")
            return
        }

        //println "getting file"
        def f = request.getFile("myFile")
        if (f.empty) {
            def s = TestCase.findById(params.int("sid"))
            if (s) {
                def p = new Parameter(name:params["param"], path: "<none>")
                p.testcase = s
                p.save(flush:true)
            }

            render "param added successfully"
        } else {
            // Do file copy
            // make sure the "uploadFiles" folder exists
            def prefix = servletContext.getRealPath("/TestCases/") //"/TestCases/"
            def folder = new File(prefix)
            if (!folder.exists()) {
                folder.createNewFile()
            }
            def d = new Date()
            def dateStr = d.format("yyyyMMddHHmmss")
            Random random = new Random()
            def fileName =  prefix + dateStr + random.nextInt(1000)
            f.transferTo(new File(fileName))

            // record the uploaded file
            def s = TestCase.findById(params.int("sid"))
            if (s) {
                def p = new Parameter(name:params["param"], path: fileName)
                p.testcase = s
                p.save(flush:true)
            }

            render "param added successfully"

        }
    }
}
