#include "FpsCounter.hpp"
#include <QQuickWindow>

void FpsCounter::attach(const QQuickWindow *win) {
	if (!win) return;
	connect(
		win,
		&QQuickWindow::frameSwapped,
		this, &FpsCounter::onFrameSwapped
	);
	timer_.start();
}

void FpsCounter::onFrameSwapped() {
	++frames_;
	const qint64 ms = timer_.elapsed();
	if (ms >= 1000) {
		fps_ = frames_;
		frames_ = 0;
		timer_.restart();
		emit fpsChanged();
	}
}
