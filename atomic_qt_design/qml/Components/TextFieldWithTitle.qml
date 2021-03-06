import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import "../Constants"

ColumnLayout {
    property alias title: title_text.text
    property alias field: input_field
    property alias hide_button: hide_button
    property alias hide_button_area: hide_button.mouse_area
    property bool copyable: false
    property bool hidable: false

    property bool hiding: true

    // Local
    function reset() {
        input_field.text = ''
    }

    DefaultText {
        id: title_text
        visible: text !== ''
    }

    DefaultTextField {
        id: input_field

        echoMode: hidable && hiding ? TextInput.Password : TextInput.Normal

        Layout.fillWidth: true
        selectByMouse: true

        HideFieldButton {
            id: hide_button
        }

        CopyFieldButton {

        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
