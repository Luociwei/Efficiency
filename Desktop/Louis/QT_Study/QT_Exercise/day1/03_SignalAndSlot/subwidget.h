#ifndef SUBWIDGET_H
#define SUBWIDGET_H

#include <QWidget>

class SubWidget : public QWidget
{
    Q_OBJECT
public:
    explicit SubWidget(QWidget *parent = nullptr);

signals:

};

#endif // SUBWIDGET_H
