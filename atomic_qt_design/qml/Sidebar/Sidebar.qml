import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import "../Constants"

ColumnLayout {
    id: window_layout

    transformOrigin: Item.Center
    spacing: 0

    SidebarLine {
        dashboard_index: General.idx_dashboard_portfolio
        text: API.get().empty_string + (qsTr("Portfolio"))
        image: General.image_path + "menu-assets-portfolio.png"
        Layout.fillWidth: true
    }

    SidebarLine {
        dashboard_index: General.idx_dashboard_wallet
        text: API.get().empty_string + (qsTr("Wallet"))
        image: General.image_path + "menu-assets-white.svg"
        Layout.fillWidth: true
    }

    SidebarLine {
        dashboard_index: General.idx_dashboard_exchange
        text: API.get().empty_string + (qsTr("DEX"))
        image: General.image_path + "menu-exchange-white.svg"
        Layout.fillWidth: true
    }

    SidebarLine {
        dashboard_index: General.idx_dashboard_news
        text: API.get().empty_string + (qsTr("News"))
        image: General.image_path + "menu-news-white.svg"
        Layout.fillWidth: true
    }

    SidebarLine {
        dashboard_index: General.idx_dashboard_dapps
        id: dapps_line
        text: API.get().empty_string + (qsTr("DApps"))
        image: General.image_path + "menu-dapp-white.svg"
        Layout.fillWidth: true
    }

    SidebarLine {
        dashboard_index: General.idx_dashboard_settings
        text: API.get().empty_string + (qsTr("Settings"))
        Layout.topMargin: dapps_line.height * 0.5
        image: General.image_path + "menu-settings-white.svg"
        Layout.fillWidth: true
    }
}









/*##^##
Designer {
    D{i:0;autoSize:true;height:264;width:150}
}
##^##*/
