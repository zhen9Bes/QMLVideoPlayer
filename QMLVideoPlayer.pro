TEMPLATE = app

QT += qml quick widgets

SOURCES += \
        main.cpp

RESOURCES += qml.qrc \
    icons.qrc

# 为Windows添加程序图标
RC_FILE += ico.rc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
#qnx: target.path = /tmp/$${TARGET}/bin
#else: unix:!android: target.path = /opt/$${TARGET}/bin
#!isEmpty(target.path): INSTALLS += target

# Default rules for deployment.
include(PathSettings.pri)

