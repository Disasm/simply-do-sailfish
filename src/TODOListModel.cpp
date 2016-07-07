#include "TODOListModel.h"

TODOListModel::TODOListModel()
{
}

QHash<int, QByteArray> TODOListModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::DisplayRole] = "text";
    return roles;
}

void TODOListModel::setListId(int id)
{
    m_items.clear();
    for (int i = 0; i < 8; i++)
    {
        m_items << QString("TODO Item #%1 of list %2").arg(i).arg(id);
    }
    sortAndUpdate();
}

void TODOListModel::addItem(QString name)
{
    if (!name.isEmpty())
    {
        m_items.prepend(name);
        setStringList(m_items);
    }
}

void TODOListModel::removeItem(int index)
{
    m_items.removeAt(index);
    setStringList(m_items);
}

void TODOListModel::removeInactive()
{
    //
}

void TODOListModel::sortAndUpdate()
{
    qSort(m_items);
    setStringList(m_items);
}
