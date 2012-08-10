package au.org.ala.phylojive

class Tree {
    String name
    String newick
    String identifyLifeDataset
    String popupTemplate

    static constraints = {
        name unique: true, blank: false
        newick blank: false, widget: 'textarea'
        popupTemplate widget: 'textarea'
    }

    static mapping = {
        newick type: 'text'
        popupTemplate type: 'text'
    }
}

