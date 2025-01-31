'Handles the Get API calls
'@param {string} url -  API url
'@param {string} requestType -  type of request
sub getURLCallGet(url as string, requestType as string)
  deviceInfo = createObject("roDeviceInfo")
  appInfo = createObject("roAppInfo")
      if requestType = "HomeContentCall" 
        url = url
      else if requestType = "charactersContentCall" 
        url = url
      end if

  m.contentRetriever = m.global.contentRetriever
  m.contentRetriever.control = "RUN"
  makeURLCallGet({ uri: url, requesttype: requestType })

end sub

'Process GET API params and observe response field to receive api response callback
'parameters: API request
sub makeURLCallGet(parameters as object)
  context = createObject("RoSGNode", "Node")
  if type(parameters) = "roAssociativeArray"
    context.addFields({
      parameters: parameters,
      response: {}
    })
    context.observeField("response", "receiveRequestResponse")
    m.contentRetriever.requestGet = { context: context } ' initiate request and store context node as intermediary
  end if
end sub

'API response Callback for API Calls
'@param {object} msg-  Message from Roku System
sub receiveRequestResponse(msg as object)
  mt = type(msg)
  if mt = "roSGNodeEvent"
    response = msg.getData()
    ?"response---------"response.code
    rt = type(response)
    if rt = "roAssociativeArray"
      requestType = response.parameters.requesttype
      if response.code = 200 
        if requestType = "HomeContentCall"
          loadHomeContentCallData(parseJson(response.content))
        else if requestType = "charactersContentCall"
          loadcharactersContentCallData(parseJson(response.content))
        end if
      else 
        print "[ERROR] HomeScreen: Received unknown response message of type: '"
      end if
    else
      print "[ERROR] HomeScreen: Expected response of type roAA, received response of type: '"; rt; "'"
    end if
  else
    print "[ERROR] HomeScreen: Received unknown response message of type: '"; mt; "'"
  end if
end sub