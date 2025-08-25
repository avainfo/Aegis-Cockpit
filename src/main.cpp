#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickWindow>
#include <QTimer>
#include <QQuickStyle>
#include <QLoggingCategory>

#include "core/VehicleState.hpp"
#include "ui/FpsCounter.hpp"

using namespace Qt::StringLiterals;

Q_LOGGING_CATEGORY(logApp, "aegis.app")

int main(int argc, char *argv[]) {
	if (qEnvironmentVariableIsSet("AEGIS_USE_GLES"))
		QGuiApplication::setAttribute(Qt::AA_UseOpenGLES);

	QQuickStyle::setStyle("Basic");
	QGuiApplication app(argc, argv);

	QQmlApplicationEngine engine;

	VehicleState vehicle;
	FpsCounter fps(&app);

	engine.rootContext()->setContextProperty("vehicle", &vehicle);
	engine.rootContext()->setContextProperty("fps", &fps);

	engine.load(QUrl(u"qrc:/qt/qml/Aegis/Main.qml"_s));
	if (engine.rootObjects().isEmpty()) return 1;

	const auto *win = qobject_cast<QQuickWindow *>(engine.rootObjects().first());
	if (win)
		fps.attach(win);
	fps.attach(win);

	QTimer timer(&app);
	timer.setInterval(500);
	QObject::connect(&timer, &QTimer::timeout, [&] {
		static int v = 0;
		vehicle.setSpeed((v += 5) % 240);
	});
	timer.start();

	qCInfo(logApp) << "Aegis started";
	return QGuiApplication::exec();
}
