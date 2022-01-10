// Copyright (c) 2022 Proton Technologies AG
//
// This file is part of ProtonMail Bridge.
//
// ProtonMail Bridge is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// ProtonMail Bridge is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with ProtonMail Bridge.  If not, see <https://www.gnu.org/licenses/>.

import QtQuick 2.13
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.13
import QtQuick.Controls.impl 2.13

import Proton 4.0

SettingsView {
    id: root

    fillHeight: false

    property bool _valuesChanged: keychainSelection.checkedButton && keychainSelection.checkedButton.text != root.backend.currentKeychain

    Label {
        colorScheme: root.colorScheme
        text: qsTr("Default keychain")
        type: Label.Heading
        Layout.fillWidth: true
    }

    Label {
        colorScheme: root.colorScheme
        text: qsTr("Change which keychain Bridge uses as default")
        type: Label.Body
        color: root.colorScheme.text_weak
        Layout.fillWidth: true
        wrapMode: Text.WordWrap
    }

    ColumnLayout {
        spacing: 16

        ButtonGroup{ id: keychainSelection }

        Repeater {
            model: root.backend.availableKeychain

            RadioButton {
                colorScheme: root.colorScheme
                ButtonGroup.group: keychainSelection
                text: modelData
            }
        }
    }


    Rectangle {
        Layout.fillWidth: true
        height: 1
        color: root.colorScheme.border_weak
    }

    RowLayout {
        spacing: 12

        Button {
            id: submitButton
            colorScheme: root.colorScheme
            text: qsTr("Save and restart")
            enabled: root._valuesChanged
            onClicked: {
                root.backend.changeKeychain(keychainSelection.checkedButton.text)
            }
        }

        Button {
            colorScheme: root.colorScheme
            text: qsTr("Cancel")
            onClicked: root.back()
            secondary: true
        }

        Connections {
            target: root.backend

            onChangeKeychainFinished: {
                submitButton.loading = false
                root.back()
            }
        }
    }

    onBack: {
        root.setDefaultValues()
    }

    function setDefaultValues(){
        for (var bi in keychainSelection.buttons){
            var button = keychainSelection.buttons[bi]
            if (button.text == root.backend.currentKeychain) {
                button.checked = true
                break;
            }
        }
    }

    Component.onCompleted: root.setDefaultValues()
}
