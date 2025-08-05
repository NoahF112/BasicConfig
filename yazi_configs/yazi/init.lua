require("git"):setup{}
Status:children_add(function()
	local h = cx.active.current.hovered
	return ui.Line({
		ui.Span(os.date(_, tostring(h.cha.mtime):sub(1, 10))):fg("blue"),
		ui.Span(" "),
	})
end, 500, Status.RIGHT)
