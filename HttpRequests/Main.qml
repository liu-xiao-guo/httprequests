import QtQuick 2.4
import Ubuntu.Components 1.3

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "httprequests.liu-xiao-guo"

    width: units.gu(60)
    height: units.gu(85)

    function request(url) {
        console.log("url: " + url)

        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            console.log("readystate: " + xhr.readyState)
            console.log("xhr status: " + xhr.status)
            if (xhr.readyState == 4 && xhr.status === 200) {
                console.log("http request result: " + xhr.responseText);
                var lights = JSON.parse('' + xhr.responseText+ '');
                console.log(lights[0].id)
                for ( var index in lights) {
                    console.log("light id: " + lights[index].id)
                    console.log("uid: " + lights[index].uid )
                }
            }
        }
        xhr.open('GET', url, true);
        xhr.send();
    }

    Page {
        header: PageHeader {
            id: pageHeader
            title: i18n.tr("HttpRequests")
        }

        Button {
            objectName: "button"
            anchors.centerIn: parent
            text: i18n.tr("Send a request")
            onClicked: {
                console.log("it is clicked")
                var url = "http://localhost:9000/api/lights"
                request(url);
            }
        }
    }
}
