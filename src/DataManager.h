#ifndef DATAMANAGER_H
#define DATAMANAGER_H

#include <QtSql/QSqlDatabase>
#include <QList>
#include "DbList.h"

class DataManager
{
public:
    DataManager();

    QList<DbList> getAllLists();
    DbList getList(int id);

private:
    QSqlDatabase    m_db;
};

#endif // DATAMANAGER_H
