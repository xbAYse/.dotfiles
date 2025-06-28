import Quickshell
import Quickshell.Io
import QtQuick
import "root:"
import "root:services"

Scope {
  id: root
  property string hour: "hh AP"
  property string minute: "mm" 
  property string day: "dd"
  property string month: "MM"

  Variants {
    model: Quickshell.screens

    PanelWindow {
      property var modelData
      screen: modelData
      
      color: "transparent"

      anchors {
        left: true
        top: true
        bottom: true
      }
      margins {
        left: 5
        right: 5
        top: 5
        bottom:5
      }
      implicitWidth: 40
      Rectangle {
        id: inner
        anchors.centerIn: parent
        height: parent.height
        width: parent.width
        color: "#161616"
        border.color :"#262626"
        border.width : 2
      }
    Column {
           anchors.horizontalCenter: parent.horizontalCenter
           anchors.verticalCenter: parent.verticalCenter
           anchors.top: parent.top

           Rectangle { color: "transparent"
           width: 30; height: 10 }
           Rectangle { color: "transparent"
                       width: 30; height: 26
                       Text { anchors.centerIn: parent
                              font.pointSize: 14; color: "#ffffff"; text: Time.format(hour).substring(0,2)} }
           Rectangle { color: "transparent"
                       width: 30; height: 30
                        Text { anchors.centerIn: parent
                        font.pointSize: 14; color: "#08bdba"; text: Time.format(minute) } }
           Rectangle { anchors.horizontalCenter: parent.horizontalCenter; color: "#ee5396"
                       width: 25; height: 2 }
           Rectangle { color: "transparent"
                       width: 30; height: 30
                        Text { anchors.centerIn: parent
                        font.pointSize: 14; color: "#08bdba"; text: Time.format(month) } }
           Rectangle { color: "transparent"
                       width: 30; height: 26
                        Text { anchors.centerIn: parent
                        font.pointSize: 14; color: "#ffffff"; text: Time.format(day) } }
                      }
    Column {
           anchors.horizontalCenter: parent.horizontalCenter
           anchors.verticalCenter: parent.verticalCenter
           anchors.bottom: parent.bottom

           Rectangle { anchors.centerIn: parent; color: "#282828"
           width: 30; height: 30 }
         }
    }
  }
}
