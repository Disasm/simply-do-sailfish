#include "MyModel.h"

MyModel::MyModel() {
    setStringList(QStringList() << "B1" << "B2");
}

QHash<int, QByteArray> MyModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[Qt::DisplayRole] = "text11";
    return roles;
}

void MyModel::set_me(int index) {
    QStringList s;
    for(int i = 0; i < 4; i++) {
        s << QString("B %1 %2").arg(index).arg(i);
    }
    setStringList(s);
}

