module Headers = {
  type t = Js.Dict.t<string>
  @send external set: (t, string, string) => unit = "set"
  @send external append: (t, string, string) => unit = "append"
}

module Request = {

  type body

  type init = {
    // TODO: add cf
    "method": option<string>,
    "headers": option<Headers.t>,
    "body": option<body>,
    "redirect": option<string>,
  }
  let makeInit = (~method=?, ~headers=?, ~body=?, ~redirect=?, ()) => {
    "method": method,
    "headers": headers,
    "body": body,
    "redirect": redirect,
  }

  type t = {
    "body": body,
    "bodyUsed": bool,
    // TODO: add cf
    "headers": Headers.t,
    "method": string,
    "redirect": string,
    "url": string,
  }
  @new external makeFromString1: (string) => t = "Request"
  @new external makeFromRequest1: (t) => t = "Request"
  @new external makeFromString2: (string, init) => t = "Request"
  @new external makeFromRequest2: (t, init) => t = "Request"
}

module Response = {

  type body

  type init = {
    "status": option<int>,
    "statusText": option<string>,
    "headers": option<Headers.t>,
  }
  let makeInit = (~status=?, ~statusText=?, ~headers=?, ()) => {
    "status": status,
    "statusText": statusText,
    "headers": headers,
  }

  type t = {
    "body": body,
    "bodyUsed": bool,
    "encodeBody": string,
    "headers": Headers.t,
    "ok": bool,
    "redirected": bool,
    "status": int,
    "statusText": string,
    "url": string,
    // TODO: add websocket
  }
  @new external make0: unit => t = "Response"
  @new external makeFromString1: string => t = "Response"
  @new external makeFromBody1: body => t = "Response"
  @new external makeFromString2: (string, init) => t = "Response"
  @new external makeFromBody2: (body, init) => t = "Response"
}

type event = {"request": Request.t}
@send external respondWith: (event, Js.Promise.t<Response.t>) => unit = "respondWith"

// TODO: only do fetch for request for now
@val external fetch: (Request.t) => Js.Promise.t<Response.t> = "fetch"