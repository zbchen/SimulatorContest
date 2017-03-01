package simulatorcontest

class ContestGroup {

    String name
    String password
    Integer identity
    Float grade

    static hasMany = [students: Student, files: UploadFile]

    static mapping = {
        files sort : "id", order : "desc"
    }

    static constraints = {
    }
}
