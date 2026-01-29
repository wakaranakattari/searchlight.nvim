local state = require("custom.searchlight.state")
local M = {}
local ns = vim.api.nvim_create_namespace("Searchlight")

function M.draw(buf)
	if not vim.api.nvim_buf_is_valid(buf) then
		return
	end

	local s = state.get()
	local lines = { " Search: " .. s.query, "" }
	local map, highlights = {}, {}

	vim.bo[buf].modifiable = true
	vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)

	for file, matches in pairs(s.results) do
		local folded = state.is_folded(file)
		local icon = folded and "▶" or "▼"

		table.insert(lines, " " .. icon .. " " .. file .. " (" .. #matches .. ")")
		map[#lines] = { type = "file", file = file }

		if not folded then
			for _, m in ipairs(matches) do
				local text = string.format("     %4d │ %s", m.lnum, m.text)
				table.insert(lines, text)
				local lnum = #lines
				map[lnum] = { type = "match", file = file, lnum_file = m.lnum }

				local base = text:find("│", 1, true) + 2
				local from = 1
				local q, t = s.query:lower(), m.text:lower()

				while true do
					local s1, e1 = t:find(q, from, true)
					if not s1 then
						break
					end
					table.insert(highlights, { lnum - 1, base + s1 - 1, base + e1 })
					from = e1 + 1
				end
			end
		end

		table.insert(lines, "")
	end

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

	for _, h in ipairs(highlights) do
		vim.api.nvim_buf_add_highlight(buf, ns, "Search", h[1], h[2], h[3])
	end

	vim.bo[buf].modifiable = false
	state.set_line_map(map)
end

return M
