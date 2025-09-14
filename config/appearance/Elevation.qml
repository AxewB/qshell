pragma ComponentBehavior: Bound
import Quickshell.Io
JsonObject {
    id: elevation
    property list<var> levels: [
        {  // 0
            shadow: { x: 0, y: 0, blur: 0, spread: 0, opacity: 0.0 },
            overlayOpacity: 0.0
        },
        { // 1
            shadow: { x: 0, y: 1, blur: 3, spread: 0, opacity: 0.2 },
            overlayOpacity: 0.05
        },
        { // 2
            shadow: { x: 0, y: 2, blur: 6, spread: 0, opacity: 0.25 },
            overlayOpacity: 0.08
        },
        { // 3
            shadow: { x: 0, y: 3, blur: 8, spread: 0, opacity: 0.3 },
            overlayOpacity: 0.11
        },
        { // 4
            shadow: { x: 0, y: 4, blur: 10, spread: 0, opacity: 0.35 },
            overlayOpacity: 0.12
        },
        { // 5
            shadow: { x: 0, y: 6, blur: 12, spread: 0, opacity: 0.4 },
            overlayOpacity: 0.14
        }
    ]
}
