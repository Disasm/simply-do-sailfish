#ifndef TODOLISTMODEL_H
#define TODOLISTMODEL_H

#include <QStringListModel>

class TODOListModel : public QAbstractListModel
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
    TODOListModel();

    QHash<int, QByteArray> roleNames() const;

    int rowCount(const QModelIndex &parent = QModelIndex()) const;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

public slots:
    void setListId(int id);

    void addItem(QString name);

    void removeItem(int index);

    void toggleStar(int index);

    void toggleInactive(int index);

    void removeInactive();

    void sort();

    void sortAndUpdate();

private:
    QList<Item> m_items;
};

#endif // TODOLISTMODEL_H
