//
// Created by ava on 8/25/25.
//

#pragma once
#include <QObject>

class VehicleState final : public QObject {
	Q_OBJECT
	Q_PROPERTY(int speed READ speed NOTIFY speedChanged)

public:
	explicit VehicleState(QObject *parent = nullptr);

	int speed() const;

	void setSpeed(int s);

signals:
	void speedChanged();

private:
	int speed_{0};
};
