/* openos-settings — OPENOS 设置 App (独立进程)
 * 加载 Settings.qml (独立 Wayland 窗口), 使用 OPENUI 令牌。
 */

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlComponent>
#include <QQmlContext>
#include <QUrl>
#include "iconloader.h"
#include "iconprovider.h"
#include <QDebug>

int main(int argc, char** argv)
{
    QGuiApplication app(argc, argv);
    app.setApplicationName("openos-settings");
    app.setOrganizationName("OPENOS");
    app.setQuitOnLastWindowClosed(true);

    QQmlApplicationEngine engine;

    engine.addImageProvider(QStringLiteral("icons"), new IconProvider);
    IconLoader iconLoader(&app);
    engine.rootContext()->setContextProperty("_iconLoader", &iconLoader);

    // 加载 OPENUI 令牌 (共享自 OPENUI-desktop 资源)
    QQmlComponent token(&engine, QUrl(QStringLiteral("qrc:/qml/OpenUI.qml")));
    QObject* openUI = token.create();
    if (!openUI) {
        qCritical("OpenUI 令牌加载失败: %s",
                  qPrintable(token.errorString()));
        return 1;
    }
    engine.rootContext()->setContextProperty("OpenUI", openUI);

    engine.load(QUrl(QStringLiteral("qrc:/qml/Settings.qml")));
    if (engine.rootObjects().isEmpty()) {
        qCritical("设置 App 加载失败");
        return 1;
    }
    return app.exec();
}
