import QtQuick 6.8
import QtQuick.Controls
import QtMultimedia
import QtQuick.Window
import QtQuick.Controls.Universal
import QtQuick.Controls.Material
import QtQuick.Layouts 2.15
import QtQuick.Controls 2.15
import com.visibog.qchat 1.0

Rectangle {
    property string b64_image: ""
    property bool captured: false

    color: "#242424"

    function start_camera() {
        captureSession.camera.start()
    }

    function stop_camera() {
        captureSession.camera.stop()
    }

    function capture_image() {
        captureSession.imageCapture.capture()
    }

    function capture_rectangle(img_w, img_h, paint_w, paint_h, paint_rect_w, paint_rect_h) {
        let scale_w = img_w / paint_w
        let scale_h = img_h / paint_h

        let rect_w = paint_rect_w * scale_w
        let rect_h = paint_rect_h * scale_h

        return [rect_w, rect_h]
    }

    CaptureSession {
        id: captureSession
        videoOutput: output
        camera: Camera {}
        imageCapture: ImageCapture {
            id: capture
            onImageCaptured: {
                img_preview.visible = true
                output.visible = false
                b64_image = qchat.imgToBase64(preview)
            }
        }
    }

    Rectangle {
        height: parent.height / 2
        width: parent.width / 2
        anchors.centerIn: parent

        ColumnLayout {
            anchors.fill: parent

            VideoOutput {
                id: output
                anchors.fill: parent

                Rectangle {
                    id: cap_obj
                    color: "#00000000"
                    height: 256
                    width: 256
                    anchors.centerIn: parent

                    border.color: "red"
                    border.width: 1
                }
            }

            Image {
                id: img_preview
                source: capture.preview
                anchors.fill: parent
            }

            RoundButton {
                text: "Capture"
                anchors.centerIn: parent

                onClicked: {
                    if (!captured) {
                        capture_image()
                        captured = true
                        text = "close"
                    } else {
                        mainStack.pop()
                        img_preview.visible = false
                        output.visible = true
                        text = "capture"
                        captured = false
                        stop_camera()
                        let pic_rect = capture_rectangle(
                                img_preview.sourceSize.width,
                                img_preview.sourceSize.height,
                                img_preview.paintedWidth,
                                img_preview.paintedHeight, cap_obj.width,
                                cap_obj.height)

                        console.log(`${pic_rect}`)

                        let contact = qchat.importContact(
                                b64_image,
                                (img_preview.sourceSize.width / 2) - (pic_rect[0] / 2),
                                (img_preview.sourceSize.height / 2) - (pic_rect[1] / 2),
                                pic_rect[0], pic_rect[1])

                        console.log(`contact: ${contact}`)
                    }
                }
            }
        }
    }
}
