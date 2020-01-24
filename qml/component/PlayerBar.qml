import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.3
import QtMultimedia 5.4

import "../VideoButton" as VB

import "../../qml"

Rectangle {

    id: toolBar

    property variant player

    anchors {
        left: parent.left
        right: parent.right
    }

    //Высота будет 5 процентов высоты всего экрана
    height: (appWindow.height * 0.05)
    color: "#5c5858"

    //Настроим слайдер
    Slider {
        id: temp

        anchors {
            left: toolBar.left
            right: toolBar.right
            leftMargin: toolBar.height * r.children.length + posTime.width / 2
            verticalCenter: toolBar.verticalCenter
            rightMargin: toolBar.height * 1.2 + toolTime.width / 2
        }

        property bool sync: false
        maximumValue: player.duration
        onValueChanged: {
            if (!sync)
                player.seek(value)
        }
        style: SliderStyle {
            groove: Rectangle {
                implicitWidth: parent.width
                implicitHeight: 8
                color: "gray"
                radius: 8
            }
            // control : Slider read-only
            handle: Rectangle {
                anchors.centerIn: parent
                color: control.pressed ? "white" : "lightgray"
                border.color: "gray"
                border.width: 2
                implicitWidth: toolBar.height * 0.4
                implicitHeight: toolBar.height * 0.4
                radius: toolBar.height * 0.2
            }
        }
        Connections {
            //Свяжем слайдет с воспроизведением видео
            //Чтобы при перетаскивании бегунка видео перматывалось
            target: player
            onPositionChanged: {
                temp.sync = true
                temp.value = player.position
                temp.sync = false
            }
        }
    }

    //Настройка таймера полного времени видео
    Label {
        // tool time;
        id: toolTime
        width: toolBar.height * 1.2
        height: toolBar.height
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.right: toolBar.right
        font.pointSize: toolBar.height / 5
        color: "white"

        //Время переведется в такой формат
        // 21 May 2001 14:13:09
        //var dateTime = new Date(2001, 5, 21, 14, 13, 09)
        readonly property int minutes: Math.floor(player.duration / 60000)
        readonly property int seconds: Math.round(
                                           (player.duration % 60000) / 1000)
        readonly property int hours: (player.duration / 3600000
                                      > 1) ? Math.floor(
                                                 player.duration / 3600000) : 0
        text: Qt.formatTime(new Date(0, 0, 0, hours, minutes, seconds),
                            qsTr("hh:mm:ss"))
    }

    //Строка элементов Row для описания кнопок и взаимодействия с ними
    Row {
        id: r
        anchors.verticalCenter: toolBar.verticalCenter

        VB.AboutButton {
            // menu
            width: toolBar.height
            height: toolBar.height
            onClicked: {
                about.open()
            }
        }

        VB.OpenFileButton {
            // open File
            width: toolBar.height
            height: toolBar.height

            onClicked: {
                fileBrowser.show()
                //appWindow.hide()
            }
        }

        VB.RewindButton {
            //rewind
            width: toolBar.height
            height: toolBar.height
            onClicked: {
                player.seek(player.position - 5000)
            }
        }

        VB.PlayOrPauseButton {
            // play or pause
            id: p_o_p
            width: toolBar.height
            height: toolBar.height
            onClicked: {
                player.playbackState === MediaPlayer.PlayingState ? player.pause(
                                                                        ) : player.play()
            }
            //Соединяем плеер с нажатием кнопки
            Connections {
                target: player
                onPlaybackStateChanged: {
                    switch (player.playbackState) {
                    case MediaPlayer.PlayingState:
                        //console.debug("PlayingState");
                        p_o_p.doItPlay = true
                        break
                    case MediaPlayer.PausedState:
                        //console.debug("PausedState");
                        p_o_p.doItPlay = false
                        break
                    case MediaPlayer.StoppedState:
                        //console.debug("StoppedState");
                        p_o_p.doItPlay = false
                        break
                    }
                }
            }
        }

        VB.StopButton {
            // stop
            width: toolBar.height
            height: toolBar.height
            onClicked: {
                player.stop()
            }
        }

        VB.SpeedButton {
            // speed
            width: toolBar.height
            height: toolBar.height
            onClicked: {
                player.seek(player.position + 5000)
            }
        }

        //Текущее время воспроизведения видео
        Label {
            // position time;
            id: posTime
            width: toolBar.height * 1.2
            height: toolBar.height
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: toolBar.height / 5
            color: "white"

            //Так переводим
            // 21 May 2001 14:13:09
            //var dateTime = new Date(2001, 5, 21, 14, 13, 09);
            readonly property int minutes: Math.floor(player.position / 60000)
            readonly property int seconds: Math.round(
                                               (player.position % 60000) / 1000)
            readonly property int hours: (player.position / 3600000
                                          > 1) ? Math.floor(
                                                     player.position / 3600000) : 0
            text: Qt.formatTime(new Date(0, 0, 0, hours, minutes, seconds),
                                qsTr("hh:mm:ss"))
        }
    }

    //    FileDialogWindow {
    //        id: fileDialog

    //        // Обработчик сигнала на открытие основного окна
    //        onExitFileDialog: {
    //            fileDialog.close() // Закрываем первое окно
    //            appWindow.show() // Показываем основное окно
    //        }
    //    }

    //Логика для кнопки о приложении
    //Простое текстовое сообщение
    MessageDialog {
        id: about
        title: "How to use"
        text: "VideoPlayer:
Здесь надо будет дописать какую нибудь инструкцию или информацию о текущем пользователе
короче пожно что нибудь придумать
"
        //Если нажали Ok то закрываем окошко
        onAccepted: {
            about.close()
        }
    }
}
