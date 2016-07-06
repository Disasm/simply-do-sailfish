import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    ListModel {
        id: mainListModel

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
        label: "Text field"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: btnAdd.left

        placeholderText: "Type here"
        focus: true
    }
    Button {
        id: btnAdd
        anchors.top: parent.top
        anchors.right: parent.right
        text: "Add"
    }
    SilicaListView {
        model: mainListModel
        anchors.top: btnAdd.bottom
        anchors.bottom: parent.bottom
        width: parent.width
        delegate: BackgroundItem {
            //width: view.width
            Label { text: model.text }
            onClicked: {
                listModel.set_me(model.index);
                pageStack.push(Qt.resolvedUrl("ListPage.qml"))
            }
        }
    }



/*    Column {
        id: column
        spacing: Theme.paddingLarge
        //width: parent.width
        //anchors.fill: parent

        TextField {
            width: parent.width
            label: "Text field"
            placeholderText: "Type here1"
            focus: true
            EnterKey.onClicked: {
                text = "Return key pressed";
                parent.focus = true;
            }
        }
        TextField {
            width: parent.width
            label: "Text field"
            placeholderText: "Type here2"
            focus: true
            EnterKey.onClicked: {
                text = "Return key pressed";
                parent.focus = true;
            }
        }


        Row {
            id: addListRow
            spacing: Theme.paddingLarge

            TextField {
                //width: parent.width
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
            //anchors.bottom: parent.bottom
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
                    //anchors.verticalCenter: parent.verticalCenter
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
    }*/


}

