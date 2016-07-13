#ifndef DBLIST_H
#define DBLIST_H

#include <QObject>
#include <QString>
#include "DbItem.h"

class DbList
{
    Q_PROPERTY(int id READ id);
    Q_PROPERTY(QString label READ label WRITE setLabel);

public:
    DbList(int id, QString label);

    int id() const { return m_id; }
    QString label() const { return m_label; }
    void setLabel(const QString &label);
    void remove();

    static DbList create(const QString &label);
    DbItem createItem(const QString &label, bool active, bool starred);
    QList<DbItem> getAllItems();

    static QList<DbList> getAll();
    static DbList get(int id);


private:
    int     m_id;
    QString m_label;
};

#endif // DBLIST_H

