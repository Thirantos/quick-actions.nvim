-- commands, autocmd's and keymaps go here!

local group = vim.api.nvim_create_augroup("QuickActions", { clear = true })

vim.api.nvim_create_user_command("QuickAction", function(f)
	if #f.args == 0 then
		vim.notify("quick-action requires the action as an argument", vim.log.level.error)
		return
	end
	require("quick-actions").run(f.args)
end, { nargs = 1 })

vim.api.nvim_create_autocmd("BufWritePost", {
	group = group,
	callback = function()
		require("quick-actions").reloadConfig()
		require("quick-actions").autoAction("onSave")()
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	group = group,
	callback = require("quick-actions").autoAction("onOpen"),
})

vim.api.nvim_create_autocmd("BufNewFile", {
	group = group,
	callback = require("quick-actions").autoAction("onNew"),
})

vim.api.nvim_create_autocmd("ExitPre", {
	group = group,
	callback = require("quick-actions").autoAction("onExit"),
})

vim.api.nvim_create_autocmd("DirChanged", {
	group = group,
	pattern = "global",
	callback = require("quick-actions").reloadConfig,
})
