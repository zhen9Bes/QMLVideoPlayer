import QtQuick 2.4

Image {
    id: openButton
    signal clicked
    source: "qrc:/icons/VideoDialog/open_.png"

    MouseArea {
        id: mouse
        anchors.fill: parent

        //Смена иконки кнопки в зависимости от нажатия
        onPressed: openButton.source = "qrc:/icons/VideoDialog/open.png"
        onReleased: openButton.source = "qrc:/icons/VideoDialog/open_.png"

        //Вывод пояснения для кнопки в зависимости от навидения мыши
        hoverEnabled: true
        onEntered: a.visible = true
        onExited: a.visible = false
    }

    //При нажатии или наведение мишкой на кнопочку меню, всплывет текст "Open file..."
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
        z: openButton.z + 2
        y: openButton.y - t.height
        color: "#fbed90"

        Text {
            id: t
            text: qsTr("Open file...")
            font.pointSize: openButton.width / 2
            horizontalAlignment: Text.AlignHCenter
            fontSizeMode: Text.VerticalFit
        }
    }
    Component.onCompleted: mouse.clicked.connect(clicked)
}
