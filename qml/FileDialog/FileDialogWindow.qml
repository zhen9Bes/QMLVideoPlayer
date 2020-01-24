import QtQuick 2.7
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.2

Window {
    id: fileDialogWindow
    signal exitFileDialog
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight
    visible: false
    title: qsTr("File Dialog")

    // Кнопка для открытия главного окна приложения
    FilePicker {
        anchors.fill: parent
        showDotAndDotDot: true
        //nameFilters: "*.mp4"
        onFileSelected: {

            //player.source = isFolder(fileName)
            //messageDialog.text = "Open file " + currentFolder(
            //) + "/" + fileName
            //messageDialog.open()
            player.source = currentFolder() + "/" + fileName
            fileDialogWindow.exitFileDialog()
        }
    }

    MessageDialog {
        id: messageDialog
        standardButtons: StandardButton.Ok
    }
}
