#ifndef DATAMANAGER_H
#define DATAMANAGER_H

#include <QtSql/QSqlDatabase>

class DataManager
{
public:
    DataManager();

private:
    QSqlDatabase    m_db;
};

#endif // DATAMANAGER_H
