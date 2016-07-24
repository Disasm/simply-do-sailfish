import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.notifications 1.0
import harbour.simplydo 1.0

Page {
    id: page

    SilicaFlickable {
        anchors.fill: parent

        Column {
            PageHeader {
                title: "Settings"
            }

            ComboBox {
                width: page.width
                label: "Item Sorting"
                currentIndex: 1

                menu: ContextMenu {
                    MenuItem { text: "None" }
                    MenuItem { text: "Starred First" }
                    MenuItem { text: "Active First" }
                }
            }

            ComboBox {
                width: page.width
                label: "List Sorting"
                currentIndex: 1

                menu: ContextMenu {
                    MenuItem { text: "None" }
                    MenuItem { text: "Alphabetical" }
                }
            }

            ComboBox {
                width: page.width
                label: "Inactive Decoration"
                currentIndex: 0

                menu: ContextMenu {
                    MenuItem { text: "Strike/Grey" }
                    MenuItem { text: "Strike" }
                    MenuItem { text: "Grey" }
                }
            }

            TextSwitch {
                text: "Confirm Delete All Inactive"
                checked: true
            }

            ListItem {
                id: listItem1
                Label {
                    x: Theme.horizontalPageMargin
                    anchors.verticalCenter: parent.verticalCenter
                    color: listItem1.highlighted ? Theme.highlightColor : Theme.primaryColor
                    text: "Backup Now"
                }

                Notification {
                    id: backupNotification
                    summary: qsTr("Backup completed")
                    previewSummary: qsTr("Backup completed")
                }

                onClicked: {
                    var backupName = dataManager.generateBackupName()
                    if (dataManager.backup(backupName)) {
                        backupNotification.body = qsTr("Backed up to %1").arg("~/"+backupName)
                    } else {
                        backupNotification.body = qsTr("Backup failed")
                    }
                    backupNotification.previewBody = backupNotification.body

                    backupNotification.publish()
                }
            }

            ListItem {
                id: listItem2
                Label {
                    x: Theme.horizontalPageMargin
                    anchors.verticalCenter: parent.verticalCenter
                    color: listItem2.highlighted ? Theme.highlightColor : Theme.primaryColor
                    text: "Restore"
                }
            }
        }
    }

    DataManager {
        id: dataManager
    }
}

