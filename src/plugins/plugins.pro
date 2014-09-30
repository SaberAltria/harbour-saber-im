TEMPLATE = lib
TARGET = harbour-saber-im
QT += qml quick sql
CONFIG += qt plugin

TARGET = $$qtLibraryTarget($$TARGET)
uri = harbour.saber.engine

# Input
SOURCES += \
database.cpp \
    engine.cpp \
    settings.cpp

HEADERS += \
database.h \
    engine.h \
    settings.h

OTHER_FILES = qmldir

# Install
installPath = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)

qmldir.files = qmldir
qmldir.path = $$installPath
target.path = $$installPath
INSTALLS += target qmldir
