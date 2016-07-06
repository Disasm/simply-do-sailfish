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
    }


    TextField {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: btnAdd.left

        placeholderText: "New List Name"
        focus: false
    }

    Button {
        id: btnAdd
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        preferredWidth: Theme.buttonWidthSmall
        text: "Add"
    }

    SilicaListView {
        model: mainModel
        anchors.top: parent.top
        anchors.bottom: btnAdd.top
        width: parent.width
        delegate: ListItem {
            id: listItem
            menu: contextMenuComponent
            //width: view.width

            onClicked: {
                listModel.set_me(model.index);
                pageStack.push(Qt.resolvedUrl("ListPage.qml"))
            }

            Label {
                x: Theme.horizontalPageMargin
                anchors.verticalCenter: parent.verticalCenter
                color: listItem.highlighted ? Theme.highlightColor : Theme.primaryColor
                text: model.text
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
            }
        }
    }
}

