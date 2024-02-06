#include "pageviewbackend.h"

PageViewBackEnd::PageViewBackEnd() {}

void PageViewBackEnd::createAccountRequest()
{
    QUrl url = QUrl("http://104.248.32.201/auth/sign-up");
    QByteArray  postData(10, '\t');

    QNetworkAccessManager * mgr = new QNetworkAccessManager(this);

    connect(mgr,SIGNAL(finished(QNetworkReply*)),this,SLOT(onFinish(QNetworkReply*)));
    connect(mgr,SIGNAL(finished(QNetworkReply*)),mgr,SLOT(deleteLater()));

    QHttpMultiPart http;

    QHttpPart receiptPart;
    receiptPart.setHeader(QNetworkRequest::ContentDispositionHeader, QVariant("form-data; name=\"data\""));
    receiptPart.setBody(postData);

    http.append(receiptPart);

    mgr->post(QNetworkRequest(url), &http);
}


void PageViewBackEnd::onFinish(QNetworkReply *rep)
{

}
