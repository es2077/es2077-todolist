open Ancestor.Default
open Render

let {useHome} = module(HomeHook)

module DateFns = {
  @module("date-fns")
  external format: (Js.Date.t, string) => string = "format"
}

module Loading = {
  @react.component
  let make = () =>
    <Box display=[xs(#flex)] alignItems=[xs(#center)] justifyContent=[xs(#center)] py=[xs(14)]>
      <Base width=[xs(5.6->#rem)] tag=#img src="/static/spinner.svg" />
    </Box>
}

module EmptyState = {
  @react.component
  let make = () => {
    <Box
      py=[xs(12)]
      display=[xs(#flex)]
      flexDirection=[xs(#column)]
      alignItems=[xs(#center)]
      justifyContent=[xs(#center)]>
      <Base tag=#img src="/static/empty-state-image.svg" width=[xs(19.6->#rem)] />
      <Typography
        mt=[xs(2)]
        color=[xs(Theme.Colors.white)]
        fontSize=[xs(2.4->#rem)]
        letterSpacing=[xs(-0.035->#rem)]>
        {`Não há tarefas pendentes`->s}
      </Typography>
      <Typography
        m=[xs(0)]
        mt=[xs(1)]
        color=[xs(Theme.Colors.gray2)]
        fontSize=[xs(1.8->#rem)]
        letterSpacing=[xs(-0.035->#rem)]>
        {`Adicione sua primeira tarefa utilizando o campo acima`->s}
      </Typography>
    </Box>
  }
}

module TaskItem = {
  @react.component
  let make = (~title, ~date, ~completed) => {
    <Box
      display=[xs(#flex)]
      justifyContent=[xs(#"space-between")]
      alignItems=[xs(#center)]
      mb=[xs(2)]
      width=[xs(100.0->#pct)]
      bgColor=[xs(Theme.Colors.gray1)]
      py=[xs(3)]
      px=[xs(3)]
      borderRadius=[xs(1)]>
      <Box>
        <Typography
          m=[xs(0)]
          color=[xs(Theme.Colors.white)]
          fontSize=[xs(1.6->#rem)]
          letterSpacing=[xs(-0.035->#rem)]>
          {title->s}
        </Typography>
        <Typography
          m=[xs(0)]
          mt=[xs(1)]
          color=[xs(Theme.Colors.gray2)]
          fontSize=[xs(1.4->#rem)]
          letterSpacing=[xs(-0.035->#rem)]>
          {date->s}
        </Typography>
      </Box>
      <Checkbox checked=completed />
    </Box>
  }
}

@react.component
let make = () => {
  let {tasksResult, isCreatingTask, handleSubmit} = useHome()

  <Box
    overflow=[xs(#auto)]
    width=[xs(100.0->#pct)]
    height=[xs(100.0->#pct)]
    bgColor=[xs(Theme.Colors.black)]>
    <Box tag=#header display=[xs(#flex)] justifyContent=[xs(#center)] py=[xs(6)]> <Logo /> </Box>
    <Box display=[xs(#flex)] justifyContent=[xs(#center)]>
      <Box px=[xs(3)] mt=[xs(10)] width=[xs(100.0->#pct)] maxW=[xs(63.4->#rem)]>
        <Typography
          color=[xs(Theme.Colors.white)] fontSize=[xs(2.4->#rem)] letterSpacing=[xs(-0.035->#rem)]>
          {`Nova tarefa`->s}
        </Typography>
        <Box mt=[xs(2)] position=[xs(#relative)]>
          <Input placeholder="Compras da semana" />
          <Box
            width=[xs(10.0->#rem)]
            position=[xs(#absolute)]
            right=[xs(1.0->#rem)]
            top=[xs(1.0->#rem)]>
            <Button loading=isCreatingTask onClick={_ => handleSubmit()}> {`Adicionar`->s} </Button>
          </Box>
        </Box>
        {switch tasksResult {
        | Data([]) => <EmptyState />
        | Loading => <Loading />
        | Error => <p> {`Error`->s} </p>
        | Data(tasks) =>
          <Box mt=[xs(4)]>
            {tasks->map((task, key) => {
              <TaskItem
                key
                completed=task.completed
                title=task.title
                date={task.createdAt
                ->Js.Date.fromString
                ->DateFns.format(`dd/MM/yyyy 'às' hh:mm aaaaa'm'`)}
              />
            })}
          </Box>
        }}
      </Box>
    </Box>
  </Box>
}
