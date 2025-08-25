#pragma once
#include <QObject>
#include <QElapsedTimer>

class QQuickWindow;

class FpsCounter final : public QObject {
	Q_OBJECT
	Q_PROPERTY(int fps READ fps NOTIFY fpsChanged)

public:
	explicit FpsCounter(QObject *parent = nullptr) : QObject(parent) {
	}

	void attach(const QQuickWindow *win);

	int fps() const { return fps_; }

signals:
	void fpsChanged();

private slots:
	void onFrameSwapped();

private:
	QElapsedTimer timer_;
	int frames_{0};
	int fps_{0};
};
