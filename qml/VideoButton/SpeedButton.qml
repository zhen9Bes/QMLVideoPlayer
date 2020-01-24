import QtQuick 2.4

Image {
    id:speedButton;
    signal clicked;

    source:"qrc:/icons/VideoDialog/speed_.png";

    MouseArea{
        id:mouse;
        anchors.fill:parent;

        onPressed: speedButton.source = "qrc:/icons/VideoDialog/speed.png";
        onReleased:  speedButton.source = "qrc:/icons/VideoDialog/speed_.png";

        hoverEnabled:true;
        onEntered: a.visible = true;
        onExited: a.visible = false;
    }

    //При нажатии или наведение мишкой на кнопочку меню, всплывет текст "Speed"
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
        z: speedButton.z + 2
        y: speedButton.y - t.height
        color: "#fbed90"

        Text {
            id: t
            text: qsTr("Speed")
            font.pointSize: speedButton.width / 2
            horizontalAlignment: Text.AlignHCenter
            fontSizeMode: Text.VerticalFit
        }
    }
    Component.onCompleted: mouse.clicked.connect(clicked);
}

