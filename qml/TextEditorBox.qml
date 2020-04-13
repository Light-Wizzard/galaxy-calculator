import QtQuick 2.0

FocusScope
{
    id: focusScope;
    width: 400;
    height: textInput.paintedHeight + (2 * textInput.anchors.topMargin);

    property alias  value                          : textInput.text;
    property alias  fontSize                       : textInput.font.pointSize;
    property alias  textColor                      : textInput.color;
    property alias  placeHolder                    : typeSomething.text;

    Rectangle
    {
        id: background;
        anchors.fill: parent;
        color: "#AAAAAA";
        radius: 5;
        antialiasing: true;
        border
        {
            width: 3;
            color: (focusScope.activeFocus ? "red" : "steelblue");
        }
    }
    TextEdit
    {
        id: textInput;
        focus: true
        selectByMouse: true
        font.pointSize: 20;
        wrapMode: TextEdit.WrapAtWordBoundaryOrAnywhere;
        color: "black";
        anchors
        {
            top: parent.top;
            topMargin: 10;
            left: parent.left;
            leftMargin: 10;
            right: parent.right;
            rightMargin: 10;
        }
    }
    MouseArea
    {
        visible: (!focusScope.activeFocus);
        anchors.fill: parent
        onClicked: { textInput.forceActiveFocus(); }
    }
}
