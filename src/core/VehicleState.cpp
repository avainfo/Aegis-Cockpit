#include "VehicleState.hpp"

VehicleState::VehicleState(QObject *parent) : QObject(parent) {
}

int VehicleState::speed() const { return speed_; }

void VehicleState::setSpeed(const int s) {
	if (s == speed_) return;
	speed_ = s;
	emit speedChanged();
}
