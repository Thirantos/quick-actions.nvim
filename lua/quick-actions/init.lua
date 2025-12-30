---@module 'quick-actions'
local M = {}
local keybindings = require("quick-actions.keybindings")
local core = require("quick-actions.core")
local defaults = {
	actions_filename = ".nvimqa",
	keybind_prefix = "<leader>a",
}

---@param opts? quick-actions.SetupOpts
function M.setup(opts)
	M.opts = vim.tbl_deep_extend("force", defaults, opts or {})

	local schema = vim.fn.stdpath("data") .. "/lazy/quick-actions.nvim/schemas/quick-actions.schema.json"
	vim.lsp.config["yamlls"] = vim.tbl_deep_extend("force", vim.lsp.config["yamlls"] or {}, {
		settings = {
			yaml = {
				schemas = {
					[schema] = M.opts.actions_filename,
				},
			},
		},
	})

	vim.filetype.add({
		pattern = {
			[M.opts.actions_filename] = "yaml",
		},
	})

	M.reloadConfig()

	vim.keymap.set("n", M.opts.keybind_prefix, keybindings.dispatch, {
		noremap = true,
		silent = true,
		desc = "QuickActions",
	})
end

---@param action quick-actions.AutoActionType
function M.autoAction(action)
	return function()
		if core.auto[action] == nil then
			return
		end

		core.runAction("auto", action)
	end
end

function M.run(action)
	core.runAction("actions", action)
end

function M.reloadConfig()
	keybindings.bindings = {}
	core.actions = {}
	core.auto = {}

	local filepath = "./" .. M.opts.actions_filename
	local content = require("quick-actions.utils").loadYaml(filepath)
	if content == {} then
		return
	end

	if content.auto ~= nil then
		core.auto = content.auto
	end

	if content.actions ~= nil then
		core.actions = content.actions

		for action, data in pairs(core.actions) do
			if data.keybind ~= nil then
				keybindings.register(data.keybind, action)
			end
		end
	end
end

return M
