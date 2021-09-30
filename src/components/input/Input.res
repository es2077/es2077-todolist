open Ancestor.Default
open Render

module Styles = {
  open Emotion

  let input = error =>
    css({
      "border": "none",
      "width": "100%",
      "height": "6rem",
      "padding": "0 2.4rem",
      "borderRadius": "6px",
      "display": "block",
      "color": Theme.Colors.white->Theme.Colors.toString,
      "background": Theme.Colors.gray1->Theme.Colors.toString,
      "fontSize": "1.8rem",
      "letterSpacing": "-0.035em",
      "outline": "none",
      "border": "none",
      "transition": "300ms",
      "&:placeholder": {
        "color": Theme.Colors.gray2->Theme.Colors.toString,
      },
      "boxShadow": error === None ? "" : `0 0 2px 1px ${Theme.Colors.red->Theme.Colors.toString}`,
      "&:focus": {
        "transition": "300ms",
        "boxShadow": error === None
          ? `0 0 2px 1px ${Theme.Colors.purple->Theme.Colors.toString}`
          : "",
      },
    })
}

@react.component
let make = (~placeholder=?, ~onChange=?, ~value=?, ~name=?, ~error=?) => {
  <Box>
    <input ?placeholder ?onChange ?value ?name className={Styles.input(error)} />
    {switch error {
    | None => React.null
    | Some(message) =>
      <Typography
        color=[xs(Theme.Colors.red)]
        m=[xs(0)]
        mt=[xs(1)]
        fontSize=[xs(1.6->#rem)]
        letterSpacing=[xs(-0.035->#rem)]>
        {message->s}
      </Typography>
    }}
  </Box>
}
