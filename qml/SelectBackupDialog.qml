import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.simplydo 1.0

Dialog {
    property string backupPath

    acceptDestinationAction: PageStackAction.Pop

    DialogHeader {
        id: dialogHeader
        title: qsTr("Restore Files")
    }

    SilicaListView {
        model: backupModel
        anchors.top: dialogHeader.bottom
        anchors.bottom: parent.bottom
        width: parent.width

        delegate: ListItem {
            id: listItem

            Label {
                x: Theme.horizontalPageMargin
                width: parent.width - 2*Theme.horizontalPageMargin
                anchors.verticalCenter: parent.verticalCenter
                color: listItem.highlighted ? Theme.highlightColor : Theme.primaryColor
                text: model.filename
                elide: Text.ElideRight
            }
            onClicked: {
                backupPath = model.path
                console.warn(backupPath)
                accept()
            }
        }
    }

    BackupModel {
        id: backupModel
    }
}
