package simulatorcontest

class ContestGroup {

    String name
    String password
    Integer identity
    Float grade

    static hasMany = [students: Student, files: UploadFile, comments: Comment]

    static mapping = {
        files sort : "id", order : "desc"
    }

    static constraints = {
    }
}
