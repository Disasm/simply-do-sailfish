#ifndef DATAMANAGER_H
#define DATAMANAGER_H

#include <QObject>
#include <QtSql/QSqlDatabase>
#include <QList>
#include "DbList.h"

class DataManager : public QObject
{
    Q_OBJECT

public:
    DataManager();

    static void initialize();

    QList<DbList> getAllLists();
    DbList getList(int id);

public slots:
    QStringList getBackups();

    QString generateBackupName();

    bool backup(const QString &backupName);

    bool restore(const QString &backupPath);

private:
    static QString      m_dbPath;
    static QSqlDatabase m_db;
};

#endif // DATAMANAGER_H
