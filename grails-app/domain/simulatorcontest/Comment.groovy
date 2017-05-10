package simulatorcontest

class Comment {

    String comment
    String commentDate

    static belongsTo = [group: ContestGroup]

    static constraints = {
        comment blank: true, nullable: true
    }

    static mapping = {
        comment type: 'text'
    }

}
