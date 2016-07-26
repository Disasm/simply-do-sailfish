import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    function addList() {
        listModel.addItem(listName.text)
        listName.text = ""
    }

    TextField {
        id: listName
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        placeholderText: qsTr("New List Name")
        focus: false
        labelVisible: false
        EnterKey.onClicked: addList()
        EnterKey.text: qsTr("Add")
    }

    SilicaListView {
        id: listView
        model: listModel
        anchors.top: parent.top
        anchors.bottom: listName.top
        width: parent.width

        header: PageHeader {
            title: qsTr("Simply Do")
        }

        delegate: ListItem {
            id: listItem
            menu: contextMenuComponent
            function remove() {
                remorseAction(qsTr("Deleting"), function() { listModel.removeItem(index) })
            }
            ListView.onRemove: animateRemoval()

            onClicked: {
                itemModel.setListId(model.id)
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

            function openEditDialog() {
                var dialog = pageStack.push(editListNameDialog, { name: model.text })
                dialog.accepted.connect(function() {
                    listModel.setLabel(model.index, dialog.name)
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
                }
            }
        }

        ViewPlaceholder {
            enabled: listView.count == 0
            text: qsTr("No lists")
        }

        PullDownMenu {
            MenuItem {
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            }
        }
    }

    EditNameDialog {
        id: editListNameDialog
        titleText: qsTr("New List Name")
    }
}

