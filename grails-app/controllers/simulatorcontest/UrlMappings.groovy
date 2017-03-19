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
        "/clone"(view:"/clone")
        "/viewclone"(view:"/viewclone")
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}
