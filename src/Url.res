type t = {
  "href": string,
  "origin": string,
  "protocol": string,
  "username": string,
  "password": string,
  "host": string,
  "hostname": string,
  "port": string,
  "pathname": string,
  "search": string,
}
@new external make: string => t = "URL"

module SearchParams = {
  type t
  @new external make: string => t = "URLSearchParams"
  @send external get: (t, string) => Js.Nullable.t<string> = "get"
  @send external has: (t, string) => bool = "has"
}
