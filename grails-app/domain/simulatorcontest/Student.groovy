package simulatorcontest

class Student {

    String name
    String identity
    Integer grade

    static belongsTo = [group: ContestGroup]

    static constraints = {
    }
}
