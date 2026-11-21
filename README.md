# purescript-glamour

Markdown for the terminal in PureScript, with [Glamour](https://github.com/charmbracelet/glamour).
For PureScript compiled to Go with [Iris](https://github.com/i-am-the-slime/purescript-analyzer/tree/iris-go).

```purescript
import Glamour (Theme(..))
import Glamour as Glamour

case Glamour.render _ { theme = Dracula, width = 60 } "# Hello\n\nSome *emphasis* and `code`." of
  Right styled -> log styled
  Left problem -> log ("can't render: " <> problem)
```

| Option | Default | |
| --- | --- | --- |
| `theme` | `Dark` | `Dark`, `Light`, `Dracula`, `TokyoNight`, `Pink`, `Ascii`, or `NoColors` |
| `width` | `80` | wrap at this many cells; `0` doesn't wrap |
| `emoji` | `false` | turn `:wave:` into 👋 |
| `preserveNewLines` | `false` | keep the line breaks inside paragraphs |

It's a pure function, so it goes straight into a [Bubble Tea](../purescript-bubbletea) view;
the `Signup` example there renders its welcome with it.

## Changes from the old bindings

- `render style text` and `renderWithWidth` became `render _ { theme, width, … } text`.
- `Auto` is gone (pick `Dark` or `Light`), `NoTTY` is `NoColors`. New: `emoji`, `preserveNewLines`.
- Glamour v2 from `charm.land`.

## Go only

There are no `.js` files: this package only works with Iris's Go backend. Run `./test.sh` for the
specs.
