package simulatorcontest

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(view:"/index")
        "/register"(view:"/register")
        "/user"(view:"/userfiles")
        "/admin"(view:"/manager")
        "/menu"(view:"/menu")
        "/gadmin"(view:"/groupadmin")
        "/testsuite"(view:"/testsuite")
        "/addcase"(view:"/addcase")
        "/addpara"(view:"/addpara")
        "/changepasswd"(view:"/changepasswd")
        "/clone"(view:"/clone")
        "/viewclone"(view:"/viewclone")
        "/comment"(view:"/comment")
        "/updategrade"(view:"/updategrade")
        "/groupcomment"(view:"/groupcomment")
        "/gradelist"(view:"/gradelist")
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}
