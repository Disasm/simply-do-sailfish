import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    TextField {
        id: listName
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: btnAdd.left

        placeholderText: "New List Name"
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

        header: PageHeader {
            title: "Simply Do"
        }

        delegate: ListItem {
            id: listItem
            menu: contextMenuComponent

            onClicked: {
                listModel.setListId(model.index)
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
                        enabled: false
                    }
                    MenuItem {
                        text: "Delete"
                        enabled: false
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

