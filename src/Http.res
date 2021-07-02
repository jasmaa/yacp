type headers = Js.Dict.t<string>

module Request = {
  type t

  type body = string // TODO: find a way to feed in request too

  type init = {
    method: option<string>,
    headers: option<headers>,
    body: option<body>,
    redirect: option<string>,
  }
  let makeInit = (~method=?, ~headers=?, ~body=?, ~redirect=?, ()) => {
    method: method,
    headers: headers,
    body: body,
    redirect: redirect,
  }

  @new external make1: (string) => t = "Request"
  @new external make2: (string, init) => t = "Request"
}

module Response = {
  type t

  type body = string

  type init = {
    status: option<int>,
    statusText: option<string>,
    headers: option<headers>,
  }
  let makeInit = (~status=?, ~statusText=?, ~headers=?, ()) => {
    status: status,
    statusText: statusText,
    headers: headers,
  }

  @new external make0: unit => t = "Response"
  @new external make1: body => t = "Response"
  @new external make2: (body, init) => t = "Response"
}

type event = {"request": Request.t}
@send external respondWith: (event, Js.Promise.t<Response.t>) => unit = "respondWith"
