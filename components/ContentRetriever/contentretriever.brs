'Initialize the content retreiver
function init()
  m.jobQueue = {}
  m.port = createObject("roMessagePort")
  m.top.observeField("requestLoginApiCall", m.port)
  m.top.observeField("requestPost", m.port)
  m.top.observeField("requestGet", m.port)
  m.top.observeField("imageURL", m.port)
  m.top.functionName = "listen"
  m.top.control = "run"
end function

'Listen the port and process the event for requestPost, requestGet, imageURL
function listen() as void
  while (true)
    msg = wait(0, m.port)
    mt = type(msg)
    if mt = "roSGNodeEvent"
      if msg.getField() = "requestPost"
        makeAPIRequestPost(msg.getData())
      else if msg.getField() = "requestGet"
        makeAPIRequestGet(msg.getData())
      else
        print "[ERROR] ContentRetriever: unrecognized field '"; msg.getField(); "'"
      end if
    else if mt = "roUrlEvent" ' Received response from API call
      processResponse(msg)
    else
      print "[ERROR] ContentRetriever: unrecognized event type '"; mt; "'"
    end if
  end while
end function


'Get the image from supplied request params.
'@param{string} request - API param
function makeAPIRequestForImage(request as string)
  fileName = getFileName(request)
  msgPort = CreateObject("roMessagePort")
  http = CreateObject("roUrlTransfer")
  http.SetMessagePort(m.port)
  http.SetCertificatesFile("common:/certs/ca-bundle.crt")
  http.InitClientCertificates()
  http.EnableEncodings(true)
  http.SetRequest("GET")
  http.SetUrl(request)
  http.AsyncGetToFile(fileName)
  context = {}
  context.image = true

  while true
    msg = wait(0, m.port)
    if msg <> invalid
      id = stri(http.getIdentity()).trim()
      m.jobQueue[id] = { context: context, transfer: http } ' saving the urlTransfer object here is essential to keeping it alive (global scope) until the request is finished
      print "Request to "; id; " successful."
    end if
  end while

end function


'Get the file name
'@param{string} imageUrl - Image url
function getFileName(imageUrl) as string
  imageName = imageUrl.split("/")
  imageQuery = imageName[imageName.count() - 1].split("?")
  fileName = "tmp:/" + imageQuery[0]
  return fileName
end function

'Callback for listen() function written above
'@param{object} request - API request params
function makeAPIRequestGet(request as object) as boolean
  if type(request) = "roAssociativeArray" ' sanity check: should pass in roAA
    context = request.context
    if type(context) = "roSGNode" ' sanity check: request should have one field (context as roSGNode)
      parameters = context.parameters
      if type(parameters) = "roAssociativeArray"
        uri = parameters.uri
        if type(uri) = "roString"
          urlTransfer = CreateObject("roUrlTransfer")
          urlTransfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
          urlTransfer.AddHeader("X-Roku-Reserved-Dev-Id", "")
          urlTransfer.AddHeader("Content-Type", "application/json")
          urlTransfer.RetainBodyOnError(true)
          urlTransfer.InitClientCertificates()
          urlTransfer.setUrl(uri)
          urlTransfer.setPort(m.port)
          if (urlTransfer.AsyncGetToString()) ' response will be caught by listen()
            id = stri(urlTransfer.getIdentity()).trim()
            m.jobQueue[id] = { context: context, transfer: urlTransfer } ' saving the urlTransfer object here is essential to keeping it alive (global scope) until the request is finished
            print "Request to "; uri; " successful."
          else
            print "[ERROR] ContentRetriever: invalid uri: "; uri
          end if
        end if
      end if
    end if
  end if
  return true
end function

