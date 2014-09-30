#include "database.h"
#include <QDir>
#include <QtSql>
#include <QSqlDatabase>
#include <QFile>
#include <QObject>
#include <QSqlError>
#include <QSqlQuery>
#include <QQuickItem>
#include <QDebug>
#include <QVariantList>

Database::Database(QQuickItem *parent)
    : QQuickItem(parent)
 {

 }

void Database::initial(QString name)
{
    db = QSqlDatabase::addDatabase("QSQLITE", "database");
    name = "/usr/share/harbour-saber-im/" + name;
    db.setDatabaseName(name);
    db.open();

    QSqlQuery query(db);

    query.exec("PRAGMA synchronous = OFF");
    query.exec("PRAGMA journal_mode = OFF");
    query.exec("PRAGMA default_cache_size =65536");
    query.exec("PRAGMA foreign_keys = OFF");
    query.exec("PRAGMA count_changes = OFF");
    query.exec("PRAGMA temp_store = MEMORY");
    query.exec("PRAGMA locking_mode = EXCLUSIVE");

}


QVariantList Database::load(QString sql)
{

    QSqlDatabase db = QSqlDatabase::database("database");

    QVariantList temp;

    QSqlQuery query(db);

    query.prepare(sql);
    query.setForwardOnly(true);

    if( query.exec()) {

        while (query.next()) {
            temp.append(query.value(0).toString());
        }

        qDebug() << temp;
    }

    db.close();

    return temp;

}

void Database::update(QString sql)
{

    QSqlDatabase db = QSqlDatabase::database("database");

    QSqlQuery query(db);

    query.prepare(sql);
    query.setForwardOnly(true);

    if( query.exec() ) {
        //qDebug() << query.numRowsAffected();
    } else {
        //qDebug() << query.lastError();
    }

    db.close();
}

void Database::pinYin()
{

    map["one"] = 1;
    map["three"] = 3;
    map["seven"] = 7;


    qDebug() << map["one"];
}


