/*
    Écran de démarrage « République Hagridienne »
    SPDX-FileCopyrightText: 2026 Soviet_Hagrid
    SPDX-License-Identifier: LicenseRef-SovietHagrid-Proprietary
    Tous droits réservés — reproduction et distribution interdites sans l'accord de Soviet_Hagrid (voir LICENSE.md).
*/
import QtQuick

Rectangle {
    id: root
    color: "#020818"

    // fourni par ksplashqml : 1 (démarrage) … 6 (bureau prêt)
    property int stage: 0
    // échelle : 1.0 pour 1080p, proportionnelle à la hauteur/largeur disponibles
    readonly property real u: Math.max(0.5, Math.min(width, height * 16 / 9) / 1920)
    property int tick: 0

    onStageChanged: {
        if (stage >= 2 && content.opacity < 1 && !intro.running) {
            intro.running = true
        }
        if (stage >= 5) {
            loaderFade.running = true
        }
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0

        Image {
            anchors.fill: parent
            source: "images/background.jpg"
            fillMode: Image.PreserveAspectCrop
            asynchronous: true
            smooth: true
        }

        Image {
            id: star
            width: 230 * root.u
            height: width
            sourceSize: Qt.size(width * 2, height * 2)
            anchors.horizontalCenter: parent.horizontalCenter
            y: parent.height * 0.5 - height * 0.95
            source: "images/star.svg"
            asynchronous: true
            smooth: true

            SequentialAnimation on scale {
                loops: Animation.Infinite
                running: root.stage >= 2
                NumberAnimation { to: 1.06; duration: 900; easing.type: Easing.InOutSine }
                NumberAnimation { to: 1.0;  duration: 900; easing.type: Easing.InOutSine }
            }
        }

        // titre : ombre rose dure décalée + texte cyan (comme les boutons du site)
        Text {
            x: title.x + 4 * root.u
            y: title.y + 4 * root.u
            text: title.text
            font: title.font
            color: "#ff00cc"
        }
        Text {
            id: title
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: star.bottom
            anchors.topMargin: 34 * root.u
            text: "RÉPUBLIQUE HAGRIDIENNE"
            color: "#00f5ff"
            font.family: "Orbitron"
            font.weight: Font.Bold
            font.pixelSize: Math.round(46 * root.u)
            font.letterSpacing: 7 * root.u
        }

        // accroche reprise du site : « Bienvenue dans le futur ! » entre deux étoiles
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: title.bottom
            anchors.topMargin: 22 * root.u
            spacing: 18 * root.u
            Image { source: "images/star.svg"; width: 34 * root.u; height: width; sourceSize: Qt.size(width * 2, height * 2); anchors.verticalCenter: parent.verticalCenter }
            Text {
                text: "Bienvenue dans le futur !"
                color: "#cce0ff"
                font.family: "VT323"
                font.pixelSize: Math.round(40 * root.u)
            }
            Image { source: "images/star.svg"; width: 34 * root.u; height: width; sourceSize: Qt.size(width * 2, height * 2); anchors.verticalCenter: parent.verticalCenter }
        }

        // chargeur pixel : une rangée de carrés qui s'allument à tour de rôle
        Row {
            id: loader
            spacing: 12 * root.u
            anchors.horizontalCenter: parent.horizontalCenter
            y: parent.height * 0.84

            Repeater {
                model: 8
                Rectangle {
                    required property int index
                    width: 18 * root.u
                    height: width
                    color: "#00f5ff"
                    readonly property int d: (root.tick - index + 8) % 8
                    opacity: d === 0 ? 1.0 : (d === 1 ? 0.55 : (d === 2 ? 0.28 : 0.12))
                    border.width: Math.max(1, Math.round(2 * root.u))
                    border.color: d === 0 ? "#ff00cc" : "#00f5ff"
                }
            }
        }

        Text {
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 28 * root.u
            text: "propulsé par KDE Plasma"
            color: "#8aa0c8"
            font.family: "VT323"
            font.pixelSize: Math.round(26 * root.u)
        }
    }

    Timer {
        interval: 130
        repeat: true
        running: root.stage >= 1
        onTriggered: root.tick = (root.tick + 1) % 8
    }

    OpacityAnimator {
        id: intro
        target: content
        from: 0
        to: 1
        duration: 700
        easing.type: Easing.InOutQuad
        running: false
    }

    OpacityAnimator {
        id: loaderFade
        target: loader
        from: 1
        to: 0
        duration: 400
        running: false
    }
}
