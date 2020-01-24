import QtQuick 2.4

Image {
    id: playButton
    signal clicked

    source: "qrc:/icons/VideoDialog/play_.png"

    // have not play
    property bool doItPlay: false

    //НАстраиваем иконки в зависимости от состояния воспроизведения видео(воспроизводится или нет)
    property url __sourcePressed: doItPlay ? "qrc:/icons/VideoDialog/pause.png" : "qrc:/icons/VideoDialog/play.png"
    property url __sourceReleased: doItPlay ? "qrc:/icons/VideoDialog/pause_.png" : "qrc:/icons/VideoDialog/play_.png"

    //Обработаем нажатия на клавишу PlayOrPauseButton
    MouseArea {
        id: mouse
        anchors.fill: parent
        onPressed: playButton.source = __sourcePressed
        onReleased: playButton.source = __sourceReleased

        hoverEnabled: true
        onEntered: a.visible = true
        onExited: a.visible = false
    }

    //Обработка смены иконок
    onDoItPlayChanged: {
        //console.debug("Play or Pause Button do it play ?",doItPlay);
        playButton.source = doItPlay ? "qrc:/icons/VideoDialog/pause_.png" : "qrc:/icons/VideoDialog/play_.png"
        playButton.__sourcePressed
                = doItPlay ? "qrc:/icons/VideoDialog/pause.png" : "qrc:/icons/VideoDialog//play.png"
        playButton.__sourceReleased = doItPlay ? "qrc:/icons/VideoDialog/pause_.png" : "qrc:/icons/VideoDialog/play_.png"
    }

    //При нажатии или наведение мишкой на кнопочку меню, всплывет текст "Play"
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
        z: playButton.z + 2
        y: playButton.y - t.height
        color: "#fbed90"

        Text {
            id: t
            text: qsTr("Play")
            font.pointSize: playButton.width / 2
            horizontalAlignment: Text.AlignHCenter
            fontSizeMode: Text.VerticalFit
        }
    }

    Component.onCompleted: mouse.clicked.connect(clicked)
}
