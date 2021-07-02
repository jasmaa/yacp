type request
@new external makeRequest: unit => request = "Request"

type bodyInit = string

type headers = Js.Dict.t<string>

type responseInit = {status: int, statusText: string, headers: headers}
let makeResponseInit = (~status=200, ~statusText="", ~headers, ()) => {
  status: status,
  statusText: statusText,
  headers: headers,
}

type response
@new external makeResponse: (bodyInit, responseInit) => response = "Response"

type event = {"request": request}
@send external respondWith: (event, Js.Promise.t<response>) => unit = "respondWith"
