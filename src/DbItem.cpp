#include "DbItem.h"
#include <QSqlQuery>

DbItem::DbItem(int id, QString label, bool active, bool starred)
{
    m_id = id;
    m_label = label;
    m_active = active;
    m_starred = starred;
}

void DbItem::setLabel(const QString &label)
{
    m_label = label;
    updateField("label", m_label);
}

void DbItem::setActive(bool active)
{
    m_active = active;
    updateField("active", m_active);
}

void DbItem::setStarred(bool starred)
{
    m_starred = starred;
    updateField("star", m_starred);
}

void DbItem::setListId(int id)
{
    updateField("list_id", id);
}

void DbItem::remove()
{
    QSqlQuery query;
    query.prepare("DELETE FROM items WHERE id=?");
    query.bindValue(0, m_id);
    query.exec();
}

void DbItem::updateField(const char *name, const QVariant &value)
{
    QSqlQuery query;
    query.prepare(QString("UPDATE items SET %1=? WHERE id=?").arg(name));
    query.bindValue(0, value);
    query.bindValue(1, m_id);
    query.exec();
}
