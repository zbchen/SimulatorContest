package simulatorcontest

class CloneResult {

    String date
    String result
    String path

    static constraints = {
        result blank: true, nullable: true
        path blank: true, nullable: true
    }

    static mapping = {
        result type: 'text'
    }

}
