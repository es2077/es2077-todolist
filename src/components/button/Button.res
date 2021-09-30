open Ancestor.Default

module Styles = {
  open Emotion

  let button = css({
    "display": "flex",
    "alignItems": "center",
    "justifyContent": "center",
    "width": "100%",
    "background": Theme.Colors.purple->Theme.Colors.toString,
    "borderRadius": "6px",
    "border": "none",
    "color": Theme.Colors.white->Theme.Colors.toString,
    "fontSize": "1.6rem",
    "letterSpacing": "-0.035em",
    "height": "3.8rem",
    "padding": "0 1.8rem",
    "cursor": "pointer",
    "transition": "300ms background",
    "&:hover": {
      "background": Theme.Colors.purpleDark->Theme.Colors.toString,
    },
  })
}

@react.component
let make = (~children, ~onClick=?, ~loading=false, ~disabled=false) => {
  <button disabled ?onClick className=Styles.button>
    {switch loading {
    | false => children
    | true => <Base width=[xs(2.4->#rem)] tag=#img src="/static/spinner.svg" />
    }}
  </button>
}
