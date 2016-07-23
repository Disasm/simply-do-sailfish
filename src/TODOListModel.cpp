#include "TODOListModel.h"
#include "DbList.h"

class SortComparator
{
public:
    bool operator()(const DbItem &left, const DbItem &right ) const
    {
        if (left.active() && !right.active()) return true;
        if (!left.active() && right.active()) return false;
        if (left.starred() && !right.starred()) return true;
        if (!left.starred() && right.starred()) return false;
        return left.label() < right.label();
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
    Q_UNUSED(parent)
    return m_items.size();
}

QVariant TODOListModel::data(const QModelIndex &index, int role) const
{
    int row = index.row();
    if (row < 0 || row >= m_items.size()) return QVariant();

    if (role == Qt::DisplayRole)
    {
        return m_items[row].label();
    }
    if (role == TODOListModel::InactiveRole)
    {
        return !m_items[row].active();
    }
    if (role == TODOListModel::StarredRole)
    {
        return m_items[row].starred();
    }
    return QVariant();
}

void TODOListModel::setListId(int id)
{
    layoutAboutToBeChanged();
    m_listId = id;
    DbList list = DbList::get(m_listId);

    m_items = list.getAllItems();
    sort();
    layoutChanged();

    listNameChanged();
}

int TODOListModel::listId()
{
    return m_listId;
}

QString TODOListModel::listName()
{
    DbList list = DbList::get(m_listId);
    return list.label();
}

void TODOListModel::addItem(QString name)
{
    DbList list = DbList::get(m_listId);
    if (!name.isEmpty())
    {
        layoutAboutToBeChanged();

        DbItem item = list.createItem(name, true, false);
        m_items.prepend(item);

        layoutChanged();
    }
}

void TODOListModel::removeItem(int index)
{
    if (index < 0 || index >= m_items.size()) return;

    layoutAboutToBeChanged();

    DbItem item = m_items[index];
    m_items.removeAt(index);
    item.remove();

    layoutChanged();
}

void TODOListModel::setLabel(int index, const QString &label)
{
    layoutAboutToBeChanged();

    m_items[index].setLabel(label);

    layoutChanged();
}

void TODOListModel::toggleStar(int index)
{
    if (index < 0 || index >= m_items.size()) return;

    layoutAboutToBeChanged();
    m_items[index].setStarred(!m_items[index].starred());
    layoutChanged();
}

void TODOListModel::toggleInactive(int index)
{
    if (index < 0 || index >= m_items.size()) return;

    layoutAboutToBeChanged();
    m_items[index].setActive(!m_items[index].active());
    layoutChanged();
}

void TODOListModel::moveToList(int index, int listId)
{
    if (listId == m_listId) return;

    layoutAboutToBeChanged();

    DbItem item = m_items[index];
    m_items.removeAt(index);
    item.setListId(listId);

    layoutChanged();
}

void TODOListModel::removeInactive()
{
    layoutAboutToBeChanged();

    int i = 0;
    while (i < m_items.size())
    {
        if (!m_items[i].active())
        {
            DbItem item = m_items[i];
            m_items.removeAt(i);
            item.remove();
        }
        else
        {
            i++;
        }
    }

    layoutChanged();
}

void TODOListModel::sort()
{
    qSort(m_items.begin(), m_items.end(), SortComparator());
}

void TODOListModel::sortAndUpdate()
{
    layoutAboutToBeChanged();
    sort();
    layoutChanged();
}
