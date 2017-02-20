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
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}
