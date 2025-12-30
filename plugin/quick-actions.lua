-- commands, autocmd's and keymaps go here!

local group = vim.api.nvim_create_augroup("quick-actions", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
	group = group,
	callback = require("quick-actions").postSave,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	group = group,
	callback = require("quick-actions").postRead,
})

vim.api.nvim_create_autocmd("DirChanged", {
	group = group,
	pattern = "global",
	callback = require("quick-actions").loadConfig,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = require("quick-actions").opts.config_filename,
	callback = function()
		vim.bo.filetype = "yaml"
	end,
})

require("quick-actions").loadConfig()
