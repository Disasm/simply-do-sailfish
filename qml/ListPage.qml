import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    TextField {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: btnAdd.left

        placeholderText: "New Item Name"
        focus: false
    }

    Button {
        id: btnAdd
        anchors.top: parent.top
        anchors.right: parent.right
        preferredWidth: Theme.buttonWidthSmall
        text: "Add"
    }

    SilicaListView {
        model: listModel
        anchors.top: btnAdd.bottom
        anchors.bottom: parent.bottom
        width: parent.width

        delegate: ListItem {
            id: listItem
            menu: contextMenuComponent

            Label {
                text: text11
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
                    MenuItem {
                        text: "Add Star"
                    }
                    MenuItem {
                        text: "Move To"
                    }
                }
            }
        }

        PullDownMenu {
            MenuItem {
                text: "Delete All Inactive"
            }
            MenuItem {
                text: "Settings"
            }
            MenuItem {
                text: "Sort Now"
            }
        }
    }
}
