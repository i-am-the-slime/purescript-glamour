package ffi

import "charm.land/glamour/v2"

func RenderImpl[R any](failed func(string) R, rendered func(string) R, theme string, width int32, emoji bool, preserveNewLines bool, markdown string) R {
	options := []glamour.TermRendererOption{glamour.WithStandardStyle(theme), glamour.WithWordWrap(int(width))}
	if emoji {
		options = append(options, glamour.WithEmoji())
	}
	if preserveNewLines {
		options = append(options, glamour.WithPreservedNewLines())
	}
	renderer, err := glamour.NewTermRenderer(options...)
	if err != nil {
		return failed(err.Error())
	}
	out, err := renderer.Render(markdown)
	if err != nil {
		return failed(err.Error())
	}
	return rendered(out)
}
