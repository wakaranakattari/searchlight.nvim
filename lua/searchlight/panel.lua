local renderer = require("custom.searchlight.renderer")
local state = require("custom.searchlight.state")
local preview = require("custom.searchlight.preview")

local M = {}

function M.open()
	vim.cmd("vsplit")
	local win = vim.api.nvim_get_current_win()
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_win_set_buf(win, buf)

	renderer.draw(buf)

	vim.keymap.set("n", "q", function()
		preview.close()
		vim.api.nvim_win_close(win, true)
	end, { buffer = buf })

	vim.keymap.set("n", "<CR>", function()
		local item = state.get_line_map()[vim.fn.line(".")]
		if not item then
			return
		end

		if item.type == "match" then
			preview.close()
			vim.cmd("edit " .. item.file)
			vim.api.nvim_win_set_cursor(0, { item.lnum_file, 0 })
		elseif item.type == "file" then
			state.toggle_fold(item.file)
			renderer.draw(buf)
		end
	end, { buffer = buf })

	vim.api.nvim_create_autocmd("CursorMoved", {
		buffer = buf,
		callback = function()
			local item = state.get_line_map()[vim.fn.line(".")]
			if item and item.type == "match" then
				preview.show(item.file, item.lnum_file, state.get().query)
			end
		end,
	})
end

return M
