package simulatorcontest

class TestResult {

    Float time
    String result

    def isSuccess() {
        if (result.indexOf("fails") >= 0) {
            return false
        } else if (result.indexOf("succeeds") >= 0){
            return true
        }
        return false
    }

    def isTimeout() {
        return (result.indexOf("is timeout") >= 0)
    }

    static belongsTo = [file: UploadFile, testcase: TestCase]

    static constraints = {
        result blank: true, nullable: true
    }

    static mapping = {
        result type: 'text'
    }
}
