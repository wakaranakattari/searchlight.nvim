local uv = vim.loop
local parser = require("custom.searchlight.parser")

local M = {}

function M.run(query, on_done)
	local stdout = uv.new_pipe(false)
	local results = {}

	local handle
	handle = uv.spawn("rg", {
		args = { "--json", "--smart-case", "--line-number", "--column", query, "." },
		stdio = { nil, stdout, nil },
		cwd = uv.cwd(),
	}, function()
		vim.schedule(function()
			on_done(results)
		end)
	end)

	if not handle then
		vim.notify("rg not found", vim.log.levels.ERROR)
		return
	end

	stdout:read_start(function(err, data)
		if err then
			return
		end
		if data then
			parser.feed(data, results)
		end
	end)
end

return M
