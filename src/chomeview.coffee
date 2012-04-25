alert_info = ->
    url = "http://live.nicovideo.jp/api/getalertinfo"
    result = null
    $.ajax url,
        dataType: 'xml'
        success: (xml) ->
            result = {
                server: xml.querySelector("addr").firstChild,
                port: xml.querySelector("port").firstChild,
                thread: xml.querySelector("thread").firstChild
            }
        error: (jqXHR, textStatus, errorThrown) ->
            console.log(textStatus)
            console.log(errorThrown)
    result
url = alert_info()
console.log url

