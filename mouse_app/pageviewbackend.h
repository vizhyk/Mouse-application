#ifndef PAGEVIEWBACKEND_H
#define PAGEVIEWBACKEND_H

#include <QtCore>
#include <QNetworkAccessManager>
#include <QHttpPart>


class PageViewBackEnd : public QObject
{
        Q_OBJECT
public:
    PageViewBackEnd();
    //void createAccountRequest(QByteArray & postData);
public slots:
    void createAccountRequest();
    void onFinish(QNetworkReply *rep);
};

#endif // PAGEVIEWBACKEND_H
