#include "DbList.h"
#include <QSqlQuery>
#include <QVariant>

DbList::DbList(int id, QString label)
{
    m_id = id;
    m_label = label;
}

void DbList::setLabel(const QString &label)
{
    m_label = label;

    QSqlQuery query;
    query.prepare("UPDATE lists SET label=? WHERE id=?");
    query.bindValue(0, m_label);
    query.bindValue(1, m_id);
    query.exec();
}

void DbList::remove()
{
    QSqlQuery query;
    query.prepare("DELETE FROM items WHERE list_id=?");
    query.bindValue(0, m_id);
    query.exec();

    query.prepare("DELETE FROM lists WHERE id=?");
    query.bindValue(0, m_id);
    query.exec();
}

DbList DbList::create(const QString &label)
{
    QSqlQuery query;
    query.prepare("INSERT INTO lists (label) VALUES (?)");
    query.bindValue(0, label);
    if (query.exec())
    {
        int id = query.lastInsertId().toInt();
        return DbList(id, label);
    }
    qFatal("Can't insert row into `lists`");
}

DbItem DbList::createItem(const QString &label, bool active, bool starred)
{
    QSqlQuery query;
    query.prepare("INSERT INTO items (list_id, label, active, star) VALUES (?, ?, ?, ?)");
    query.bindValue(0, m_id);
    query.bindValue(1, label);
    query.bindValue(2, active);
    query.bindValue(3, starred);
    if (query.exec())
    {
        int id = query.lastInsertId().toInt();
        return DbItem(id, label, active, starred);
    }
    qFatal("Can't insert row into `items`");
}

QList<DbItem> DbList::getAllItems()
{
    QList<DbItem> result;

    QSqlQuery query;
    query.prepare("SELECT id, label, active, star FROM items WHERE list_id=?");
    query.bindValue(0, m_id);
    query.exec();
    while (query.next())
    {
        int id = query.value(0).toInt();
        QString label = query.value(1).toString();
        bool active = query.value(2).toBool();
        bool starred = query.value(3).toBool();

        result.append(DbItem(id, label, active, starred));
    }
    return result;
}

QList<DbList> DbList::getAll()
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

DbList DbList::get(int id)
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
}
