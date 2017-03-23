package simulatorcontest

class TestResult {

    Float time
    String result

    static belongsTo = [file: UploadFile, testcase: TestCase]

    static constraints = {
        result blank: true, nullable: true
    }

    static mapping = {
        result type: 'text'
    }
}
