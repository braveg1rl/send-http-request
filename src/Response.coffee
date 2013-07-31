module.exports = class Response
  constructor: (@request) ->
    @statusCode = @request.status
    @headerString = @request.getAllResponseHeaders()
    @text = @request.responseText
  
  getHeaders: ->
    return @headers if @headers?
    @headers = {}
    headerLines = @headerString.split("\r\n")
    for headerLine in headerLines
      dividerIndex = headerLine.indexOf(": ")
      if dividerIndex > 0
        key = headerLine.substring 0, dividerIndex
        val = headerLine.substring dividerIndex + 2
        @headers[key.toLowerCase()] = val
    @headers = {}

  getStatusCode: ->
    @statusCode
  
  getHeader: (name) ->
    @request.getResponseHeader name
    
  getText: ->
    @text

  isSuccess: ->
    @statusCode is 200
  
  isError: ->
    not @isSuccess()
  
  isAuthorizationError: ->
    @statusCode in [401, 403]
    
  isInternalError: ->
    @statusCode in [500]

  isJSON: ->
    @hasContentType "application/json"
    
  isText: ->
    @hasContentType "text/plain"
  
  isHTML: ->
    @hasContentType "text/html"

  hasContentType: (contentType) ->
    return false unless headerValue = @getHeader('content-type')
    return headerValue.indexOf(contentType) is 0