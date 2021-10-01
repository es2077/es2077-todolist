let apiUrl = `http://localhost:3001`

let {useQuery, queryOptions} = module(ReactQuery)

type task = {
  title: string,
  createdAt: string,
}

type result =
  | Data(array<task>)
  | Loading
  | Error

let handleFetch = (_): Js.Promise.t<array<task>> => {
  open Promise

  Fetch.fetch(`${apiUrl}/tasks`, {"method": "GET"})->then(response => response->Fetch.Response.json)
}

let useHome = () => {
  let result = useQuery(queryOptions(~queryKey="tasks", ~queryFn=handleFetch, ()))

  switch result {
  | {data: Some(tasks), isLoading: false, isError: false} => Data(tasks)
  | {isLoading: true} => Loading
  | _ => Error
  }
}
