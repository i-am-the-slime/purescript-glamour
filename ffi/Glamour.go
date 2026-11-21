package glamour

import (
	"github.com/charmbracelet/glamour"
	. "github.com/purescript-native/go-runtime"
)

func init() {
	exports := Foreign("Glamour")

	exports["renderImpl"] = func(input_, style_ Any) Any {
		out, err := glamour.Render(input_.(string), style_.(string))
		if err != nil {
			return Dict{"tag": "Left", "value0": err.Error()}
		}
		return Dict{"tag": "Right", "value0": out}
	}

	exports["renderWithWidthImpl"] = func(input_, style_, width_ Any) Any {
		r, err := glamour.NewTermRenderer(
			glamour.WithStandardStyle(style_.(string)),
			glamour.WithWordWrap(width_.(int)),
		)
		if err != nil {
			return Dict{"tag": "Left", "value0": err.Error()}
		}
		out, err := r.Render(input_.(string))
		if err != nil {
			return Dict{"tag": "Left", "value0": err.Error()}
		}
		return Dict{"tag": "Right", "value0": out}
	}

	exports["styleAuto"] = "auto"
	exports["styleAscii"] = "ascii"
	exports["styleDark"] = "dark"
	exports["styleLight"] = "light"
	exports["styleDracula"] = "dracula"
	exports["styleTokyoNight"] = "tokyo-night"
	exports["stylePink"] = "pink"
	exports["styleNoTTY"] = "notty"
}
