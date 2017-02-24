package simulatorcontest

class GroupAdminController {

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
            redirect (uri: "/gadmin")
        } else {
            render "Group does not exist"
        }
    }

    def index() {
        println "abc"
        redirect (uri: "/gadmin")
    }
}
