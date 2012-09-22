chomeviews = {}

get_stream_info = (tab, lv) ->
    url = "http://watch.live.nicovideo.jp/api/getplayerstatus?v=#{lv}"
    $.ajax url, {
        dataType: "xml",
        success: (res) ->
            ms = $(res).find("ms")
            if ms.length > 0
                $.ajax {
                    url: "http://localhost:9999/listen_nicolive",
                    type: 'POST',
                    data: {
                        addr: ms.find("addr").text(),
                        port: ms.find("port").text(),
                        thread: ms.find("thread").text()
                    }
                }
            else
                stop_comment_view tab
    }

connect_message_server = (tab, message_server_info) ->
    addr = message_server_info.find("addr").text()
    port = message_server_info.find("port").text()
    thread = message_server_info.find("thread").text()

    url = "ws://#{addr}:#{port}"
    connection = new WebSocket url
    connection.onmessage = ->
        console.log "on message"
    connection.onopen = ->
        console.log "connected"
        connection.send("<thread thread=\"#{thread}\" version=\"20061206\" res_from=\"-1\" />\0")
        start_comment_view tab, connection

start_comment_view = (tab, connection) ->
    chrome.pageAction.setIcon {
        path: "../images/icon19_on.png",
        tabId: tab.id
    }
    chomeviews[tab.id] = connection


stop_comment_view = (tab) ->
    chrome.pageAction.setIcon {
        path: "../images/icon19_off.png",
        tabId: tab.id
    }
    chomeviews[tab.id] = false

toggle_comment_view = (tab) ->
    unless chomeviews[tab.id]
        get_stream_info tab, tab.url.match(/lv\d+/)
    else
        stop_comment_view tab

update_page_action_ability = (tab_id, change_info, tab) ->
    if tab.url.match("live.nicovideo.jp/watch/lv")
        chrome.pageAction.show(tab.id)
        chomeviews[tab.id] = false
    else
        chrome.pageAction.hide(tab.id)

chrome.tabs.onUpdated.addListener(update_page_action_ability)
chrome.pageAction.onClicked.addListener(toggle_comment_view)
