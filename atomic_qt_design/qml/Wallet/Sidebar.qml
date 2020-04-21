import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.0
import "../Components"
import "../Constants"

// Coins bar at left side
Rectangle {
    id: coins_bar

    function reset() {
        input_coin_filter.reset()
    }

    Layout.alignment: Qt.AlignLeft
    width: 200
    Layout.fillHeight: true
    color: Style.colorTheme7

    // Balance
    DefaultText {
        anchors.top: parent.top
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter

        text: API.get().empty_string + (General.formatFiat("", API.get().balance_fiat_all, API.get().fiat))
    }

    RowLayout {
        anchors.top: parent.top
        anchors.topMargin: parent.width * 0.5 - height * 0.5
        anchors.horizontalCenter: parent.horizontalCenter

        spacing: 10

        // Search button
        Rectangle {
            color: "transparent"
            width: search_button.width
            height: search_button.height
            Image {
                id: search_button

                source: General.image_path + "exchange-search.svg"

                width: 16; height: width

                visible: false
            }
            ColorOverlay {
                id: search_button_overlay
                property bool hovered: false

                anchors.fill: search_button
                source: search_button
                color: search_button_overlay.hovered || input_coin_filter.visible ? Style.colorWhite1 : Style.colorWhite4
            }
        }

        // Search input
        DefaultTextField {
            id: input_coin_filter

            function reset() {
                text = ""
            }

            placeholderText: API.get().empty_string + (qsTr("Search"))
            selectByMouse: true

            width: parent.width * 0.3
        }
    }

    // Add button
    PlusButton {
        id: add_coin_button

        width: 32

        mouse_area.onClicked: enable_coin_modal.prepareAndOpen()

        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.width * 0.5 - height * 0.5
        anchors.horizontalCenter: parent.horizontalCenter
    }

    // Coins list
    ListView {
        ScrollBar.vertical: ScrollBar {}
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        implicitWidth: contentItem.childrenRect.width
        implicitHeight: Math.min(contentItem.childrenRect.height, parent.height - coins_bar.width * 2)
        clip: true

        model: General.filterCoins(API.get().enabled_coins, input_coin_filter.text)

        delegate: Rectangle {
            property bool hovered: false

            color: API.get().current_coin_info.ticker === model.modelData.ticker ? Style.colorTheme2 : hovered ? Style.colorTheme4 : "transparent"
            anchors.horizontalCenter: parent.horizontalCenter
            width: coins_bar.width
            height: 60

            // Click area
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onHoveredChanged: hovered = containsMouse

                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: {
                    if (mouse.button === Qt.RightButton) context_menu.popup()
                    else API.get().current_coin_info.ticker = model.modelData.ticker

                    main.send_modal.reset()
                }
                onPressAndHold: {
                    if (mouse.source === Qt.MouseEventNotSynthesized) context_menu.popup()
                }
            }

            // Right click menu
            Menu {
                id: context_menu
                Action {
                    text: API.get().empty_string + (qsTr("Disable %1", "TICKER").arg(model.modelData.ticker))
                    onTriggered: API.get().disable_coins([model.modelData.ticker])
                    enabled: General.canDisable(model.modelData.ticker)
                }
            }

            // Icon
            Image {
                id: icon
                anchors.left: parent.left
                anchors.leftMargin: 30

                source: General.image_path + "coins/" + model.modelData.ticker.toLowerCase() + ".png"
                fillMode: Image.PreserveAspectFit
                width: Style.textSize3
                anchors.verticalCenter: parent.verticalCenter
            }

            ColumnLayout {
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: icon.anchors.leftMargin

                // Name
                DefaultText {
                    Layout.alignment: Qt.AlignRight
                    text: API.get().empty_string + (model.modelData.name.replace(" (TESTCOIN)", ""))
                    font.pixelSize: text.length > 12 ? Style.textSizeSmall1 : Style.textSizeSmall5
                }

                // Ticker
                DefaultText {
                    Layout.alignment: Qt.AlignRight
                    text: API.get().empty_string + (model.modelData.ticker)
                    font.pixelSize: Style.textSize
                    color: Style.colorDarkText
                }
            }
        }
    }
}