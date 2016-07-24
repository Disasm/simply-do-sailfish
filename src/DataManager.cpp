#include "DataManager.h"
#include <QStandardPaths>
#include <QFileInfo>
#include <QDir>
#include <QtSql/QSqlQuery>
#include <QVariant>
#include <QDateTime>

#define DATABASE_NAME "simplydo.db"

QString DataManager::m_dbPath;
QSqlDatabase DataManager::m_db;

DataManager::DataManager()
{
}

void DataManager::initialize()
{
    QDir dir(QStandardPaths::writableLocation(QStandardPaths::DataLocation));

    m_dbPath = dir.absoluteFilePath(DATABASE_NAME);

    bool firstInit = !QFileInfo(m_dbPath).exists();

    m_db = QSqlDatabase::addDatabase("QSQLITE");
    m_db.setDatabaseName(m_dbPath);
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

QStringList DataManager::getBackups()
{
    QStringList nameFilter("*.simplydo");
    QDir dir(QStandardPaths::writableLocation(QStandardPaths::HomeLocation));
    QStringList files = dir.entryList(nameFilter, QDir::Files | QDir::NoSymLinks | QDir::Readable, QDir::Name | QDir::Reversed);

    QStringList paths;
    foreach (const QString &filename, files)
    {
        paths.append(dir.absoluteFilePath(filename));
    }
    return paths;
}

QString DataManager::generateBackupName()
{
    QDateTime dt = QDateTime::currentDateTime();
    QTime time = dt.time();
    int seconds = time.second() + 60*time.minute() + 3600*time.hour();
    return QString("SimplyDo_%1_%2.simplydo").arg(dt.toString("yyyyMMdd")).arg(seconds);
}

bool DataManager::backup(const QString &backupName)
{

    QDir dir(QStandardPaths::writableLocation(QStandardPaths::HomeLocation));

    m_db.close();
    bool ok = QFile::copy(m_dbPath, dir.absoluteFilePath(backupName));
    m_db.open();

    return ok;
}

bool DataManager::restore(const QString &backupPath)
{
    if (!QFileInfo(backupPath).isReadable()) return false;
    m_db.close();

    QFile f(m_dbPath);
    if (!f.remove()) return false;

    bool ok = QFile::copy(backupPath, m_dbPath);

    m_db.open();

    return ok;
}
