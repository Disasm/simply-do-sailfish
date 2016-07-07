import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    TextField {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: btnAdd.left

        placeholderText: "New Item Name"
        focus: false
        labelVisible: false
    }

    IconButton {
        id: btnAdd
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        icon.source: "image://theme/icon-m-add"
    }

    SilicaListView {
        model: listModel
        anchors.bottom: btnAdd.top
        anchors.top: parent.top
        width: parent.width

        delegate: ListItem {
            id: listItem
            menu: contextMenuComponent

            Label {
                id: label
                x: Theme.horizontalPageMargin
                width: parent.width - Theme.horizontalPageMargin - star.width
                anchors.verticalCenter: parent.verticalCenter
                color: listItem.highlighted ? Theme.highlightColor : Theme.primaryColor

                text: text11
                elide: Text.ElideRight
                //font.strikeout: true
            }

            IconButton {
                id: star
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                icon.source: "image://theme/icon-s-new"
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

        ViewPlaceholder{}

        PullDownMenu {
            MenuItem {
                text: "Delete All Inactive"
            }
            MenuItem {
                text: "Settings"
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            }
            MenuItem {
                text: "Sort Now"
            }
        }

    }
}
