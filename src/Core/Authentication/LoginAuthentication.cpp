#include "LoginAuthentication.h"

LoginAuthentication::LoginAuthentication(QObject *parent)
    : QObject{parent}, manager{new QNetworkAccessManager(this)}, m_rememberMe{false}, m_loading{true}, m_token{}
{}

bool LoginAuthentication::remember()
{
    return m_rememberMe;
}

void LoginAuthentication::setRemember(bool value)
{
    if (m_rememberMe != value)
    {
        m_rememberMe = value;
    }
}

void LoginAuthentication::authenticate(QString email, QString password)
{
    m_loading = true;
    emit loadingChanged(m_loading);

    QUrl url("https://freeapi.miniprojectideas.com/api/User/Login");
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader,"application/json");

    QJsonObject payload;
    payload["EmailId"] = email;
    payload["Password"] = password;
    QJsonDocument doc(payload);
    QByteArray data(doc.toJson());

    QNetworkReply* reply = manager->post(request,data);

    QObject::connect(reply,&QNetworkReply::finished,this,[this,reply](){      
        if (reply->error() == QNetworkReply::NoError) {
            QByteArray responseData = reply->readAll();
            QJsonDocument responseDoc = QJsonDocument::fromJson(responseData);
            QJsonObject responseObj = responseDoc.object();

            bool status = responseObj.value("result").toBool(false);
            QString message = responseObj.value("message").toString("Unknown error");

            m_loading = false;
            if (status) {
                // success: extract token from data
                QJsonObject dataObj = responseObj.value("data").toObject();
                m_token = dataObj.value("token").toString();
                if (!m_token.isEmpty()) {
                    if(m_rememberMe)
                    {
                        saveToken();
                    }else
                    {
                        clearToken();
                    }
                    emit loginSuccess();
                } else {
                    emit loginFailed("Token missing in response");
                }
            } else {
                // failure but 200 OK
                emit loginFailed(message);
            }
        } else {
            emit loginFailed(reply->errorString());
        }
        reply->deleteLater();
    });
}

void LoginAuthentication::verifyAuthenticate()
{
    getToken();
    if(!m_token.isEmpty())
    {
        fetechProfile();
    }else
    {
        emit autoLoginFailed();
    }
}

void LoginAuthentication::deleteAuthenticate()
{
    m_token = "";
    clearToken();
    emit deleteAuthenticateSuccess();
}

void LoginAuthentication::fetechProfile()
{
    QUrl url("https://freeapi.miniprojectideas.com/api/User/GetUserByUserId?userId=6161");
    QNetworkRequest request(url);
    request.setRawHeader("Authorization", QString("Bearer %1").arg(m_token).toUtf8());

    QNetworkReply *reply = manager->get(request);

    connect(reply, &QNetworkReply::finished, this, [this, reply]() {
        if (reply->error() == QNetworkReply::NoError) {
            QByteArray responseData = reply->readAll();
            QJsonDocument responseDoc = QJsonDocument::fromJson(responseData);
            QJsonObject responseObj = responseDoc.object();

            bool status = responseObj.value("result").toBool(false);
            QString message = responseObj.value("message").toString("Unknown error");

            if (status) {
                QJsonObject dataObj = responseObj.value("data").toObject();
                emit profileFetched(dataObj);
            } else {
                clearToken();
                emit profileFetchFailed(message);
            }
        } else {
            clearToken();
            emit profileFetchFailed(reply->errorString());
        }
        reply->deleteLater();
    });
}

void LoginAuthentication::getToken()
{
    QSettings settings("Synatx", "Authentication");
    if (settings.contains("auth/token")) {
        m_token =  settings.value("auth/token").toString();
    }
}

void LoginAuthentication::saveToken()
{
    QSettings settings("Synatx", "Authentication");
    settings.setValue("auth/token", m_token);
}

void LoginAuthentication::clearToken()
{
    QSettings settings("Synatx", "Authentication");
    if (settings.contains("auth/token")) {
        settings.remove("auth/token");
    }
}
