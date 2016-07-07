#include "TODOListModel.h"

class SortComparator
{
public:
    bool operator()(const TODOListModel::Item &left, const TODOListModel::Item &right ) const
    {
        if (!left.inactive && right.inactive) return true;
        if (left.inactive && !right.inactive) return false;
        return left.name < right.name;
    }
};

TODOListModel::TODOListModel()
{
}

QHash<int, QByteArray> TODOListModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::DisplayRole] = "text";
    roles[TODOListModel::InactiveRole] = "inactive";
    roles[TODOListModel::StarredRole] = "starred";
    return roles;
}

int TODOListModel::rowCount(const QModelIndex &parent) const
{
    return m_items.size();
}

QVariant TODOListModel::data(const QModelIndex &index, int role) const
{
    int row = index.row();
    if (row < 0 || row >= m_items.size()) return QVariant();

    if (role == Qt::DisplayRole)
    {
        return m_items[row].name;
    }
    if (role == TODOListModel::InactiveRole)
    {
        return m_items[row].inactive;
    }
    if (role == TODOListModel::StarredRole)
    {
        return m_items[row].starred;
    }
}

void TODOListModel::setListId(int id)
{
    beginResetModel();
    m_items.clear();
    for (int i = 0; i < 8; i++)
    {
        Item item;
        item.name = QString("TODO Item #%1 of list %2").arg(i).arg(id);
        item.inactive = (i % 2) == 1;
        item.starred = (i % 3) == 0;

        m_items.append(item);
    }
    sort();
    endResetModel();
}

void TODOListModel::addItem(QString name)
{
    if (!name.isEmpty())
    {
        beginResetModel();

        Item item;
        item.name = name;
        item.inactive = false;
        item.starred = false;

        m_items.prepend(item);

        endResetModel();
    }
}

void TODOListModel::removeItem(int index)
{
    beginResetModel();
    m_items.removeAt(index);
    endResetModel();
}

void TODOListModel::toggleStar(int index)
{
    beginResetModel();
    m_items[index].starred = !m_items[index].starred;
    endResetModel();
}

void TODOListModel::toggleInactive(int index)
{
    beginResetModel();
    m_items[index].inactive = !m_items[index].inactive;
    endResetModel();
}

void TODOListModel::removeInactive()
{
    beginResetModel();

    int i = 0;
    while (i < m_items.size())
    {
        if (m_items[i].inactive)
        {
            m_items.removeAt(i);
        }
        else
        {
            i++;
        }
    }

    endResetModel();
}

void TODOListModel::sort()
{
    qSort(m_items.begin(), m_items.end(), SortComparator());
}

void TODOListModel::sortAndUpdate()
{
    beginResetModel();
    sort();
    endResetModel();
}
