%raw(`require('normalize.css')`)

type pageProps

type props = {
  @as("Component")
  component: React.component<pageProps>,
  pageProps: pageProps,
}

Emotion.injectGlobal({
  "html": {
    "fontSize": "10px",
  },
  "html, body, body > div": {
    "width": "100%",
    "height": "100%",
  },
  "*": {
    "boxSizing": "border-box",
    "fontFamily": Theme.Constants.fontFamily,
  },
  "&::selection": {
    "color": Theme.Colors.white->Theme.Colors.toString,
    "background": Theme.Colors.purple->Theme.Colors.toString,
  },
})

let client = ReactQuery.Provider.createClient()

let default = (props): React.element => {
  let {component, pageProps} = props
  let children = React.createElement(component, pageProps)
  <ReactQuery.Provider client> children </ReactQuery.Provider>
}
