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
TARGET = harbour-saber

CONFIG += sailfishapp

SOURCES += src/harbour-saber.cpp

OTHER_FILES += qml/harbour-saber.qml \
    qml/Cover.qml \
    rpm/harbour-saber.spec \
    translations/*.ts \
    harbour-saber.desktop \
    qml/Editor.qml \
    qml/Preference.qml

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-saber-de.ts

HEADERS +=

