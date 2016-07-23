import QtQuick 2.0
import Sailfish.Silica 1.0

Component {
    Dialog {
        id: dialog
        property int listId

        //canAccept: newItemName.text.length > 0
        acceptDestinationAction: PageStackAction.Pop

        //onOpened: newItemName.text = name

        onDone: {
            if (result == DialogResult.Accepted) {
                name = newItemName.text
            }
        }

        DialogHeader {
            id: dialogHeader
            title: qsTr("Move To")
        }

        SilicaListView {
            model: globalModel
            anchors.top: dialogHeader.bottom

            delegate: ListItem {
                TextSwitch {
                    text: model.text
                    checked: model.id == listId
                }
            }
        }
    }
}
