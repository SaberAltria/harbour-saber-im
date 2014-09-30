TEMPLATE = aux

OTHER_FILES = pinYin.sqlite \
    tables.sqlite

tables.files = $${OTHER_FILES}
tables.path = /usr/share/harbour-saber-im

INSTALLS += tables
