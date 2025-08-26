cmake_minimum_required(VERSION 3.21)
project(AegisCockpit VERSION 0.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

set(QT_QML_GENERATE_QMLTYPES ON)

add_compile_options(-Wall -Wextra -Wpedantic)

find_package(Qt6 6.9 REQUIRED COMPONENTS Quick QuickControls2 Qml)

qt_policy(SET QTP0001 NEW)
qt_policy(SET QTP0004 NEW)

qt_add_executable(AegisCockpit
	main.cpp
	core/VehicleState.cpp
	ui/FpsCounter.cpp
	ui/FpsCounter.hpp
	hmi/src/ModeType.cpp
	hmi/include/ModeType.hpp
)

qt_add_qml_module(
	AegisCockpit
	URI Aegis
	VERSION 0.1.0
	OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/Aegis
	QML_FILES
	  Main.qml
	  qml/SpeedText.qml
	RESOURCES
	  assets/outline.png
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