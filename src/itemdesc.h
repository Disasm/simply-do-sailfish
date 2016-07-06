#ifndef ITEMDESC_H
#define ITEMDESC_H

#include <QString>

class ItemDesc
{
public:
    inline ItemDesc(int id, QString label, bool active, bool star)
    {
        m_id = id;
        m_label = label;
        m_active = active;
        m_star = star;
        m_sorted = false;
    }

private:
    int     m_id;
    QString m_label;
    bool    m_active;
    bool    m_star;
    bool    m_sorted;
};

#endif // ITEMDESC_H

