#ifndef TODOLISTMODEL_H
#define TODOLISTMODEL_H

#include <QStringListModel>

class TODOListModel : public QStringListModel
{
    Q_OBJECT
public:
    TODOListModel();

    QHash<int, QByteArray> roleNames() const;

public slots:
    void setListId(int id);

    void addItem(QString name);

    void removeItem(int index);

    void removeInactive();

    void sortAndUpdate();

private:
    QStringList m_items;
};

#endif // TODOLISTMODEL_H
