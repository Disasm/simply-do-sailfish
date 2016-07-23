#ifndef DBITEM_H
#define DBITEM_H

#include <QObject>
#include <QVariant>

class DbItem
{
    Q_PROPERTY(int id READ id);
    Q_PROPERTY(QString label READ label WRITE setLabel);
    Q_PROPERTY(bool active READ active WRITE setActive);
    Q_PROPERTY(bool starred READ starred WRITE setStarred);

public:
    explicit DbItem(int id, QString label, bool active, bool starred);

    int id() const { return m_id; }
    QString label() const { return m_label; }
    bool active() const { return m_active; }
    bool starred() const { return m_starred; }

    void setLabel(const QString &label);
    void setActive(bool active);
    void setStarred(bool starred);

    void setListId(int id);

    void remove();

private:
    void updateField(const char* name, const QVariant &value);

signals:

private:
    int     m_id;
    QString m_label;
    bool    m_active;
    bool    m_starred;
};

#endif // DBITEM_H
