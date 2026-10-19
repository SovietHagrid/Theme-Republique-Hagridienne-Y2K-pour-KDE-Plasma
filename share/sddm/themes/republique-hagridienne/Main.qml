/*
    Écran de connexion SDDM « République Hagridienne »
    QML pur (QtQuick uniquement) : aucune dépendance à un style de contrôles.
    SPDX-License-Identifier: CC-BY-SA-4.0
*/
import QtQuick 2.15

Rectangle {
    id: root
    width: 1920
    height: 1080
    color: "#020818"

    readonly property color cyan: "#00f5ff"
    readonly property color pink: "#ff00cc"
    readonly property color gold: "#ffd700"
    readonly property color lime: "#00ff88"
    readonly property color text: "#cce0ff"
    readonly property color muted: "#8aa0c8"
    readonly property real u: Math.max(0.55, Math.min(width, height * 16 / 9) / 1920)
    property bool failed: false
    property bool busy: false

    FontLoader { id: fVT;  source: "fonts/VT323-Regular.ttf" }
    FontLoader { id: fORB; source: "fonts/Orbitron-VF.ttf" }
    FontLoader { id: fP2P; source: "fonts/PressStart2P-Regular.ttf" }

    // ------------------------------------------------------------ fond
    Image {
        anchors.fill: parent
        source: (typeof config !== "undefined" && config.background) ? config.background : "background.jpg"
        fillMode: Image.PreserveAspectCrop
        smooth: true
    }
    Rectangle { anchors.fill: parent; color: "#020818"; opacity: 0.30 }

    // ------------------------------------------------------------ horloge
    Timer {
        id: clock
        property date now: new Date()
        interval: 1000; running: true; repeat: true
        onTriggered: now = new Date()
    }
    Item {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 56 * root.u
        width: clockT.width
        height: clockT.height + dateT.height + 12 * root.u
        Text {
            x: clockT.x + 4 * root.u; y: clockT.y + 4 * root.u
            text: clockT.text; font: clockT.font; color: root.pink
        }
        Text {
            id: clockT
            anchors.right: parent.right
            text: Qt.formatTime(clock.now, "HH:mm")
            color: root.cyan
            font.family: fP2P.name
            font.pixelSize: Math.round(58 * root.u)
        }
        Text {
            id: dateT
            anchors.right: parent.right
            anchors.top: clockT.bottom
            anchors.topMargin: 16 * root.u
            text: Qt.locale("fr_CA").toString(clock.now, "dddd d MMMM yyyy")
            color: root.text
            font.family: fVT.name
            font.pixelSize: Math.round(34 * root.u)
        }
    }

    // ------------------------------------------------------------ données (cachées mais instanciées)
    ListView {
        id: userList
        width: 10; height: 10; opacity: 0
        model: userModel
        currentIndex: userModel.lastIndex >= 0 ? userModel.lastIndex : 0
        orientation: ListView.Horizontal
        cacheBuffer: 10000
        delegate: Item {
            width: 10; height: 10
            property string userName: model.name
            property string userReal: (model.realName && model.realName.length > 0) ? model.realName : model.name
        }
    }
    ListView {
        id: sessionList
        width: 10; height: 10; opacity: 0
        model: sessionModel
        currentIndex: sessionModel.lastIndex >= 0 ? sessionModel.lastIndex : 0
        orientation: ListView.Horizontal
        cacheBuffer: 10000
        delegate: Item {
            width: 10; height: 10
            property string sessionName: model.name
        }
    }

    function doLogin() {
        if (root.busy || !userList.currentItem) return
        root.failed = false
        root.busy = true
        sddm.login(userList.currentItem.userName, pass.text, sessionList.currentIndex)
    }

    Connections {
        target: sddm
        function onLoginFailed() {
            root.busy = false
            pass.text = ""          // d'abord vider (cela remet « failed » à false)…
            root.failed = true      // …puis afficher l'échec
            shakeAnim.restart()
            pass.forceActiveFocus()
        }
        function onLoginSucceeded() { root.busy = true }
    }

    // ------------------------------------------------------------ panneau de connexion
    Item {
        id: panel
        width: 640 * root.u
        height: col.height + 80 * root.u
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 30 * root.u
        opacity: 0
        transform: Translate { id: shake; x: 0 }

        NumberAnimation on opacity { from: 0; to: 1; duration: 600; easing.type: Easing.OutQuad }
        SequentialAnimation {
            id: shakeAnim
            NumberAnimation { target: shake; property: "x"; to: -16 * root.u; duration: 50 }
            NumberAnimation { target: shake; property: "x"; to: 16 * root.u;  duration: 80 }
            NumberAnimation { target: shake; property: "x"; to: -10 * root.u; duration: 70 }
            NumberAnimation { target: shake; property: "x"; to: 0;            duration: 60 }
        }

        // ombre dure rose décalée (comme la fenêtre modale du site)
        Rectangle { x: 12 * root.u; y: 12 * root.u; width: parent.width; height: parent.height; color: root.pink }
        Rectangle {
            anchors.fill: parent
            color: "#0c1233"
            border.color: root.cyan
            border.width: Math.max(2, Math.round(3 * root.u))
        }

        Column {
            id: col
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 40 * root.u
            width: parent.width - 96 * root.u
            spacing: 22 * root.u

            // en-tête : étoile + titre
            Item {
                width: parent.width
                height: 96 * root.u
                Image {
                    id: starImg
                    source: "images/star.svg"
                    width: 92 * root.u; height: width
                    sourceSize: Qt.size(width * 2, height * 2)
                    anchors.verticalCenter: parent.verticalCenter
                    SequentialAnimation on scale {
                        loops: Animation.Infinite
                        NumberAnimation { to: 1.07; duration: 1000; easing.type: Easing.InOutSine }
                        NumberAnimation { to: 1.0;  duration: 1000; easing.type: Easing.InOutSine }
                    }
                }
                Item {
                    anchors.left: starImg.right
                    anchors.leftMargin: 22 * root.u
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    height: tTitle.height + tSub.height
                    Text {
                        x: tTitle.x + 3 * root.u; y: tTitle.y + 3 * root.u
                        text: tTitle.text; font: tTitle.font; color: root.pink
                    }
                    Text {
                        id: tTitle
                        text: "RÉPUBLIQUE\nHAGRIDIENNE"
                        lineHeight: 0.92
                        color: root.cyan
                        font.family: fORB.name
                        font.weight: Font.Bold
                        font.pixelSize: Math.round(31 * root.u)
                        font.letterSpacing: 3 * root.u
                    }
                    Text {
                        id: tSub
                        anchors.top: tTitle.bottom
                        anchors.topMargin: 6 * root.u
                        text: "Bienvenue dans le futur !"
                        color: root.muted
                        font.family: fVT.name
                        font.pixelSize: Math.round(28 * root.u)
                    }
                }
            }

            // ligne pointillée (comme .panel-title)
            Row {
                spacing: 6 * root.u
                height: Math.max(2, 3 * root.u)
                Repeater {
                    model: Math.floor(parent.parent.width / (14 * root.u))
                    Rectangle { width: 8 * root.u; height: parent.height; color: root.cyan; opacity: 0.55 }
                }
            }

            // sélecteur d'utilisateur
            Item {
                width: parent.width
                height: 64 * root.u
                Rectangle {
                    id: prevBtn
                    visible: userList.count > 1
                    width: 56 * root.u; height: width
                    color: prevMA.pressed ? "#aa0088" : (prevMA.containsMouse ? root.pink : "#0d2b5e")
                    border.color: root.pink; border.width: Math.max(2, Math.round(2 * root.u))
                    anchors.verticalCenter: parent.verticalCenter
                    Text { anchors.centerIn: parent; text: "◀"; color: "#fff"; font.family: fP2P.name; font.pixelSize: Math.round(18 * root.u) }
                    MouseArea { id: prevMA; anchors.fill: parent; hoverEnabled: true; onClicked: userList.decrementCurrentIndex() }
                }
                Text {
                    anchors.left: userList.count > 1 ? prevBtn.right : parent.left
                    anchors.right: userList.count > 1 ? nextBtn.left : parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    horizontalAlignment: Text.AlignHCenter
                    elide: Text.ElideRight
                    text: userList.currentItem ? userList.currentItem.userReal : ""
                    color: "#ffffff"
                    font.family: fVT.name
                    font.pixelSize: Math.round(46 * root.u)
                }
                Rectangle {
                    id: nextBtn
                    visible: userList.count > 1
                    width: 56 * root.u; height: width
                    anchors.right: parent.right
                    color: nextMA.pressed ? "#aa0088" : (nextMA.containsMouse ? root.pink : "#0d2b5e")
                    border.color: root.pink; border.width: Math.max(2, Math.round(2 * root.u))
                    anchors.verticalCenter: parent.verticalCenter
                    Text { anchors.centerIn: parent; text: "▶"; color: "#fff"; font.family: fP2P.name; font.pixelSize: Math.round(18 * root.u) }
                    MouseArea { id: nextMA; anchors.fill: parent; hoverEnabled: true; onClicked: userList.incrementCurrentIndex() }
                }
            }

            // champ mot de passe
            Rectangle {
                width: parent.width
                height: 68 * root.u
                color: "#020818"
                border.color: pass.activeFocus ? root.cyan : "#066f7e"
                border.width: Math.max(2, Math.round(3 * root.u))

                Text {
                    anchors.fill: parent
                    anchors.leftMargin: 20 * root.u
                    verticalAlignment: Text.AlignVCenter
                    visible: pass.text.length === 0
                    text: "mot de passe…"
                    color: root.muted
                    font.family: fVT.name
                    font.pixelSize: Math.round(38 * root.u)
                }
                TextInput {
                    id: pass
                    anchors.fill: parent
                    anchors.leftMargin: 20 * root.u
                    anchors.rightMargin: 20 * root.u
                    verticalAlignment: TextInput.AlignVCenter
                    echoMode: TextInput.Password
                    passwordCharacter: "●"
                    color: root.text
                    selectionColor: "#d400a8"
                    selectedTextColor: "#ffffff"
                    font.family: fVT.name
                    font.pixelSize: Math.round(40 * root.u)
                    focus: true
                    clip: true
                    enabled: !root.busy
                    Keys.onReturnPressed: root.doLogin()
                    Keys.onEnterPressed: root.doLogin()
                    Keys.onEscapePressed: { text = ""; root.failed = false }
                    onTextChanged: root.failed = false
                }
            }

            // messages (échec / verrouillage majuscules)
            Item {
                width: parent.width
                height: 30 * root.u
                Text {
                    anchors.centerIn: parent
                    text: root.failed ? "✖ ACCÈS REFUSÉ — mot de passe incorrect"
                          : ((typeof keyboard !== "undefined" && keyboard.capsLock) ? "⚠ VERROUILLAGE MAJUSCULES ACTIF" : "")
                    color: root.failed ? "#ff5577" : root.gold
                    font.family: fVT.name
                    font.pixelSize: Math.round(30 * root.u)
                }
            }

            // bouton de connexion (style boutons du site : dégradé bleu/violet, bordure rose, ombre dure)
            Item {
                width: parent.width
                height: 76 * root.u
                Rectangle { x: 6 * root.u; y: 6 * root.u; width: parent.width - 6 * root.u; height: parent.height - 6 * root.u; color: loginMA.pressed ? "#660055" : root.pink; visible: !loginMA.pressed }
                Rectangle {
                    x: loginMA.pressed ? 6 * root.u : 0
                    y: loginMA.pressed ? 6 * root.u : 0
                    width: parent.width - 6 * root.u; height: parent.height - 6 * root.u
                    border.color: root.pink; border.width: Math.max(2, Math.round(3 * root.u))
                    gradient: Gradient {
                        orientation: Gradient.Horizontal
                        GradientStop { position: 0.0; color: loginMA.containsMouse ? "#ff00cc" : "#0d2b5e" }
                        GradientStop { position: 1.0; color: loginMA.containsMouse ? "#aa0088" : "#1e0a40" }
                    }
                    Text {
                        anchors.centerIn: parent
                        text: root.busy ? "CONNEXION…" : "ENTRER"
                        color: "#ffffff"
                        font.family: fP2P.name
                        font.pixelSize: Math.round(22 * root.u)
                    }
                    MouseArea { id: loginMA; anchors.fill: parent; hoverEnabled: true; onClicked: root.doLogin() }
                }
            }

            // session
            Item {
                width: parent.width
                height: 40 * root.u
                visible: sessionList.count > 0
                Text {
                    anchors.centerIn: parent
                    text: "session : " + (sessionList.currentItem ? sessionList.currentItem.sessionName : "") + (sessionList.count > 1 ? "  ⟲" : "")
                    color: sessMA.containsMouse ? root.cyan : root.muted
                    font.family: fVT.name
                    font.pixelSize: Math.round(30 * root.u)
                }
                MouseArea {
                    id: sessMA
                    anchors.fill: parent
                    hoverEnabled: true
                    enabled: sessionList.count > 1
                    onClicked: sessionList.currentIndex = (sessionList.currentIndex + 1) % sessionList.count
                }
            }
        }
    }

    // ------------------------------------------------------------ boutons d'alimentation
    Row {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 40 * root.u
        spacing: 22 * root.u

        Repeater {
            model: [
                { label: "VEILLE",     col: "#ffd700", ok: (typeof sddm !== "undefined") && sddm.canSuspend,  act: 0 },
                { label: "REDÉMARRER", col: "#00f5ff", ok: (typeof sddm !== "undefined") && sddm.canReboot,   act: 1 },
                { label: "ÉTEINDRE",   col: "#ff00cc", ok: (typeof sddm !== "undefined") && sddm.canPowerOff, act: 2 }
            ]
            Rectangle {
                required property var modelData
                visible: modelData.ok
                width: lbl.width + 36 * root.u
                height: 52 * root.u
                color: pMA.containsMouse ? modelData.col : "#0a1628"
                border.color: modelData.col
                border.width: Math.max(2, Math.round(2 * root.u))
                Text {
                    id: lbl
                    anchors.centerIn: parent
                    text: modelData.label
                    color: pMA.containsMouse ? "#020818" : modelData.col
                    font.family: fVT.name
                    font.pixelSize: Math.round(32 * root.u)
                    font.letterSpacing: 2 * root.u
                }
                MouseArea {
                    id: pMA
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: { if (modelData.act === 0) sddm.suspend(); else if (modelData.act === 1) sddm.reboot(); else sddm.powerOff() }
                }
            }
        }
    }

    Component.onCompleted: pass.forceActiveFocus()
}
