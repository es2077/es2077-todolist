open Ancestor.Default

@module("./check-icon.svg") @scope("default") external checkIcon: string = "src"

Js.log(checkIcon)

module Style = {
  open Emotion

  let fillAnimation = keyframes({
    "0": {
      "transform": "scale(0)",
    },
    "50%": {
      "transform": "scale(1.25)",
    },
    "100%": {
      "transform": "scale(1)",
    },
  })

  let checkbox = css({
    "cursor": "pointer",
    "> input": {
      "display": "none",
    },
    "> div": {
      "position": "relative",
      "width": "2.4rem",
      "height": "2.4rem",
      "border": `solid 1px ${Theme.Colors.purple->Theme.Colors.toString}`,
      "borderRadius": "6px",
      "> img": {
        "position": "absolute",
        "top": "0.5rem",
        "left": "0.4rem",
        "transform": "scale(0)",
      },
      "&:after": {
        "borderRadius": "6px",
        "content": "' '",
        "position": "absolute",
        "width": "100%",
        "height": "100%",
        "top": 0,
        "left": 0,
        "transform": "scale(0)",
        "background": Theme.Colors.purple->Theme.Colors.toString,
      },
    },
    "> input:checked + div": {
      "> img": {
        "z-index": "10",
        "animation": `${fillAnimation} 300ms forwards`,
        "animationDelay": "100ms",
      },
      "&:after": {
        "animation": `${fillAnimation} 300ms forwards`,
      },
    },
  })
}

@react.component
let make = (~checked) => {
  <Box tag=#label className=Style.checkbox>
    <input checked type_="checkbox" /> <div> <img src=checkIcon /> </div>
  </Box>
}
