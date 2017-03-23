package simulatorcontest

class UploadFile {

    String name
    String uploadDate
    String path
    String result

    boolean isPass() {
        if (result) {
            if (result.count("succeeds") == 10) {
                return true
            } else {
                return false
            }
        }
        return false
    }

    static belongsTo = [group: ContestGroup]

    static hasMany = [results: TestResult]

    static constraints = {
        result blank: true, nullable: true
    }

    static mapping = {
        result type: 'text'
    }

}
