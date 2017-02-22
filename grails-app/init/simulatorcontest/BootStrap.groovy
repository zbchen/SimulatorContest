package simulatorcontest

class BootStrap {

    def init = { servletContext ->
        /// add the admin data if not exists
        def g = ContestGroup.findByName("test_group")
        if (!g) {
            def adminGroup = new ContestGroup(identity:75, name: "test_group", password:"test123", grade:0)
            def s1 = new Student(name:"czb", identity: "123", grade: 0)
            def s2 = new Student(name:"czb1", identity: "234", grade: 0)
            adminGroup.addToStudents(s1)
            adminGroup.addToStudents(s2)
            adminGroup.save(flush:true)
            println adminGroup
        }
    }

    def destroy = {

    }

}
