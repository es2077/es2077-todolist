let apiUrl = `http://localhost:3001`

let {useQuery, useMutation, mutationOptions, queryOptions} = module(ReactQuery)

type task = {
  title: string,
  createdAt: string,
  completed: bool,
}

type tasksResult =
  | Data(array<task>)
  | Loading
  | Error

type hookResult = {tasksResult: tasksResult, handleSubmit: unit => unit, isCreatingTask: bool}

let handleFetch = (_): Js.Promise.t<array<task>> =>
  Fetch.fetch(`${apiUrl}/tasks`, {"method": "GET"})->Promise.then(Fetch.Response.json)

let handleTaskCreation = task =>
  Fetch.fetch(
    `${apiUrl}/tasks`,
    {
      "method": "POST",
      "body": Js.Json.stringifyAny(task),
      "headers": {
        "Content-Type": "application/json",
      },
    },
  )

let useHome = () => {
  let result = useQuery(
    queryOptions(
      ~queryKey="tasks",
      ~queryFn=handleFetch,
      ~refetchOnWindowFocus=ReactQuery.refetchOnWindowFocus(#bool(false)),
      (),
    ),
  )

  let handleRefetch = (_, _, _) => {
    result.refetch({
      throwOnError: false,
      cancelRefetch: false,
    })->ignore

    Promise.resolve()
  }

  let {mutate: createTaskMutation, isLoading: isCreatingTask} = useMutation(
    mutationOptions(
      ~mutationKey="create-task",
      ~mutationFn=handleTaskCreation,
      ~onSuccess=handleRefetch,
      (),
    ),
  )

  let handleSubmit = () => {
    createTaskMutation(.
      {
        title: "Task teste 1",
        createdAt: Js.Date.make()->Js.Date.toJSONUnsafe,
        completed: false,
      },
      None,
    )
    ()
  }

  {
    tasksResult: switch result {
    | {data: Some(tasks), isLoading: false, isError: false} => Data(tasks)
    | {isLoading: true} => Loading
    | _ => Error
    },
    handleSubmit: handleSubmit,
    isCreatingTask: isCreatingTask,
  }
}
