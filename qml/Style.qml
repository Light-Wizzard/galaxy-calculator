pragma Singleton
import QtQuick 2.12
/* ****************************************************************************
 * adjust colors in Main.qml doTheme()
 */
QtObject
{
    property int textSize: 20
    property color textColor: "blue"
    property color textEditColor: "black"
    property color textColorFocus: "red"
    property color textColorNoFocus: "green"
    property color textColorError: "red"
    property color textColorWarning: "purple"
    property color textColorCaution: "yellow"
    property color borderColor: "black"
    property color gradientColorStart: "lightsteelblue"
    property color gradientColorStop: "blue"
    property color backgroundColor: "aliceblue"
}
/* ***************************** End of File ******************************* */
