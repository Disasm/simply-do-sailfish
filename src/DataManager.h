#ifndef DATAMANAGER_H
#define DATAMANAGER_H

#include <QtSql/QSqlDatabase>

class DataManager
{
public:
    DataManager();

    void createTables();

private:
    //QSqlDatabase    m_db;
};

#endif // DATAMANAGER_H
