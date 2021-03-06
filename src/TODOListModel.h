#ifndef TODOLISTMODEL_H
#define TODOLISTMODEL_H

#include <QStringListModel>
#include "DbItem.h"

class ItemModel : public QAbstractListModel
{
    Q_OBJECT

    enum CustomRole
    {
        InactiveRole = Qt::UserRole,
        StarredRole = Qt::UserRole+1,
    };

public:
    struct Item
    {
        QString name;
        bool inactive;
        bool starred;
    };

public:
    ItemModel();

    QHash<int, QByteArray> roleNames() const;

    int rowCount(const QModelIndex &parent = QModelIndex()) const;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

public:
    Q_PROPERTY(QString listName READ listName NOTIFY listNameChanged);

signals:
    void listNameChanged();

public slots:
    void setListId(int id);

    int listId();

    QString listName();

    void addItem(QString name);

    void removeItem(int index);

    void setLabel(int index, const QString &label);

    void toggleStar(int index);

    void toggleInactive(int index);

    void moveToList(int index, int listId);

    void removeInactive();

    void sort();

    void sortAndUpdate();

private:
    int             m_listId;
    QList<DbItem>   m_items;
};

#endif // TODOLISTMODEL_H
