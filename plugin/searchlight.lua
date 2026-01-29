vim.api.nvim_create_user_command("Searchlight", function(opts)
	require("custom.searchlight").open(opts.args)
end, { nargs = 1 })
