#ifndef ENGINE_H
#define ENGINE_H

#include <QQmlExtensionPlugin>

class Engine : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void registerTypes(const char *uri);
};

#endif // ENGINE_H
