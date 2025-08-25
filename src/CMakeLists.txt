cmake_minimum_required(VERSION 3.21)
project(AegisCockpit VERSION 0.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

add_compile_options(-Wall -Wextra -Wpedantic)

find_package(Qt6 6.9 REQUIRED COMPONENTS Quick QuickControls2 Qml)

qt_policy(SET QTP0001 NEW)
qt_policy(SET QTP0004 NEW)

qt_add_executable(AegisCockpit
	main.cpp
	core/VehicleState.cpp
	ui/FpsCounter.cpp
	ui/FpsCounter.hpp
)

qt_add_qml_module(
	AegisCockpit
	URI Aegis
	VERSION 0.1.0
	QML_FILES
	Main.qml
	qml/SpeedText.qml
	RESOURCES
	assets/outline.png
	SOURCES
	hmi/include/ModeType.hpp
	hmi/src/ModeType.cpp
)

target_include_directories(AegisCockpit PRIVATE
	${CMAKE_CURRENT_SOURCE_DIR}/hmi/include
)

target_link_libraries(AegisCockpit
	PRIVATE
	Qt6::Quick
	Qt6::QuickControls2
	Qt6::Qml
)