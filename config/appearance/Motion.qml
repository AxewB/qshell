pragma ComponentBehavior: Bound
import Quickshell.Io

JsonObject {
    id: motion
    readonly property MotionSprings springs: MotionSprings {}
    readonly property MotionCurves curves: MotionCurves {}
    readonly property var durations: ({
        short:   [50, 100, 150, 200],
        medium:  [250, 300, 350, 400],
        long:    [450, 500, 550, 600],
        xlong:   [700, 800, 900, 1000]
    })

    component MotionSprings: JsonObject {
        readonly property var fast: ({
            spatial:   { damping: 0.4,  stiffness: 1400 },
            effects:   { damping: 1,  stiffness: 3800 }
        })
        readonly property var normal: ({
            spatial:   { damping: 0.4,  stiffness: 700 },
            effects:   { damping: 1,  stiffness: 1600 }
        })
        readonly property var slow: ({
            spatial:   { damping: 0.4,  stiffness: 300 },
            effects:   { damping: 1,  stiffness: 800 }
        })
    }
    component MotionCurves: JsonObject {
        readonly property var emphasized: ({
            accelerate: [0.3, 0, 0.8, 0.15],
            decelerate: [0.05, 0.7, 0.1, 1.0]
        })
        readonly property var standard: ({
            accelerate: [0.3, 0, 1, 1],
            decelerate: [0, 0, 0, 1]
        })
        readonly property var legacy: ({
            accelerate: [0.4, 0, 1, 1],
            decelerate: [0, 0, 0.2, 1]
        })
        readonly property list<int> linear: [0,0,1,1]
    }
}
