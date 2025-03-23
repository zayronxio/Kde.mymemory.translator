import QtQuick
import QtQuick.Controls
import org.kde.kirigami as Kirigami

Item {
    id: configRoot

    signal configurationChanged

    property alias cfg_autoCopy: clipboard.checked

    Kirigami.FormLayout {
        id: form
        width: parent.width

        CheckBox {
            id: clipboard
            Kirigami.FormData.label: i18n("Auto Copy Translation:")
        }
    }

}
