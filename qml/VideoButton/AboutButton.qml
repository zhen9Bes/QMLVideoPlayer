import QtQuick 2.4

//В блоке Image настраиваем иконки для кнопок
Image {
    id: aboutButton
    signal clicked
    property alias tFontpointSize: t.font.pointSize
    source: "qrc:/icons/VideoDialog/menu_.png"

    MouseArea {
        id: mouse
        anchors.fill: parent

        //Смена иконки кнопки в зависимости от нажатия
        onPressed: aboutButton.source = "qrc:/icons/VideoDialog/menu.png"
        onReleased: aboutButton.source = "qrc:/icons/VideoDialog/menu_.png"

        //Вывод пояснения для кнопки в зависимости от навидения мыши
        hoverEnabled: true
        onEntered: a.visible = true
        onExited: a.visible = false
    }

    //При нажатии или наведение мишкой на кнопочку меню, всплывет текст "About..."
    Rectangle {
        id: a
        //Изначально этот текст не виден
        visible: false

        //Размеры области будут с размер текста
        width: t.width
        height: t.height

        //Ну и для красоты рамку вокруг области
        border.color: "black"
        border.width: 1

        //Делаем его немного прозрачным
        opacity: 0.8
        z: aboutButton.z + 2
        y: aboutButton.y - t.height

        //Цвет фона для поясненительного текста
        color: "#fbed90"
        Text {
            id: t
            text: qsTr("About...")
            font.pointSize: aboutButton.width / 2
            horizontalAlignment: Text.AlignHCenter
            fontSizeMode: Text.VerticalFit
        }
    }

    //Если кликнули мышкой по кнопке, то отправляем сигнал clicked
    Component.onCompleted: mouse.clicked.connect(clicked)
}
