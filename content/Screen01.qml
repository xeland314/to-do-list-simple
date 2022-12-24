/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/

import QtQuick 6.2
import QtQuick.Controls 6.2
import ToDoList
import QtQuick.Layouts 1.0
import QtQuick.Studio.EventSystem 1.0

Rectangle {
    id: rectangle
    width: Constants.width
    height: Constants.height
    color: "#ffffff"
    border.color: "#ffffff"
    property bool isDialogOpen: false


    Rectangle {
        id: addToDoDialog
        x: 8
        y: 600
        width: 584
        height: 146
        visible: rectangle.isDialogOpen
        color: "#e0e0e0"
        radius: 30

        TextField {
            id: toDoTextInput
            width: 225
            height: 40
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            font.pointSize: 12
            anchors.rightMargin: 25
            anchors.leftMargin: 25
            anchors.topMargin: 25
            placeholderText: qsTr("Add to do...")
        }

        RowLayout {
            y: 106
            width: 537
            height: 40
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 25
            anchors.leftMargin: 25
            anchors.bottomMargin: 25
            spacing: 10

            Button {
                id: cancelButton
                width: 250
                height: 40
                text: qsTr("Cancel")
                Layout.fillHeight: true
                font.pointSize: 12
                Layout.fillWidth: true

                Connections {
                    target: cancelButton
                    onClicked: rectangle.isDialogOpen = false
                }

                Connections {
                    target: cancelButton
                    onClicked: toDoTextInput.text = ""
                }
            }

            Button {
                id: addButton
                height: 40
                text: "Add"
                Layout.fillHeight: true
                font.pointSize: 12
                Layout.fillWidth: true

                Connections {
                    target: addButton
                    onClicked: rectangle.isDialogOpen = false
                }

                Connections {
                    target: addButton
                    onClicked: myListModel.append(myListModel.createListElement())
                }
            }
        }
    }

    ScrollView {
        id: scrollView
        x: 8
        y: 57
        width: 584
        height: 532

        Column {
            id: column
            x: 0
            y: 0
            width: 584
            height: 532
            spacing: 20

            Repeater {
                id: repeater
                anchors.fill: parent
                model: ListModel {
                    id: myListModel
                    ListElement {
                        name: "My To Do"
                    }
                    function createListElement() {
                        return {
                            "name": toDoTextInput.text
                        }
                    }
                }

                Rectangle {
                    id: toDoItem
                    x: 0
                    y: 72
                    width: 583
                    height: 59
                    color: "#e0e0e0"

                    CheckBox {
                        id: checkBox
                        text: name
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        padding: 10
                        font.pointSize: 22
                        anchors.topMargin: 0
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 10
                    }
                }
            }
        }
    }
    Text {
        id: title
        height: 26
        text: qsTr("To Do")
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHCenter
        anchors.rightMargin: 25
        anchors.leftMargin: 25
        anchors.topMargin: 15
    }

    Button {
        id: addNewToDoButton
        x: 8
        y: 752
        width: 584
        height: 40
        text: qsTr("Add To Do")
        font.pointSize: 12

        Connections {
            target: addNewToDoButton
            onClicked: toDoTextInput.text = ""
        }

        Connections {
            target: addNewToDoButton
            onClicked: rectangle.isDialogOpen = !rectangle.isDialogOpen
        }
    }


    states: [
        State {
            name: "clicked"
            when: addNewToDoButton.checked
        }
    ]
}
