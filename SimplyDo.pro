# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-simplydo

CONFIG += sailfishapp

QT += sql

SOURCES += src/SimplyDo.cpp \
    src/DataManager.cpp \
    src/GlobalModel.cpp \
    src/TODOListModel.cpp \
    src/DbList.cpp \
    src/DbItem.cpp

OTHER_FILES += \
    rpm/harbour-simplydo.changes.in \
    rpm/harbour-simplydo.spec \
    rpm/harbour-simplydo.yaml \
    translations/*.ts

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-simplydo-de.ts

HEADERS += \
    src/DataManager.h \
    src/itemdesc.h \
    src/GlobalModel.h \
    src/TODOListModel.h \
    src/DbList.h \
    src/DbItem.h

DISTFILES += \
    qml/MainPage.qml \
    qml/ListPage.qml \
    qml/SettingsPage.qml \
    harbour-simplydo.desktop \
    qml/harbour-simplydo.qml \
    qml/MoveToListDialog.qml \
    qml/EditNameDialog.qml

