package simulatorcontest

class LoginController {

    def log() {
        def student = Student.findByName(params.get("username"))
        if (student) {
            if (student.group.password == params.get("password")) {
                //login success, record in session
                if (student.group.identity == 75) {
                    session["group"] = student.group
                    session["student"] = student
                    redirect(uri: "/user")
                } else {
                    render "Login is not enabled now"
                }
            } else {
                render "Login Fails: password is incorrect"
            }
        } else {
            render "Login Fails: user is not found"
        }
    }

    def logout() {
        session.removeAttribute("group")
        session.removeAttribute("student")
        redirect(uri: "/")
    }

    def index() {
        render "Hello World Login!"
    }

    def comment() {
        if (!session["group"]) {
            redirect(uri: "/")
        }

        if (params.get("comment")) {
            if (params.get("comment").length() < 100) {
                render("too short comment, which must contain more than 100 words")
            } else {
                def comment = Comment.findByGroup(session["group"])
                println comment
                def d = new Date()
                def dateStr = d.format("yyyyMMddHHmmss")
                //println params.get("comment")
                if (!comment) {
                    comment = new Comment(comment:params.get("comment"), commentDate:dateStr, group:session["group"])
                } else {
                    comment.comment = params.get("comment")
                    comment.commentDate = dateStr
                }
                //println comment
                comment.save(flush:true)
                render("Tks a lot for your support!")
            }
        } else {
            render("Invalid comment")
        }

    }
}
