#include "DataManager.h"

#define DATABASE_NAME "simplydo.db"

DataManager::DataManager()
{
    /*m_db = QSqlDatabase::addDatabase("QSQLITE");
    m_db.setDatabaseName(DATABASE_NAME);
    if (!m_db.open())
    {
        return;
    }*/
}

void DataManager::createTables()
{
    /*m_db.exec("CREATE TABLE lists ("
            + "id INTEGER PRIMARY KEY,"
            + "label TEXT"
            + ");");
    m_db.exec("CREATE TABLE items ("
            + "id INTEGER PRIMARY KEY,"
            + "list_id INTEGER,"
            + "label TEXT,"
            + "active INTEGER,"
            + "star INTEGER"
            + ");");*/
}

