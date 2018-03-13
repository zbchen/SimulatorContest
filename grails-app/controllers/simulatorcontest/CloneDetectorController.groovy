package simulatorcontest

import jplag.ExitException
import jplag.JPlag
import jplag.Program
import jplag.options.CommandLineOptions
import jplag.options.Options

class MyCloneDetector extends Program {
    public MyCloneDetector(){
        super(null)
    }
    public MyCloneDetector(Options options) throws ExitException {
        super(options)
    }

    public String getSumissionString() {
        return super.allValidSubmissions(";")
    }
}

class CloneDetectorController {

    def download() {
        if (params["cid"] == null || !session["group"] || session["group"].identity != 75) {
            render "not valid"
            return
        }

        def r = CloneResult.findById(params.int("cid"))
        if (r) {
            def file = new File(r.path)
            if (file.exists()) {
                response.setContentType("application/octet-stream")
                response.setHeader("Content-disposition", "filename=${file.name}")
                response.outputStream << file.bytes
                return
            } else {
                render "File does not exist!!"
            }
        } else {
            render "not valid"
        }
    }

    def view() {
        if (params["cid"] == null || !session["group"]) {
            render "not valid"
            return
        }

        def r = CloneResult.findById(params.int("cid"))
        if (r) {
            render r.result
        } else {
            render "not valid"
        }
    }

    def delete(){
        if (params["cid"] == null || !session["group"] || session["group"].identity != 75) {
            render "not valid"
            return
        }

        def r = CloneResult.findById(params.int("cid"))
        if (r) {
            def f = new File(r.path)
            if (f.exists()) {
                f.delete()
            }
            r.delete(flush:true)
            redirect(uri:"/clone")
        } else {
            render "not valid"
        }
    }

    def start() {
        if (!session["group"] || session["group"].identity != 75) {
            render "not valid"
            return
        }

        // create a folder for clone detection
        def d = new Date()
        def dateStr = d.format("yyyy-MM-dd")
        Random random = new Random()
        def folderName =  "/CloneResults/" + "clone_" + dateStr
        def folder = new File(folderName)
        // one day has just one folder for clone detection
        if (folder.exists()) {
            folder.deleteDir()
        } else {
            folder.mkdirs()
        }

        def resultName = "/CloneResults/" + "clone_" + dateStr + "_result"
        def resultFolder = new File(resultName)
        if (resultFolder.exists()) {
            resultFolder.deleteDir()
        } else {
            resultFolder.mkdirs()
        }

        // unpack the latest files of all groups
        def glist = ContestGroup.findAll()
        glist.each { it ->
            if (it.identity != 75 && it.files.size() > 0) { // do not include the admin group
                // Unpack the latest file of each group
                String tarFileName = it.files[0].path
                String destination = folderName + "/" + it.id
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

        // invoke jplag to do detect

        String command = "-l c/c++ -s " + folderName + " -r " + resultName

        try {
            CommandLineOptions ex = new CommandLineOptions(command.split(" "), (String)null)
            ex.clustering = true
            ex.clusterType = 3
            MyCloneDetector program = new MyCloneDetector(ex)
            System.out.println("initialize ok")
            program.run()
            // generate the table of similarity
            String groupStr = program.getSumissionString()
            String[] groups = groupStr.split(";")
            String result = "<table><tr><th></th>"
            groups.each {
                result  = result + "<th>" + it + "</th>"
            }
            result += "</tr>"
            for (int i = 0; i < groups.size(); i++) {
                float total = 0.0
                String eachGroup = ""
                for (int j = 0 ; j < groups.size(); j ++) {
                    if (j == i) {
                        eachGroup  = eachGroup + "<th>  </th>"
                    } else {
                        eachGroup  = eachGroup + "<th>" + program.get_similarity().getSimilarity(i,j) + "%</th>"
                        total += program.get_similarity().getSimilarity(i,j)
                    }
                }
                result += "<tr>"
                result += ("<th>" + groups[i] + "(" + total + ")"  + "</th>")
                result += eachGroup
                result += "</tr>"
            }

            result += "</table>"

            // pack the result files
            def resultTarName = "/CloneResults/clone_" + dateStr + "_result.tar.gz"
            def file = new File(resultTarName)
            if (file.exists()) {
                file.delete()
            }
            def tarCommand = "tar -czf " + resultTarName + " -C " + resultName + " ."
            println tarCommand
            def tarProcess = tarCommand.execute()
            def out = new StringBuffer()
            def err = new StringBuffer()
            tarProcess.consumeProcessOutput(out, err)
            tarProcess.waitFor()
            if (tarProcess.exitValue() != 0) {
                println out.toString()
                println err.toString()
            }

            // Save the result to database
            def cloneResult = CloneResult.findByDate(dateStr)
            if (cloneResult) {
                cloneResult.result = result
                cloneResult.path = resultTarName
            } else {
                cloneResult = new CloneResult(date:dateStr, result:result, path:resultTarName)
            }
            cloneResult.save(flush:true)

        } catch (ExitException var3) {
            System.out.println("Error: " + var3.getReport())
        }

        // remove the folders
        folder.deleteDir()
        resultFolder.deleteDir()

        redirect(uri:"/clone")
    }

}
