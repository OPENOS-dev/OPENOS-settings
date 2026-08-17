import QtQuick 2.15
import QtQuick.Window 2.15

/* OPENOS 设置 App (独立窗口)
 * 分类: 外观 / 安全(OAK) / 软件包(opt) / 系统 / 网络 / 隔离(vmapp)
 */
Window {
    id: settingsApp
    width: 720; height: 520
    flags: Qt.FramelessWindowHint
    title: "设置"
    color: OpenUI.background

    property int currentPage: 0

    Rectangle {
        anchors.fill: parent
        color: OpenUI.background

        // 侧栏导航
        Rectangle {
            width: 170; anchors.top: parent.top; anchors.bottom: parent.bottom
            anchors.left: parent.left
            color: Qt.rgba(OpenUI.surface.r, OpenUI.surface.g, OpenUI.surface.b, 0.9)
            Column { anchors.fill: parent; anchors.topMargin: OpenUI.sp4
                Repeater {
                    model: ListModel {
                        ListElement { icon: "\u2699"; label: "外观" }
                        ListElement { icon: "\uD83D"; label: "安全" }
                        ListElement { icon: "\u2630"; label: "软件包" }
                        ListElement { icon: "\u25A0"; label: "系统" }
                        ListElement { icon: "\u263C"; label: "网络" }
                        ListElement { icon: "\u25A2"; label: "隔离" }
                    }
                    Rectangle {
                        width: 170; height: 40; radius: OpenUI.shapeXs
                        color: settingsApp.currentPage === index
                               ? Qt.rgba(OpenUI.primary.r, OpenUI.primary.g,
                                         OpenUI.primary.b, 0.2)
                               : (hover.hovered
                                  ? Qt.rgba(OpenUI.onSurface.r, OpenUI.onSurface.g,
                                            OpenUI.onSurface.b, OpenUI.hoverAlpha)
                                  : "transparent")
                        Row { anchors.fill: parent; anchors.leftMargin: OpenUI.sp4
                              spacing: OpenUI.sp2
                            Text { width: 24; height: parent.height; verticalAlignment: Text.AlignVCenter
                                   text: model.icon; color: OpenUI.primary; font.pixelSize: 15 }
                            Text { height: parent.height; verticalAlignment: Text.AlignVCenter
                                   text: model.label; color: OpenUI.onSurface
                                   font.pixelSize: OpenUI.typeLabelL }
                        }
                        MouseArea { id: hover; anchors.fill: parent; hoverEnabled: true
                            onClicked: settingsApp.currentPage = index }
                    }
                }
            }
        }

        // 内容区
        Rectangle {
            anchors.left: parent.left; anchors.leftMargin: 170
            anchors.right: parent.right; anchors.top: parent.top; anchors.bottom: parent.bottom
            color: "transparent"; clip: true
            StackLayout {
                anchors.fill: parent; anchors.margins: OpenUI.sp5
                currentIndex: settingsApp.currentPage
                AppearancePage {}
                SecurityPage {}
                PackagesPage {}
                SystemPage {}
                NetworkPage {}
                VmappPage {}
            }
        }

        // 关闭按钮
        Rectangle {
            x: parent.width - 40; y: 8; width: 32; height: 32; radius: OpenUI.shapeXs
            color: hover.hovered ? Qt.rgba(OpenUI.error.r, OpenUI.error.g,
                                           OpenUI.error.b, 0.3) : "transparent"
            Text { anchors.centerIn: parent; text: "\u2715"; color: OpenUI.onSurface }
            MouseArea { id: hover; anchors.fill: parent; hoverEnabled: true
                onClicked: settingsApp.close() }
        }
    }
}
