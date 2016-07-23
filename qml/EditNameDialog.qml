import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    id: dialog
    property string name
    property string titleText: "New Name"

    canAccept: newListName.text.length > 0
    acceptDestinationAction: PageStackAction.Pop

    onOpened: newListName.text = name

    onDone: {
        if (result == DialogResult.Accepted) {
            name = newListName.text
        }
    }

    DialogHeader {
        id: dialogHeader
        title: titleText
    }

    TextField {
        id: newListName
        anchors.top: dialogHeader.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        labelVisible: false
        EnterKey.onClicked: dialog.accept()
    }
}
