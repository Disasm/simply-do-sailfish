import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    TextField {
        id: itemName
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
        onClicked: {
            listModel.addItem(itemName.text)
            itemName.text = ""
        }
    }

    RemorsePopup {
        id: removeInactiveRemorse
    }

    SilicaListView {
        id: listView
        model: listModel
        anchors.bottom: btnAdd.top
        anchors.top: parent.top
        width: parent.width

        header: PageHeader {
            title: listModel.listName
        }

        delegate: ListItem {
            id: listItem
            menu: contextMenuComponent
            function remove() {
                remorseAction("Deleting", function() { listModel.removeItem(index) })
            }
            ListView.onRemove: animateRemoval()

            onClicked: listModel.toggleInactive(model.index)

            Label {
                id: label
                x: Theme.horizontalPageMargin
                width: parent.width - Theme.horizontalPageMargin - star.width
                anchors.verticalCenter: parent.verticalCenter
                color: listItem.highlighted ? Theme.highlightColor : (model.inactive ? Theme.secondaryColor : Theme.primaryColor)

                text: model.text
                elide: Text.ElideRight
                font.strikeout: model.inactive
                font.italic: model.inactive
            }

            IconButton {
                id: star
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                icon.source: "image://theme/icon-s-favorite"
                visible: model.starred
                enabled: false
            }

            Component {
                id: contextMenuComponent
                ContextMenu {
                    MenuItem {
                        text: "Edit"
                        enabled: false
                    }
                    MenuItem {
                        text: "Delete"
                        onClicked: remove()
                    }
                    MenuItem {
                        text: model.starred ? "Remove Star" : "Add Star"
                        onClicked: listModel.toggleStar(model.index)
                    }
                    MenuItem {
                        text: "Move To"
                        enabled: false
                    }
                }
            }
        }

        ViewPlaceholder {
            enabled: listView.count == 0
            text: "No items"
        }

        PullDownMenu {
            MenuItem {
                text: "Delete All Inactive"
                onClicked: removeInactiveRemorse.execute("Removing inactive", function() { listModel.removeInactive() } )
            }
            MenuItem {
                text: "Settings"
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            }
            MenuItem {
                text: "Sort Now"
                onClicked: listModel.sortAndUpdate()
            }
        }

    }
}
