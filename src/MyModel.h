#ifndef MYMODEL_H
#define MYMODEL_H

#include <QStringListModel>
//#include <QtQml>

class MyModel : public QStringListModel {
    Q_OBJECT
public:
    MyModel();

    QHash<int, QByteArray> roleNames() const;

public slots:
    void set_me(int index);

};

#endif // MYMODEL_H
