#ifndef GLOBALMODEL_H
#define GLOBALMODEL_H

#include <QStringListModel>
#include <QList>
#include "DbList.h"

class GlobalModel : public QAbstractListModel
{
    Q_OBJECT
public:
    GlobalModel();

    QHash<int, QByteArray> roleNames() const;

    int rowCount(const QModelIndex &parent = QModelIndex()) const;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

public slots:
    void addItem(QString name);

    void removeItem(int index);

    void setLabel(int index, const QString &label);

    void refresh();

private:
    QList<DbList>   m_lists;
};

#endif // GLOBALMODEL_H
