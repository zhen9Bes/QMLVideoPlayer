import QtQuick 2.4
import QtQuick.Controls 1.3
import QtMultimedia 5.4
import QtQuick.Controls.Styles 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.2

//Подключаем обработку событий. Ошибок, нажатий на кнопки
import "./component"
import "./FileDialog"

ApplicationWindow {
    id: appWindow

    //property variant player
    //property string source
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight

    title: qsTr("Video Player")

    // use the QQmlApplicationEngine class  to load this qml file;
    // the ApplicationWindow's visible must set true;
    visible: true

    style: ApplicationWindowStyle {
        background: Rectangle {
            width: appWindow.width
            height: appWindow.height
            color: "blue"
        }
    }

    //Объект вывода видео
    VideoOutput {
        id: videoOutput
        source: mediaPlayer
        // Растягиваем объект главного окна по всему родительскому элементу
        anchors.fill: parent
        property alias totalTime: mediaPlayer.totalTime

        //Здесь мы связываем файл обработки ошибок и VideoOutput
        //То есть есть вдруг что то произойдет VideoOutput, то это сразу же обработается в ErrorDialog
        ErrorDialog {
            player: mediaPlayer
        }

        //Создадим область, для отображения пути текущего файла
        Rectangle {
            id: nameVideo

            //Делаем его прозрачным
            opacity: 0.3
            //Центруем по верху родительсокой области (videoOutput)
            anchors.top: parent.top
            anchors.topMargin: 0
            z: videoOutput + 2

            //Размеры области будут с размер текста
            width: t.width
            height: t.height
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter

            //Ну и для красоты рамку вокруг области
            border.color: "black"
            border.width: 1

            //Этот объект отвечает за движение текста
            Item {
                property string text: mediaPlayer.source
                property string spacing: "      "
                property string combined: text + spacing
                property string display: combined.substring(
                                             step) + combined.substring(0, step)
                property int step: 0

                Timer {
                    interval: 200
                    running: true
                    repeat: true
                    onTriggered: parent.step = (parent.step + 1) % parent.combined.length
                }
                //Теперь можно настроить сам текст пути к файлу
                Text {
                    id: t
                    color: white
                    font.pointSize: playButton.width / 2
                    fontSizeMode: Text.VerticalFit
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    //И отобразим его
                    text: parent.display
                }
            }
        }

        MediaPlayer {
            id: mediaPlayer
            loops: MediaPlayer.Infinite

            //property string source
            readonly property int minutes: Math.floor(
                                               mediaPlayer.duration / 60000)
            readonly property int seconds: Math.round(
                                               (mediaPlayer.duration % 60000) / 1000)
            readonly property int hours: (mediaPlayer.duration / 3600000
                                          > 1) ? Math.floor(
                                                     mediaPlayer.duration / 3600000) : 0
            readonly property string totalTime: Qt.formatTime(
                                                    new Date(0, 0, 0, hours,
                                                             minutes, seconds),
                                                    qsTr("hh:mm:ss"))
        }

        readonly property int minutes: Math.floor(mediaPlayer.position / 60000)
        readonly property int seconds: Math.round(
                                           (mediaPlayer.position % 60000) / 1000)
        readonly property int hours: (mediaPlayer.position / 3600000
                                      > 1) ? Math.floor(
                                                 mediaPlayer.position / 3600000) : 0
        readonly property string positionTime: Qt.formatTime(
                                                   new Date(0, 0, 0, hours,
                                                            minutes, seconds),
                                                   qsTr("hh:mm:ss"))

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.AllButtons
            onClicked: {
                if (mouse.button == Qt.LeftButton) {
                    mediaPlayer.playbackState
                            == MediaPlayer.PlayingState ? mediaPlayer.pause(
                                                              ) : mediaPlayer.play()
                }
                if (mouse.button == Qt.RightButton) {
                    menu.open(mouse.x, mouse.y)
                } else {
                    menu.close()
                }
            }
            onWheel: {
                // down
                if (wheel.angleDelta.y < 0) {
                    if (mediaPlayer.volume != 0)
                        mediaPlayer.volume -= 0.1
                } else if (wheel.angleDelta.y > 0) {
                    if (mediaPlayer.volume != 1)
                        mediaPlayer.volume += 0.1
                }
            }

            //=============================================================================================
            //Настройка элементов управления для винды
            focus: true
            Keys.onSpacePressed: mediaPlayer.playbackState
                                 == MediaPlayer.PlayingState ? mediaPlayer.pause(
                                                                   ) : mediaPlayer.play()
            Keys.onLeftPressed: mediaPlayer.seek(mediaPlayer.position - 5000)
            Keys.onRightPressed: mediaPlayer.seek(mediaPlayer.position + 5000)
            Keys.onEscapePressed: appWindow.visibility = Window.Windowed
            Keys.onReturnPressed: appWindow.visibility
                                  = (appWindow.visibility
                                     == Window.FullScreen) ? Window.Windowed : Window.FullScreen
            Keys.onUpPressed: {
                if (mediaPlayer.volume != 1) {
                    mediaPlayer.volume += 0.1
                }
            }
            Keys.onDownPressed: {
                if (mediaPlayer.volume != 0) {
                    mediaPlayer.volume -= 0.1
                }
            }
            Keys.onPressed: {
                // hide bar
                if ((event.key === Qt.Key_H)
                        && (event.modifiers & Qt.ControlModifier)) {
                    bar.visible = !bar.visible
                }

                if (event.key === Qt.Key_H) {
                    bar.visible = !bar.visible
                }
            }
        }

        FileBrowser {
            id: fileBrowser
            //target: PlayerBar
            //focus: true
            anchors.fill: parent
            //Когда FileBrowser выполнен т.е сигнал fileSelected отправлен надо вызвать функцию опен файл
            Component.onCompleted: fileSelected.connect(appWindow.openFile)
        }

        function openFile(path) {
            mediaPlayer.source = path
            mediaPlayer.play()
        }

        //        //=============================================================================================
        //        MouseClickedMenu {
        //            id: setMenu
        //            x: -100
        //            y: 0
        //            width: 100
        //            height: 135
        //            color: "#fbed90"
        //            Column {
        //                spacing: 10
        //                Rectangle {
        //                    width: setMenu.width
        //                    height: 20
        //                    color: "#fbed90"
        //                    Text {
        //                        anchors.centerIn: parent
        //                        text: qsTr("Settings")
        //                    }
        //                }
        //                Text {
        //                    text: (player.loops < 0) ? "Repeat video" : "Don't repeat video"
        //                    MouseArea {
        //                        anchors.fill: parent
        //                        onClicked: (player.loops != -1) ? (player.loops = MediaPlayer.Infinite) : (player.loops = 1)
        //                    }
        //                }

        //                Text {
        //                    text: bar.visible ? "Hide menu" : "Show menu"
        //                    MouseArea {
        //                        anchors.fill: parent
        //                        onClicked: bar.visible ? (bar.visible = false) : (bar.visible = true)
        //                    }
        //                }
        //            }
        //        }
    }

    //    MenuBar: MenuBar{

    //    }

    //    ToolBar: contentItem{

    //    }
    statusBar: PlayerBar {
        id: bar
        player: mediaPlayer
    }
}
