import QtQuick

Item {

    property alias fullLanguage: fullLanguage

    ListModel {
        id: fullLanguage
    }

    Component.onCompleted: {
        fullLanguage.append({ name: i18n("English"), code: "en" });
        fullLanguage.append({ name: i18n("Spanish"), code: "es" });
        fullLanguage.append({ name: i18n("Chinese (Mandarin)"), code: "zh" });
        fullLanguage.append({ name: i18n("Portuguese"), code: "pt" });
        fullLanguage.append({ name: i18n("Russian"), code: "ru" });
        fullLanguage.append({ name: i18n("Hindi"), code: "hi" });
        fullLanguage.append({ name: i18n("German"), code: "de" });
        fullLanguage.append({ name: i18n("Dutch"), code: "nl" });
        fullLanguage.append({ name: i18n("Japanese"), code: "ja" });
        fullLanguage.append({ name: i18n("French"), code: "fr" });
        fullLanguage.append({ name: i18n("Italian"), code: "it" });
        fullLanguage.append({ name: i18n("Korean"), code: "ko" });
        fullLanguage.append({ name: i18n("Arabic"), code: "ar" });
        fullLanguage.append({ name: i18n("Turkish"), code: "tr" });
        fullLanguage.append({ name: i18n("Polish"), code: "pl" });
        fullLanguage.append({ name: i18n("Swedish"), code: "sv" });
        fullLanguage.append({ name: i18n("Danish"), code: "da" });
        fullLanguage.append({ name: i18n("Norwegian"), code: "no" });
        fullLanguage.append({ name: i18n("Finnish"), code: "fi" });
        fullLanguage.append({ name: i18n("Greek"), code: "el" });
        fullLanguage.append({ name: i18n("Czech"), code: "cs" });
        fullLanguage.append({ name: i18n("Hungarian"), code: "hu" });
        fullLanguage.append({ name: i18n("Romanian"), code: "ro" });
        fullLanguage.append({ name: i18n("Bulgarian"), code: "bg" });
        fullLanguage.append({ name: i18n("Indonesian"), code: "id" });
        fullLanguage.append({ name: i18n("Vietnamese"), code: "vi" });
    }
}
