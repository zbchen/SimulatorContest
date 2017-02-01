package simulatorcontest

class Parameter {

    String name
    String path

    static belongsTo = [testcase: TestCase]

    static constraints = {
    }
}
