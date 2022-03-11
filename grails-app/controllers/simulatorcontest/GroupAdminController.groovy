package simulatorcontest

class GroupAdminController {

    def grade() {
        if (!params["gid"] || !session["group"] || session["group"].identity != 75) {
            redirect(uri:"/")
            return
        }

        int gid = params.int("gid")
        def g = ContestGroup.findById(gid)
        if (g) {
            g.grade = params["grade"].toString().toFloat()
            g.save(flush:true)
            response.setCharacterEncoding("gbk")
            PrintWriter out=response.getWriter()
            out.print("<script>self.opener.location.reload();window.close();</script>")
            render "Grade is updated"
        } else {
            render "Group does not exist"
        }

    }

    def remove() {
        /// check the authority
        if (!params["gid"] || !session["group"] || session["group"].identity != 75) {
            redirect(uri:"/")
            return
        }

        int gid = params.int("gid")
        def g = ContestGroup.findById(gid)
        if (g) {
//            g.students.each{ student ->
//                student.delete(flush:true)
//            }
//            g.files.each { file ->
//                println file
//            }
            // remove the files
            g.files.each{ file ->
                new File(file.path).delete()
            }
            g.delete(flush:true)
            render '1'
//            redirect (uri: "/gadmin")
        } else {
            render "Group does not exist"
        }
    }

    def index() {
        println "abc"
        redirect (uri: "/gadmin")
    }
}
