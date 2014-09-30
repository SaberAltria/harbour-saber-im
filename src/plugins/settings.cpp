#include "settings.h"
#include <QSettings>
#include <QString>
#include <QProcess>

Settings::Settings(QQuickItem *parent)
    : QQuickItem(parent)
{

}


void Settings::save(QString name, QString data)
{
    QSettings settings("SaberAltria", "harbour-saber");
    settings.setValue(name, data);
    settings.sync();

}

void Settings::restart()
{
    QProcess shell;
    shell.startDetached("systemctl", QStringList() << "--user" << "restart" << "maliit-server.service");
    //qDebug() << shell.errorString();


}

void Settings::backup()
{
    QProcess shell;
    shell.startDetached("mkdir", QStringList() << "/home/nemo/Saber");
    shell.startDetached("/bin/cp", QStringList() << "-rf" << "/usr/share/harbour-saber-im/tables.sqlite" << "/home/nemo/Saber/tables.sqlite");
    qDebug() << shell.errorString();


}

void Settings::restore()
{
    QProcess shell;
    shell.startDetached("/bin/cp", QStringList() << "-rf" << "/home/nemo/Saber/tables.sqlite" << "/usr/share/harbour-saber-im/tables.sqlite");
    qDebug() << shell.errorString();
}

QVariant Settings::load(QString name)
{
    QSettings settings("SaberAltria", "harbour-saber");
    return settings.value(name);

}
