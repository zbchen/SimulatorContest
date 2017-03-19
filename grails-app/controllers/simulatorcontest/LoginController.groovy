package simulatorcontest

class LoginController {

    def log() {
        def student = Student.findByName(params.get("username"))
        if (student) {
            if (student.group.password == params.get("password")) {
                //login success, record in session
                session["group"] = student.group
                session["student"] = student
                redirect(uri: "/user")
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
}
