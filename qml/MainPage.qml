import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    ListModel {
        id: mainModel

        ListElement {
            text: "TODO List 1"
            }
        ListElement {
            text: "TODO List 2"
        }
        ListElement {
            text: "TODO List 3"
        }
        ListElement {
            text: "TODO List 4"
        }
        ListElement {
            text: "TODO List With Very Very Very Long Description"
        }
    }


    TextField {
        id: listName
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: btnAdd.left

        placeholderText: "New List Name"
        focus: false
        labelVisible: false
    }

    IconButton {
        id: btnAdd
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        icon.source: "image://theme/icon-m-add"
        onClicked: {
            globalModel.addItem(listName.text)
            listName.text = ""
        }
    }

    SilicaListView {
        model: globalModel
        anchors.top: parent.top
        anchors.bottom: btnAdd.top
        width: parent.width
        delegate: ListItem {
            id: listItem
            menu: contextMenuComponent

            onClicked: {
                listModel.set_me(model.index);
                pageStack.push(Qt.resolvedUrl("ListPage.qml"))
            }

            Label {
                x: Theme.horizontalPageMargin
                width: parent.width - 2*Theme.horizontalPageMargin
                anchors.verticalCenter: parent.verticalCenter
                color: listItem.highlighted ? Theme.highlightColor : Theme.primaryColor
                text: model.text
                elide: Text.ElideRight
            }

            Component {
                id: contextMenuComponent
                ContextMenu {
                    MenuItem {
                        text: "Edit"
                    }
                    MenuItem {
                        text: "Delete"
                    }
                }
            }
        }

        PullDownMenu {
            MenuItem {
                text: "Settings"
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            }
        }
    }
}

