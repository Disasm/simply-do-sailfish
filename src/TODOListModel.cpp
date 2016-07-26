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

ItemModel::ItemModel()
{
}

QHash<int, QByteArray> ItemModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::DisplayRole] = "text";
    roles[ItemModel::InactiveRole] = "inactive";
    roles[ItemModel::StarredRole] = "starred";
    return roles;
}

int ItemModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_items.size();
}

QVariant ItemModel::data(const QModelIndex &index, int role) const
{
    int row = index.row();
    if (row < 0 || row >= m_items.size()) return QVariant();

    if (role == Qt::DisplayRole)
    {
        return m_items[row].label();
    }
    if (role == ItemModel::InactiveRole)
    {
        return !m_items[row].active();
    }
    if (role == ItemModel::StarredRole)
    {
        return m_items[row].starred();
    }
    return QVariant();
}

void ItemModel::setListId(int id)
{
    layoutAboutToBeChanged();
    m_listId = id;
    DbList list = DbList::get(m_listId);

    m_items = list.getAllItems();
    sort();
    layoutChanged();

    listNameChanged();
}

int ItemModel::listId()
{
    return m_listId;
}

QString ItemModel::listName()
{
    DbList list = DbList::get(m_listId);
    return list.label();
}

void ItemModel::addItem(QString name)
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

void ItemModel::removeItem(int index)
{
    if (index < 0 || index >= m_items.size()) return;

    layoutAboutToBeChanged();

    DbItem item = m_items[index];
    m_items.removeAt(index);
    item.remove();

    layoutChanged();
}

void ItemModel::setLabel(int index, const QString &label)
{
    layoutAboutToBeChanged();

    m_items[index].setLabel(label);

    layoutChanged();
}

void ItemModel::toggleStar(int index)
{
    if (index < 0 || index >= m_items.size()) return;

    layoutAboutToBeChanged();
    m_items[index].setStarred(!m_items[index].starred());
    layoutChanged();
}

void ItemModel::toggleInactive(int index)
{
    if (index < 0 || index >= m_items.size()) return;

    layoutAboutToBeChanged();
    m_items[index].setActive(!m_items[index].active());
    layoutChanged();
}

void ItemModel::moveToList(int index, int listId)
{
    if (listId == m_listId) return;

    layoutAboutToBeChanged();

    DbItem item = m_items[index];
    m_items.removeAt(index);
    item.setListId(listId);

    layoutChanged();
}

void ItemModel::removeInactive()
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

void ItemModel::sort()
{
    qSort(m_items.begin(), m_items.end(), SortComparator());
}

void ItemModel::sortAndUpdate()
{
    layoutAboutToBeChanged();
    sort();
    layoutChanged();
}
