pragma ComponentBehavior
pragma Singleton
import Quickshell
import QtQuick
import "root:/service"

Singleton {
    property Modules modules: Modules {}

    component Modules: QtObject {
        property bool borders: true
        property bool fakeScreenRounding: true
    }
}
