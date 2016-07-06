import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    ListModel {
        id: listModel2

        ListElement {
            text: "A1"
            }
        ListElement {
            text: "A2"
        }
        ListElement {
            text: "A3"
        }
        ListElement {
            text: "A4"
        }
    }

    SilicaListView {
        model: listModel
        anchors.fill: parent
        delegate: BackgroundItem {
            Label { text: text11 }
        }
    }
}
