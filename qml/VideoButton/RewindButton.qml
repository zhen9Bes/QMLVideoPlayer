import QtQuick 2.4

Image {
    id:rewindButton;
    signal clicked;
    source:"qrc:/icons/VideoDialog/rewind_.png";
    //Обработка нажатия на кнопку для смены иконки
    MouseArea{
        id:mouse;
        anchors.fill:parent;

        onPressed: rewindButton.source = "qrc:/icons/VideoDialog/rewind.png";
        onReleased:  rewindButton.source = "qrc:/icons/VideoDialog/rewind_.png";

        hoverEnabled:true;
        onEntered: a.visible = true;
        onExited: a.visible = false;
    }

    //При нажатии или наведение мишкой на кнопочку меню, всплывет текст "Rewind"
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
        z: rewindButton.z + 2
        y: rewindButton.y - t.height
        color: "#fbed90"

        Text {
            id: t
            text: qsTr("Rewind")
            font.pointSize: rewindButton.width / 2
            horizontalAlignment: Text.AlignHCenter
            fontSizeMode: Text.VerticalFit
        }
    }
    Component.onCompleted: mouse.clicked.connect(clicked);
}

