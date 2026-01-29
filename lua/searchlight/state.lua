local M = {}

local state = {
	query = "",
	results = {},
	line_map = {},
	folded = {},
}

function M.set_query(q)
	state.query = q or ""
end
function M.set_results(r)
	state.results = r or {}
end
function M.get()
	return state
end

function M.set_line_map(map)
	state.line_map = map or {}
end
function M.get_line_map()
	return state.line_map
end

function M.toggle_fold(file)
	state.folded[file] = not state.folded[file]
end
function M.is_folded(file)
	return state.folded[file]
end

return M
