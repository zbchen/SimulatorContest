package simulatorcontest

class UrlMappings {
    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(view: "/index")
        "/register"(view:"/register")
        "/user"(view:"/userfiles")
        "/bukao"(view:"/bukao");
        "/admin"(view:"/manager")
        "/muserfile"(view:"/manageUserFiles")
        "/menu"(view:"/menu")
        "/gadmin"(view:"/groupadmin")
        "/testsuite"(view:"/testsuite")
        "/addcase"(view:"/addcase")
        "/addpara"(view:"/addpara")
        "/changepasswd"(view:"/changepassword")
        "/clone"(view:"/clone")
        "/viewclone"(view:"/viewclone")
        "/comment"(view:"/comment1")
        "/updategrade"(view:"/updategrade")
        "/groupcomment"(view:"/groupcomment")
        "/gradelist"(view:"/gradelist")
        "/navbar"(view:"/NavBar")
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}
