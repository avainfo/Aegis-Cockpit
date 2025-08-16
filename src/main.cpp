#include <QGuiApplication>

int main(int argc, char *argv[]) {
	const QGuiApplication app(argc, argv);
	qDebug() << "Hello World";
	return QGuiApplication::exec();
}
