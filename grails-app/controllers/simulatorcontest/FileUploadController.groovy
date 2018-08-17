package simulatorcontest

class FileUploadController {

    def upload() {
      if (!session["group"]) {
        redirect(uri:"/")
        return
      } else {
        if (session["group"].students[0].grade >= 60) {
          render "upload is disabled"
          return
        }
      }

      //println "getting file"
      def f = request.getFile("myFile")
      if (f.empty) {
        render "Empty File"
      } else if (f.originalFilename.indexOf(".tar") < 0) {
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
        def fileName =  prefix + dateStr + random.nextInt(1000) + ".tar"
        println f
        f.transferTo(new File(fileName))

        // record the uploaded file
        def g = ContestGroup.findById(session["group"].id)
        println g
        if (g) {
          def file = new UploadFile(name: f.originalFilename, uploadDate: dateStr, path: fileName, result:"")
          file.group = g
          println file.save(flush:true)
        }

        redirect(uri:"/user")

      }

    }

    def remove(){
      if (!params["fid"] || !session["group"]) {
        redirect(uri:"/")
        return
      } else {
        render "remove is disabled"
        return
      }

      def f = UploadFile.findById(params.int("fid"))
      if (f) {
        if (f.group.id == session["group"].id || session["group"].identity == 75) {
          String fileName = f.path
          f.delete(flush:true)
          def file = new File(fileName)
          file.delete()
          redirect(uri:"/user")
        } else {
          render "Not your file, please!!!"
        }
      } else {
        render "The upload file of this ID does not exist!"
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

    def index() {
      render(view: "/fileupload")
    }

}
