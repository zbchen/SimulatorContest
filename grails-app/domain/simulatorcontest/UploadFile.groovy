package simulatorcontest

class UploadFile {

    String name
    String uploadDate
    String path
    String result

    static belongsTo = [group: ContestGroup]

    static constraints = {
        result blank: true, nullable: true
    }

    static mapping = {
        result type: 'text'
    }

}
