package simulatorcontest

class ContestGroup {

    String name
    String password
    Integer identity
    Float grade

    static hasMany = [students: Student, files: UploadFile]

    static constraints = {
    }
}
