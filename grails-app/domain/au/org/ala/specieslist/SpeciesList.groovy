package au.org.ala.specieslist

class SpeciesList {
    def authService

    String listName
    String firstName
    String surname
    String username
    String dataResourceUid
    String description
    String url
    String wkt
    Date dateCreated
    Date lastUpdated
    ListType listType
    Boolean isPrivate
    Boolean isSDS
    Boolean isBIE
    Long itemsCount = 0
    String region
    String authority
    String generalisation
    String category
    String sdsType

    static transients = [ "fullName" ]

    static hasMany = [items: SpeciesListItem, editors: String]

    static constraints = {
        url(nullable:true)
        description(nullable: true)
        wkt(nullable: true)
        listType nullable: true, index: 'idx_listtype'
        isPrivate nullable:true, index: 'idx_listprivate'
        isSDS nullable:true
        isBIE nullable:true
        firstName nullable: true
        surname nullable: true
        editors nullable: true
        region(nullable:  true)
        category nullable:  true
        generalisation(nullable: true)
        authority(nullable:  true)
        sdsType nullable:  true
    }

    static mapping = {
        items cascade: "all-delete-orphan"
        listType index: 'idx_listtype'
        username index: 'idx_username'
        isBIE index: 'idx_listbie'
        isSDS index: 'idx_listsds'
        wkt type: 'text'
        description type:  'text'
        itemsCount formula: "(select count(*) from species_list_item sli where sli.list_id = id)"
    }

    def String getFullName(){
        authService.getDisplayNameFor(username)
    }
}
