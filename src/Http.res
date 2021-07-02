type headers = Js.Dict.t<string>

type requestBody = string // TODO: find a way to feed in request too

type request

type requestInit = {
    method: option<string>,
    headers: option<headers>,
    body: option<requestBody>,
    redirect: option<string>,
}
let makeRequestInit = (~method=?, ~headers=?, ~body=?, ~redirect=?, ()) => {
    method: method,
    headers: headers,
    body: body,
    redirect: redirect,
}

@new external makeRequest: (string, requestInit) => request = "Request"

type responseBody = string

type responseInit = {
    status: option<int>,
    statusText: option<string>,
    headers: option<headers>,
}
let makeResponseInit = (~status=?, ~statusText=?, ~headers=?, ()) => {
  status: status,
  statusText: statusText,
  headers: headers,
}

type response
@new external makeResponse0: unit => response = "Response"
@new external makeResponse1: (responseBody) => response = "Response"
@new external makeResponse2: (responseBody, responseInit) => response = "Response"

type event = {"request": request}
@send external respondWith: (event, Js.Promise.t<response>) => unit = "respondWith"
