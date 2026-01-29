local M = {}
local preview_win

local function ensure_preview()
	for _, w in ipairs(vim.api.nvim_list_wins()) do
		if vim.wo[w].previewwindow then
			preview_win = w
			return
		end
	end

	vim.cmd("botright vnew")
	preview_win = vim.api.nvim_get_current_win()
	vim.wo.previewwindow = true
	vim.wo.winfixwidth = true
	vim.wo.number = true
	vim.wo.relativenumber = false
	vim.wo.wrap = false
	vim.cmd("wincmd p")
end

function M.show(file, lnum, query)
	ensure_preview()

	vim.api.nvim_win_call(preview_win, function()
		vim.cmd("edit " .. vim.fn.fnameescape(file))

		vim.cmd("filetype detect")
		vim.cmd("syntax enable")

		vim.api.nvim_win_set_cursor(preview_win, { lnum, 0 })
		vim.cmd("normal! zz")

		vim.fn.clearmatches()
		if query and query ~= "" then
			vim.fn.matchadd("Search", vim.fn.escape(query, "\\/.*$^~[]"))
		end
	end)
end

function M.close()
	for _, w in ipairs(vim.api.nvim_list_wins()) do
		if vim.wo[w].previewwindow then
			vim.api.nvim_win_close(w, true)
		end
	end
	preview_win = nil
end

return M
