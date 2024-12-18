import QtQuick 6.5
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
                console.log(preview)
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
                anchors.centerIn: parent
                text: "Capture"

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
                        console.log(qchat.importContact(b64_image, 0, 0,
                                                        cap_obj.width,
                                                        cap_obj.height))
                    }
                }
            }
        }
    }
}