'Callback for listen() function written above
'@param{string} request - API request params
function makeAPIRequestPost(request as object) as boolean
  if type(request) = "roAssociativeArray" ' sanity check: should pass in roAA
    context = request.context
    if type(context) = "roSGNode" ' sanity check: request should have one field (context as roSGNode)
      parameters = context.parameters
      if type(parameters) = "roAssociativeArray"
        uri = parameters.uri
        if type(uri) = "roString"
          urlTransfer = CreateObject("roUrlTransfer")
          urlTransfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
          urlTransfer.AddHeader("X-Roku-Reserved-Dev-Id", "")
          urlTransfer.RetainBodyOnError(true)
          queryParam = ""
          if parameters.requestType = "authorizationCall"
            urlTransfer.AddHeader("Content-Type", "application/json")
            postData = parameters.postData
            queryParam = formatJSON(postData)
          else if parameters.requestType = "makeWatchlistentriescall"
            urlTransfer.AddHeader("Content-Type", "application/json")
            urlTransfer.AddHeader("Authorization", "Bearer " + m.global.acessToken)
            postData = parameters.postData
            queryParam = formatJSON(postData)
          else if parameters.requestType = "attributionApiCall"
            urlTransfer.AddHeader("Content-Type", "application/json")
            urlTransfer.AddHeader("Authorization", "Bearer " + m.global.acessToken)
            postData = parameters.postData
            queryParam = formatJSON(postData)
          else if parameters.requestType = "reservationApiCall" or parameters.requestType = "clearReservationApiCall" or parameters.requestType = "ordersApiCall" or parameters.requestType = "qrCodeRequest"  or parameters.requestType = "removewatchlistapicall"
            urlTransfer.AddHeader("Content-Type", "application/json")
            urlTransfer.AddHeader("Authorization", "Bearer " + m.global.acessToken)
            postData = parameters.postData
            queryParam = formatJSON(postData)
          else if parameters.requestType = "authorizationValidateCall"
            urlTransfer.AddHeader("Content-Type", "application/x-www-form-urlencoded")
            postData = parameters.postData
            queryParam = "grant_type=" + postData.grant_type + "&device_code=" + postData.device_code + "&client_id=" + postData.client_id + "&client_secret=" + postData.client_secret
          else if parameters.requestType = "subscriptionApiCall"
            urlTransfer.AddHeader("Content-Type", "application/json")
            postData = parameters.postData
            queryParam = formatJSON(postData)
          end if
          if parameters.requestType = "removewatchlistapicall"
            urlTransfer.SetRequest("DELETE")
          end if
          if parameters.requestType = "clearReservationApiCall"
            urlTransfer.SetRequest("DELETE")
          else if parameters.requestType = "validateEventAccessCode"
            urlTransfer.AddHeader("Content-Type", "application/json")
            urlTransfer.SetRequest("PUT")
            postData = parameters.postData
            queryParam = formatJSON(postData)
          end if
          urlTransfer.InitClientCertificates()
          urlTransfer.setUrl(uri)
          urlTransfer.setPort(m.port)

          if (urlTransfer.AsyncPostFromString(queryParam)) ' response will be caught by listen()
            id = stri(urlTransfer.getIdentity()).trim()
            m.jobQueue[id] = { context: context, transfer: urlTransfer } ' saving the urlTransfer object here is essential to keeping it alive (global scope) until the request is finished
            print "Request to "; uri; " successful."
          else
            print "[ERROR] ContentRetriever: invalid uri: "; uri
          end if
        end if
      end if
    end if
  end if
  return true
end function

'Callback for listen() function written above
'@param{object} msg - roUrlEvent
function processResponse(msg as object)
  id = stri(msg.GetSourceIdentity()).trim()
  job = m.jobQueue[id]

  if job <> invalid and job.context <> invalid and job.context.image = invalid
    result = {
      uri: job.context.parameters.uri,
      parameters: job.context.parameters,
      code: msg.getResponseCode(),
      content: msg.getString(),
      headers: msg.GetResponseHeaders()
    }
    job.context.response = result ' update response field of context node being watched by caller
    m.jobQueue.delete(id) ' job has been completed
  else if job <> invalid and job.context <> invalid and job.context.image = true
    m.top.imageLoaded = true
  else
    print "[ERROR] Received response message for unknown job: "; idkey
  end if
end function

'Parse XML content
'@param{string} str - XML content
function ParseXML(str as string) as dynamic
  if str = invalid return invalid
  xml = CreateObject("roXMLElement")
  if not xml.Parse(str) return invalid
  return xml
end function
