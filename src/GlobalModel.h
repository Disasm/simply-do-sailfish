#ifndef GLOBALMODEL_H
#define GLOBALMODEL_H

#include <QStringListModel>

class GlobalModel : public QStringListModel
{
    Q_OBJECT
public:
    GlobalModel();

    QHash<int, QByteArray> roleNames() const;

public slots:
    void addItem(QString name);

    void removeItem(int index);

    void sortAndUpdate();

private:
    QStringList m_items;
};

#endif // GLOBALMODEL_H
