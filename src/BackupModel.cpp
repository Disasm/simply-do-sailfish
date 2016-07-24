#include "BackupModel.h"
#include "DataManager.h"
#include <QFileInfo>

BackupModel::BackupModel()
{
    DataManager dm;
    QStringList backups = dm.getBackups();

    foreach (const QString &path, backups)
    {
        QFileInfo fi(path);

        m_items.append(qMakePair(fi.baseName(), path));
    }
}

QHash<int, QByteArray> BackupModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::DisplayRole] = "filename";
    roles[Qt::UserRole] = "path";
    return roles;
}

int BackupModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)

    return m_items.size();
}

QVariant BackupModel::data(const QModelIndex &index, int role) const
{
    int row = index.row();
    if (row < 0 || row >= m_items.size()) return QVariant();

    if (role == Qt::DisplayRole)
    {
        return m_items[row].first;
    }
    if (role == Qt::UserRole)
    {
        return m_items[row].second;
    }
    return QVariant();
}

