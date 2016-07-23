import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    id: dialog
    property string name
    property string titleText: "New Name"

    canAccept: newName.text.length > 0
    acceptDestinationAction: PageStackAction.Pop

    onOpened: {
        newName.text = name
        newName.forceActiveFocus()
    }

    onDone: {
        if (result == DialogResult.Accepted) {
            name = newName.text
        }
    }

    DialogHeader {
        id: dialogHeader
    }

    TextField {
        id: newName
        anchors.top: dialogHeader.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        label: titleText
        EnterKey.onClicked: dialog.accept()
    }
}
