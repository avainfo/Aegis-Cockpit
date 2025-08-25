#pragma once
#include <QObject>
#include <QtQml/qqmlregistration.h>

class ModeType : public QObject {
	Q_OBJECT
	QML_NAMED_ELEMENT(ModeType)
	QML_UNCREATABLE("Enum only")

public:
	explicit ModeType(QObject *parent = nullptr) : QObject(parent) {
	}

	enum Mode {
		Comfort,
		Sport,
		Eco
	};

	Q_ENUM(Mode)
};
