import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    Column {
        id: column
        spacing: Theme.paddingLarge
        width: parent.width

        Row {
            id: addListRow
            spacing: Theme.paddingLarge

            TextField {
                width: parent.width
                label: "Text field"
                placeholderText: "Type here"
                focus: true
                EnterKey.onClicked: {
                    text = "Return key pressed";
                    parent.focus = true;
                }
            }
            Button {
                text: "Add"
            }
        }

        SilicaListView {
            VerticalScrollDecorator {}

            id: listView
            anchors.fill: parent
            model: listModel

            delegate: ListItem {
                id: listItem
                menu: contextMenuComponent

                function remove() {
                    remorseAction("Deleting", function() { listModel.remove(index) })
                }
                ListView.onRemove: animateRemoval()

                onClicked: {
                    if (!menuOpen && pageStack.depth == 2) {
                        pageStack.push(Qt.resolvedUrl("MenuPage.qml"))
                    }
                }

                Label {
                    x: Theme.horizontalPageMargin
                    anchors.verticalCenter: parent.verticalCenter
                    text: model.text
                    font.capitalization: Font.Capitalize
                    color: listItem.highlighted ? Theme.highlightColor : Theme.primaryColor
                }

                Component {
                    id: contextMenuComponent
                    ContextMenu {
                        MenuItem {
                            text: "Delete"
                            //onClicked: remove()
                        }
                        MenuItem {
                            text: "Second option"
                        }
                    }
                }
            }
        }

        ListModel {
            id: listModel

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
    }
}

