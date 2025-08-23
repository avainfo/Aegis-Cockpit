#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>

int main(int argc, char *argv[]) {
	QQuickStyle::setStyle("Basic");
	QGuiApplication app(argc, argv);
	qDebug() << "Hello World";

	QQmlApplicationEngine engine;

	using namespace Qt::StringLiterals;
	const QUrl url(u"qrc:/qt/qml/Aegis/Main.qml"_s);
	QObject::connect(
		&engine,
		&QQmlApplicationEngine::objectCreated,
		&app,
		[url](const QObject *obj, const QUrl &objUrl) {
			if (!obj && url == objUrl)
				QCoreApplication::exit(-1);
		},
		Qt::QueuedConnection
	);

	engine.load(url);
	return app.exec();
}

