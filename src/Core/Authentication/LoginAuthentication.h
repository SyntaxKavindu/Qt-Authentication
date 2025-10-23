#pragma once
#include <QObject>
#include <QSettings>
#include <QJsonObject>
#include <QJsonDocument>
#include <QNetworkAccessManager>
#include <QNetworkReply>

class LoginAuthentication : public QObject
{
    Q_OBJECT
public:

    explicit LoginAuthentication(QObject *parent = nullptr);
    bool remember();
    Q_INVOKABLE void setRemember(bool value);
    Q_INVOKABLE void authenticate(QString email,QString password);
    Q_INVOKABLE void verifyAuthenticate();
    void deleteAuthenticate();
    Q_INVOKABLE void fetechProfile();

private:
    QNetworkAccessManager *manager;
    bool m_loading;
    bool m_rememberMe;
    QString m_token;

private:
    void getToken();
    void saveToken();
    void clearToken();

signals:
    void loginSuccess();
    void autoLoginFailed();
    void loginFailed(const QString& error);
    void profileFetched(const QJsonObject& data);
    void profileFetchFailed(const QString &error);
    void deleteAuthenticateSuccess();
    void fetechProfileFail();
    void loadingChanged(bool loading);

};
