module Response = {
  type t
  @send external json: t => Js.Promise.t<'a> = "json"

  @get external ok: t => bool = "ok"
}

@val external fetch: (string, {..}) => Js.Promise.t<Response.t> = "fetch"
