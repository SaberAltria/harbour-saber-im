TEMPLATE = aux

OTHER_FILES = *.qml \
    emoji/*.png
qml.files = $${OTHER_FILES}
qml.path = /usr/share/maliit/plugins/com/jolla/saber

INSTALLS += qml
