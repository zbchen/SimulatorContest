package simulatorcontest

class TestCase {

    String suite
    Integer timeout

    String getParamsString() {
        String paraStr = ""
        paras.each { it ->
            paraStr += it.name + " " + it.path + " "
        }
        return paraStr
    }

    static hasMany = [paras: Parameter]

    static constraints = {
    }
}
