package simulatorcontest

import javafx.scene.Group

class FileUploadController {

    def upload() {
        if (!session["group"]) {
            redirect(uri: "/")
            return
        }
//      else {
//        if (session["group"].grade >= 60) {
//          render "You have passed, so upload is disabled"
//          return
//        } else {
//          render "disabled"
//          return
//        }
//      }

        //println "getting file"

        def f = request.getFile("myFile")
        println(f)
        if (f.empty) {
//            render '1'
            render "Empty File"
        } else if (f.originalFilename.indexOf(".tar") < 0) {
//            render '2'
            render "File type is wrong"
        } else {
            // Do file copy
            // make sure the "uploadFiles" folder exists
            def prefix = servletContext.getRealPath("/uploadFiles/")
            println prefix
            def folder = new File(prefix)
            if (!folder.exists()) {
                folder.mkdirs()
            }
            def d = new Date()
            def dateStr = d.format("yyyyMMddHHmmss")
            Random random = new Random()
            def fileName = prefix + dateStr + random.nextInt(1000) + ".tar"
            println f
            f.transferTo(new File(fileName))

            // record the uploaded file
            def g = ContestGroup.findById(session["group"].id)
            println g
            if (g) {
                def file = new UploadFile(name: f.originalFilename, uploadDate: dateStr, path: fileName, result: "")
                file.group = g
                println file.save(flush: true)
            }
//            render '3'
        redirect(uri:"/user")

        }

    }

    def remove() {
        if (!params["fid"] || !session["group"]) {
            redirect(uri: "/")
            return
        }
//      else {
//        render "remove is disabled"
//        return
//      }

        def f = UploadFile.findById(params.int("fid"))
        if (f) {
            if (f.group.id == session["group"].id || session["group"].identity == 75) {
                String fileName = f.path
                f.delete(flush: true)
                def file = new File(fileName)
                file.delete()
                render '1'
//          redirect(uri:"/user")
            } else {
                render '2'
//          render "Not your file, please!!!"
            }
        } else {
            render '3'
//        render "The upload file of this ID does not exist!"
        }
    }

    def download() {
        if (!params["fid"] || !session["group"]) {
            redirect(uri: "/")
            return
        }

        def f = UploadFile.findById(params.int("fid"))
        if (f) {
            if (f.group.id == session["group"].id || session["group"].identity == 75) {
                def file = new File(f.path)
                if (file.exists()) {
                    response.setContentType("application/octet-stream")
                    response.setHeader("Content-disposition", "filename=${f.name}")
                    response.outputStream << file.bytes
                    return
                } else {
                    render "File does not exist!!"
                }
            } else {
                render "Not your file, please!!!"
            }
        } else {
            render "The upload file of this ID does not exist!"
        }
    }

    def all() {
        if (!session["group"] || session["group"].identity != 75) {
            redirect(uri: "/")
            return
        }

        def commandStr = ""

        def groupList = ContestGroup.findAll([sort: "id", order: "asc"])
        groupList.each { g ->
            if (g.identity != 75 && g.files && g.files.size() > 0 && g.id <= 83) {
                def f = g.files[0]
                /// suppose only tar file

                def command = "cp " + f.path + " /root/2020/" + g.id + ".tar"
                commandStr += command + "\n"
                command.execute()
            }
        }

        render commandStr
    }

    def index() {
        render(view: "/fileupload")
    }

}
