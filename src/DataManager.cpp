#include "DataManager.h"
#include <QStandardPaths>
#include <QFileInfo>
#include <QDir>
#include <QtSql/QSqlQuery>
#include <QVariant>

#define DATABASE_NAME "simplydo.db"

DataManager::DataManager()
{
    QString dirPath = QStandardPaths::writableLocation(QStandardPaths::DataLocation);
    QDir dir(dirPath);
    dir = QDir(dir.absoluteFilePath("harbour-simplydo"));
    dir.mkpath(dir.absolutePath());

    QString dbPath = dir.absoluteFilePath(DATABASE_NAME);

    bool firstInit = !QFileInfo(dbPath).exists();

    m_db = QSqlDatabase::addDatabase("QSQLITE");
    m_db.setDatabaseName(dbPath);
    if (!m_db.open())
    {
        return;
    }

    if (firstInit)
    {
        m_db.exec("CREATE TABLE lists ("
                  "id INTEGER PRIMARY KEY,"
                  "label TEXT"
                  ");");
        m_db.exec("CREATE TABLE items ("
                  "id INTEGER PRIMARY KEY,"
                  "list_id INTEGER,"
                  "label TEXT,"
                  "active INTEGER,"
                  "star INTEGER"
                  ");");
    }
}

QList<DbList> DataManager::getAllLists()
{
    QList<DbList> result;

    QSqlQuery query;
    query.exec("SELECT id, label FROM lists");
    while (query.next())
    {
        int id = query.value(0).toInt();
        QString label = query.value(1).toString();
        result.append(DbList(id, label));
    }
    return result;
}

DbList DataManager::getList(int id)
{
    QSqlQuery query;
    query.prepare("SELECT label FROM lists where id=?");
    query.bindValue(0, id);
    query.exec();
    while (query.next())
    {
        QString label = query.value(0).toString();
        return DbList(id, label);
    }
    qFatal("List with id=%d is not found", id);
    throw 0;
}
