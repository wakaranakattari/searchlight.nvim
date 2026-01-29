local M = {}

local function ensure(tbl, file)
	if not tbl[file] then
		tbl[file] = {}
	end
end

function M.feed(chunk, results)
	for line in chunk:gmatch("[^\n]+") do
		local ok, obj = pcall(vim.json.decode, line)
		if ok and obj.type == "match" then
			local file = obj.data.path.text
			ensure(results, file)

			table.insert(results[file], {
				lnum = obj.data.line_number,
				text = obj.data.lines.text:gsub("\n", ""),
			})
		end
	end
end

return M
