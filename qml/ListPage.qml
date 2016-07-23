import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    function addItem() {
        listModel.addItem(itemName.text)
        itemName.text = ""
    }

    TextField {
        id: itemName
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: btnAdd.left

        placeholderText: qsTr("New Item Name")
        focus: false
        labelVisible: false
        EnterKey.onClicked: addItem()
    }

    IconButton {
        id: btnAdd
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        icon.source: "image://theme/icon-m-add"
        onClicked: addItem()
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
                remorseAction(qsTr("Deleting"), function() { listModel.removeItem(index) })
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

            function openEditDialog() {
                var dialog = pageStack.push(editItemNameDialog, { name: model.text })
                dialog.accepted.connect(function() {
                    listModel.setLabel(model.index, dialog.name)
                })
            }

            function openMoveToDialog() {
                var dialog = pageStack.push(moveToListDialog, { listId: listModel.listId() })
                dialog.accepted.connect(function() {
                    listModel.moveToList(model.index, dialog.listId)
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
                        onClicked: listModel.toggleStar(model.index)
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
                onClicked: removeInactiveRemorse.execute(qsTr("Deleting inactive"), function() { listModel.removeInactive() } )
            }
            MenuItem {
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            }
            MenuItem {
                text: qsTr("Sort Now")
                onClicked: listModel.sortAndUpdate()
            }
        }

    }

    Component {
        id: editItemNameDialog

        Dialog {
            id: dialog
            property string name

            canAccept: newItemName.text.length > 0
            acceptDestinationAction: PageStackAction.Pop

            onOpened: newItemName.text = name

            onDone: {
                if (result == DialogResult.Accepted) {
                    name = newItemName.text
                }
            }

            DialogHeader {
                id: dialogHeader
                title: qsTr("New Item Name")
            }

            TextField {
                id: newItemName
                anchors.top: dialogHeader.bottom
                anchors.left: parent.left
                anchors.right: parent.right

                labelVisible: false
                EnterKey.onClicked: dialog.accept()
            }
        }
    }

    MoveToListDialog {
        id: moveToListDialog
    }
}
