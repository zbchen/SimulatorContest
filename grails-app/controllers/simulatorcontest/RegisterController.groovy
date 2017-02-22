package simulatorcontest

class RegisterController {

    def index() {
        def g = ContestGroup.findById(1);
        render g.files[0].name
    }

    def reg() {
        int number = params.int("groupnum")
        def g = ContestGroup.findByIdentity(number)
        if (g) {
            render "The group of this number already exists"
        } else if (number > 0 && number <= 50) {
            // do the registration
            def newGroup = new ContestGroup(name: params.get("groupname"),
                    password: params.get("password"),
                    identity: number, grade: 0)
            def student1 = new Student(name: params.get("name1"),
                    identity: params.get("num1"), grade: 0)
            def student2 = new Student(name: params.get("name2"),
                    identity: params.get("num2"), grade: 0)
            newGroup.addToStudents(student1)
            newGroup.addToStudents(student2)
            newGroup.save()
            render "Group created. Please <a href=\"../../\" >login</a>!"
        } else {
            render "Number should be between 1 .. 50 !"
        }
    }

}
