#include "DataManager.h"
#include <QStandardPaths>
#include <QFileInfo>
#include <QDir>
#include <QtSql/QSqlQuery>

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
