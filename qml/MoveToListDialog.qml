import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.simplydo 1.0

Component {
    Dialog {
        id: dialog
        property int listId

        acceptDestinationAction: PageStackAction.Pop

        DialogHeader {
            id: dialogHeader
            title: qsTr("Move To")
        }

        SilicaListView {
            model: globalModel
            anchors.top: dialogHeader.bottom
            anchors.bottom: parent.bottom
            width: parent.width

            delegate: ListItem {
                id: listItem
                enabled: model.id !== listId

                Label {
                    x: Theme.horizontalPageMargin
                    width: parent.width - 2*Theme.horizontalPageMargin
                    anchors.verticalCenter: parent.verticalCenter
                    color: listItem.highlighted ? Theme.highlightColor : ((model.id === listId) ? Theme.secondaryColor : Theme.primaryColor)
                    text: model.text
                    elide: Text.ElideRight
                }
                onClicked: {
                    listId = model.id
                    accept()
                }
            }
        }

        GlobalModel {
            id: globalModel
        }
    }
}
