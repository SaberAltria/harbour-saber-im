TEMPLATE = aux

OTHER_FILES = stroke.qml \
    StrokeHandler.qml \
    saberIM.conf \
    quick3.qml \
    quick5.qml \
    cangJie3.qml \
    cangJie5.qml \
    CangJieHandler.qml \
    canton.qml \
    CantonHandler.qml \
    t9PinYin.qml \
    T9PinYinHandler.qml \
    t9SouGou.qml \
    T9SouGouHandler.qml

qml.files = $${OTHER_FILES}
qml.path = /usr/share/maliit/plugins/com/jolla/layouts

INSTALLS += qml

