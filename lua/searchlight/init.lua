local rg = require("custom.searchlight.rg")
local panel = require("custom.searchlight.panel")
local state = require("custom.searchlight.state")

local M = {}

function M.open(query)
	state.set_query(query)
	rg.run(query, function(results)
		state.set_results(results)
		panel.open()
	end)
end

return M
