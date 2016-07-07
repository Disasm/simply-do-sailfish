#include "GlobalModel.h"

GlobalModel::GlobalModel()
{
    for (int i = 0; i < 5; i++)
    {
        m_items << QString("TODO List #%1").arg(i);
    }
    sortAndUpdate();
}

QHash<int, QByteArray> GlobalModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::DisplayRole] = "text";
    return roles;
}

void GlobalModel::addItem(QString name)
{
    if (!name.isEmpty())
    {
        m_items.append(name);
        sortAndUpdate();
    }
}

void GlobalModel::removeItem(int index)
{
    m_items.removeAt(index);
    setStringList(m_items);
}

void GlobalModel::sortAndUpdate()
{
    qSort(m_items);
    setStringList(m_items);
}
