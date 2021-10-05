let {useQuery, queryOptions, refetchOnWindowFocus} = module(ReactQuery)

let apiUrl = `http://localhost:3001`

type task = {
  id: int,
  title: string,
  createdAt: string,
  completed: bool,
}
type fetchResult =
  | Loading
  | Error
  | Empty
  | Data(array<task>)

let handleFetch = (_): Promise.t<array<task>> =>
  Fetch.fetch(`${apiUrl}/tasks`, {"method": "GET"})->Promise.then(Fetch.Response.json)

let useTasks = () => {
  let result = useQuery(
    queryOptions(
      //
      ~queryFn=handleFetch,
      ~queryKey="tasks",
      ~refetchOnWindowFocus=refetchOnWindowFocus(#bool(false)),
      (),
    ),
  )

  switch result {
  | {data: Some([]), isLoading: false, isError: false}
  | {data: None, isLoading: false, isError: false} =>
    Empty
  | {isLoading: true} => Loading
  | {data: Some(tasks), isLoading: false, isError: false} => Data(tasks)
  | _ => Error
  }
}
