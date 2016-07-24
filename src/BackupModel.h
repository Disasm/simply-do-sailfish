#ifndef BACKUPMODEL_H
#define BACKUPMODEL_H

#include <QAbstractListModel>

class BackupModel : public QAbstractListModel
{
    Q_OBJECT
public:
    BackupModel();

    QHash<int, QByteArray> roleNames() const;

    int rowCount(const QModelIndex &parent = QModelIndex()) const;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

private:
    QList<QPair<QString, QString> > m_items;
};

#endif // BACKUPMODEL_H
