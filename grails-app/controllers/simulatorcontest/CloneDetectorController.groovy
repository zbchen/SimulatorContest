package simulatorcontest

class CloneDetectorController {

    def test() {
        println  servletContext.getRealPath("/")
        render "abc"
    }

    def index() {
        // create a folder for clone detection
        def d = new Date()
        def dateStr = d.format("yyyyMMdd")
        Random random = new Random()
        def folderName =  servletContext.getResource("/").getPath() + "clone_" + dateStr
        def folder = new File(folderName)
        // one day has just one folder for clone detection
        if (folder.exists()) {
            folder.deleteDir()
        } else {
            folder.mkdirs()
        }

        def resultName = servletContext.getResource("/").getPath() + "clone_" + dateStr + "_result"
        def resultFolder = new File(resultName)
        if (resultFolder.exists()) {
            resultFolder.deleteDir()
        } else {
            resultFolder.mkdirs()
        }

        // unpack the latest files of all groups
        def glist = ContestGroup.findAll()
        glist.each { it ->
            if (it.files.size() > 0) {
                // Unpack the latest file of each group
                String tarFileName = it.files[0].path
                String destination = folderName + "/" + it.identity
                def gfolder = new File(destination)
                if (gfolder.exists()) {
                    gfolder.deleteDir()
                    gfolder.mkdirs()
                } else {
                    gfolder.mkdirs()
                }
                def tarCommand = "tar -xf " + tarFileName + " -C " + destination
                def tarProcess = tarCommand.execute()
                def out = new StringBuffer()
                def err = new StringBuffer()
                tarProcess.consumeProcessOutput(out, err)
                tarProcess.waitFor()
                if (tarProcess.exitValue() != 0) {
                    println out.toString()
                    println err.toString()
                }
            }
        }

        // invoke jplag to do detection

        println folderName
        def jplagCommand = "java -jar /Users/czb/Downloads/jplag-2.11.8.jar -l c/c++ -s " + folderName + " -r " + resultName
        def jplagProcess = jplagCommand.execute()
        def out = new StringBuffer()
        def err = new StringBuffer()
        jplagProcess.consumeProcessOutput(out, err)
        jplagProcess.waitFor()
        println out.toString()
        println err.toString()

        //TODO move the results files to the public folder
        //TODO maybe extract the information later

        render "clone index"
    }

}
