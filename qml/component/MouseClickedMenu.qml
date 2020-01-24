import QtQuick 2.4

//Опишем меню настроек
Rectangle {
    id: setMenu
    width: 70
    height: 100
    //Изначально менюшка спрятана
    y: 5
    x: -setMenu.width
    color: "#fbed90"
    opacity: 0.7
    z: parent.z + 10

    MouseArea {
        anchors.fill: setMenu
        drag.target: setMenu
        drag.axis: Drag.XAndYAxis
        onClicked: {
            setMenu.close()
        }
    }

    function open(_x, _y) {
        setMenu.x = _x
        setMenu.y = _y
    }
    function close() {

        setMenu.x = -setMenu.width
        setMenu.y = -setMenu.height
    }

    //Анимация скрытия
    Behavior on x {
        NumberAnimation {
            duration: 500
        }
    }
    Behavior on y {
        NumberAnimation {
            duration: 500
        }
    }
}
