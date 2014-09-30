#ifndef DATABASE_H
#define DATABASE_H
#include <QSqlDatabase>
#include <QQuickItem>
#include <QList>
#include <QVariantList>
#include <QMap>

class Database : public QQuickItem
{

    Q_OBJECT

    public slots:
        void update(QString sql);
        void initial(QString name);
        void pinYin();


    public:
        Q_INVOKABLE QVariantList load(QString sql);
        Database(QQuickItem *parent = 0);
        QSqlDatabase db;
        QMap<QString, int> map;

};


#endif // DATABASE_H
