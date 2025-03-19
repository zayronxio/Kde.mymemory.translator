import QtQuick
import "lib" as Lib
import QtQuick.Layouts
import QtQuick.Controls
import org.kde.plasma.components as PlasmaComponents
import Qt.labs.platform
import org.kde.plasma.plasmoid
import "js/translate.js" as Api
import org.kde.kirigami as Kirigami

Item {
    id: container

    Layout.preferredWidth: Kirigami.Units.gridUnit * 18
    Layout.preferredHeight: wrapper.implicitHeight + marginSeperator
    Layout.minimumWidth: Kirigami.Units.gridUnit * 18
    Layout.maximumWidth: Kirigami.Units.gridUnit * 18
    Layout.minimumHeight: Layout.preferredHeight
    Layout.maximumHeight: Layout.preferredHeight
    clip: false

    property string sourceLang: Plasmoid.configuration.sourceLa
    property string targetLang: Plasmoid.configuration.targetLa
    property int marginSeperator: 10
    property string textTranslate
    property bool activeTranslate: false

    Languages {
        id: modelLanguage
    }

    function copyToClipboard(string) {
        txtCopy.text = string
        txtCopy.exec()
    }

    TextEdit {
        id: txtCopy
        signal exec
        visible: false
        onExec: {
            if (text !== "") {
                txtCopy.selectAll()
                txtCopy.copy()
                txtCopy.deselect()
                text = ""
            }
        }
    }
    Column {
        id: wrapper
        width: container.width - marginSeperator * 2
        height: container.height - marginSeperator * 2
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: Kirigami.Units.gridUnit


        Row {
            width: parent.width
            height: Kirigami.Units.gridUnit * 2
            spacing: Kirigami.Units.gridUnit
            PlasmaComponents.ComboBox {
                id: sourceLan
                textRole: "name"
                valueRole: "code"
                width: (parent.width / 2) - Kirigami.Units.gridUnit * 2
                model: modelLanguage

                onActivated: {
                    sourceLang = currentValue
                    Plasmoid.configuration.targetLa = currentValue.toString()
                }
                Component.onCompleted: currentIndex = indexOfValue(sourceLang)
            }
            Rectangle {
                width: height
                height: parent.height
                radius: height/2
                color: Kirigami.Theme.textColor
                Text {
                    text: "⇄"
                    color: Kirigami.Theme.backgroundColor
                    anchors.fill: parent
                    font.pointSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        var oldSourceLan = sourceLang
                        var oldTargetLan = targetLang
                        var oldIndexSource = sourceLan.currentIndex
                        var oldIndexTarget = targetLan.currentIndex
                        Plasmoid.configuration.targetLa = oldSourceLan
                        targetLang = oldSourceLan
                        Plasmoid.configuration.sourceLa = oldTargetLan
                        sourceLang = oldTargetLan
                        sourceLan.currentIndex = oldIndexTarget
                        targetLan.currentIndex = oldIndexSource
                    }
                }
            }
            PlasmaComponents.ComboBox {
                id: targetLan
                textRole: "name"
                valueRole: "code"
                width: (parent.width / 2) - Kirigami.Units.gridUnit * 2
                model: modelLanguage
                onActivated: {
                    targetLang = currentValue
                    Plasmoid.configuration.targetLa = currentValue.toString()
                }
                Component.onCompleted: currentIndex = indexOfValue(targetLang)
            }
        }
        Lib.Card {
            width: parent.width
            height: !activeTranslate ? Kirigami.Units.gridUnit * 12 : Kirigami.Units.gridUnit * 6
            anchors.horizontalCenter: parent.horizontalCenter
            TextField {
                id: txt
                width: parent.width - 8
                height: parent.height - 8
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignTop
                wrapMode: Text.Wrap
                background: Rectangle {
                    width: txt.width
                    height: txt.height
                    color: "transparent"
                }
                onAccepted: {
                    textTranslate = ""
                    Api.translateText(txt.text, sourceLang, targetLang, function (error, translatedText) {
                        if (error) {
                            console.error("Error al traducir:", error);
                        } else {
                            console.log("Texto traducido:", translatedText);
                            textTranslate = translatedText;
                            activeTranslate = true;
                        }
                    });
                }
            }
            Rectangle {
                width:  Kirigami.Units.gridUnit * 2
                height: width
                radius: height/2
                anchors.bottom: parent.bottom
                anchors.bottomMargin: - 8
                anchors.right: parent.right
                anchors.rightMargin: - 8
                Kirigami.Icon {
                    source: "translate"
                    color: Kirigami.Theme.backgroundColor
                    width: 22
                    height: 22
                    anchors.centerIn: parent
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        textTranslate = ""
                        Api.translateText(txt.text, sourceLang, targetLang, function (error, translatedText) {
                            if (error) {
                                console.error("Error al traducir:", error);
                            } else {
                                console.log("Texto traducido:", translatedText);
                                textTranslate = translatedText;
                                activeTranslate = true;
                            }
                        });
                    }
                }
            }
        }
        Lib.Card {
            width: parent.width
            height: !activeTranslate ? Kirigami.Units.gridUnit * 12 : Kirigami.Units.gridUnit * 6
            anchors.horizontalCenter: parent.horizontalCenter
            visible: activeTranslate
            TextField {
                id: result
                width: parent.width - 8
                height: parent.height - 8
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignTop
                wrapMode: Text.Wrap
                readOnly: true
                background: Rectangle {
                    width: txt.width
                    height: txt.height
                    color: "transparent"
                }
                text: textTranslate
            }
            Rectangle {
                width:  Kirigami.Units.gridUnit * 2
                height: width
                radius: height/2
                anchors.bottom: parent.bottom
                anchors.bottomMargin: - 8
                anchors.right: parent.right
                anchors.rightMargin: - 8
                visible: false // result.text !== ""
                Kirigami.Icon {
                    source: "translate"
                    color: Kirigami.Theme.backgroundColor
                    width: 22
                    height: 22
                    anchors.centerIn: parent
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                       copyToClipboard(result.text)
                    }
                }
            }
        }
    }
}

