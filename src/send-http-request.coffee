makePromise = require "make-promise"
Response = require "./Response"

module.exports = send = (method, url, headers = {}, data) ->
  console.log "#{method} #{url}"
  makePromise (cb) ->
    request = makeRequestObject()
    request.onreadystatechange = ->
      switch request.readyState
        when 4 # request has completed - could be error state as well
          return cb new Error "Empty response." unless request.status
          return cb null, new Response request
    request.open method, url, true
    request.setRequestHeader headerName, headerValue for headerName, headerValue of headers
    request.send data

makeRequestObject = ->
  if window?
    return new window.XMLHttpRequest if window.XMLHttpRequest
    if window.ActiveXObject
      try
        return new window.ActiveXObject "Msxml2.XMLHTTP"
      catch error
        return new window.ActiveXObject "Microsoft.XMLHTTP"
    else
      throw new Error "XMLHTTPRequest is not supported."
  else if require
    x = require "xmlhttprequest"
    return new x.XMLHttpRequest
  else
    throw new Error "XMLHTTPRequest is not supported."