import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    function addItem() {
        itemModel.addItem(itemName.text)
        itemName.text = ""
    }

    TextField {
        id: itemName
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        placeholderText: qsTr("New Item Name")
        focus: false
        labelVisible: false
        EnterKey.onClicked: addItem()
        EnterKey.text: qsTr("Add")
    }

    RemorsePopup {
        id: removeInactiveRemorse
    }

    SilicaListView {
        id: listView
        model: itemModel
        anchors.bottom: itemName.top
        anchors.top: parent.top
        width: parent.width

        header: PageHeader {
            title: itemModel.listName
        }

        delegate: ListItem {
            id: listItem
            menu: contextMenuComponent
            function remove() {
                remorseAction(qsTr("Deleting"), function() { itemModel.removeItem(index) })
            }
            ListView.onRemove: animateRemoval()

            onClicked: itemModel.toggleInactive(model.index)

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

            function openEditDialog() {
                var dialog = pageStack.push(editItemNameDialog, { name: model.text })
                dialog.accepted.connect(function() {
                    itemModel.setLabel(model.index, dialog.name)
                })
            }

            function openMoveToDialog() {
                var dialog = pageStack.push(moveToListDialog, { listId: itemModel.listId() })
                dialog.accepted.connect(function() {
                    itemModel.moveToList(model.index, dialog.listId)
                })
            }

            Component {
                id: contextMenuComponent
                ContextMenu {
                    MenuItem {
                        text: qsTr("Edit")
                        onClicked: openEditDialog()
                    }
                    MenuItem {
                        text: qsTr("Delete")
                        onClicked: remove()
                    }
                    MenuItem {
                        text: model.starred ? qsTr("Remove Star") : qsTr("Add Star")
                        onClicked: itemModel.toggleStar(model.index)
                    }
                    MenuItem {
                        text: qsTr("Move To")
                        onClicked: openMoveToDialog()
                    }
                }
            }
        }

        ViewPlaceholder {
            enabled: listView.count == 0
            text: qsTr("No items")
        }

        PullDownMenu {
            MenuItem {
                text: qsTr("Delete All Inactive")
                onClicked: removeInactiveRemorse.execute(qsTr("Deleting inactive"), function() { itemModel.removeInactive() } )
            }
            MenuItem {
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            }
            MenuItem {
                text: qsTr("Sort Now")
                onClicked: itemModel.sortAndUpdate()
            }
        }

    }

    EditNameDialog {
        id: editItemNameDialog
        titleText: qsTr("New Item Name")
    }

    MoveToListDialog {
        id: moveToListDialog
    }
}
