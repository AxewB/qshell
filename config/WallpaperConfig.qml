import Quickshell.Io

JsonObject {
    property string source: ""
    property string name: ""

    function update() {

        console.log("updating name")
        name = source.
            split('.').slice(0, -1).    // removing extension
            join('.').                  // joining if file name has dots
            split("/").pop();           // getting name
    }

    onSourceChanged: update()
}
