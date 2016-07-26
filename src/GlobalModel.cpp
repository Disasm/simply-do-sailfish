#include "GlobalModel.h"

bool operator<(const DbList &left, const DbList &right)
{
    return left.label() < right.label();
}

ListModel::ListModel()
{
    m_lists = DbList::getAll();
    qSort(m_lists);
}

QHash<int, QByteArray> ListModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::DisplayRole] = "text";
    roles[Qt::UserRole] = "id";
    return roles;
}

int ListModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)

    return m_lists.size();
}

QVariant ListModel::data(const QModelIndex &index, int role) const
{
    int row = index.row();
    if (row < 0 || row >= m_lists.size()) return QVariant();

    if (role == Qt::DisplayRole)
    {
        return m_lists[row].label();
    }
    if (role == Qt::UserRole)
    {
        return m_lists[row].id();
    }
    return QVariant();
}

void ListModel::addItem(QString name)
{
    if (!name.isEmpty())
    {
        layoutAboutToBeChanged();

        DbList list = DbList::create(name);
        m_lists.append(list);
        qSort(m_lists);

        layoutChanged();
    }
}

void ListModel::removeItem(int index)
{
    layoutAboutToBeChanged();

    DbList list = m_lists[index];
    m_lists.removeAt(index);
    list.remove();

    layoutChanged();
}

void ListModel::setLabel(int index, const QString &label)
{
    layoutAboutToBeChanged();

    m_lists[index].setLabel(label);

    layoutChanged();
}

void ListModel::refresh()
{
    layoutAboutToBeChanged();

    m_lists = DbList::getAll();
    qSort(m_lists);

    layoutChanged();
}
