---@module 'quick-actions'
local M = {}

local defaults = {
	enabled = true,
	config_filename = ".nvimqa",
}

---@param opts? quick-actions.SetupOpts
function M.setup(opts)
	M.opts = vim.tbl_deep_extend("force", defaults, opts or {})

	local schema = vim.fn.stdpath("data") .. "/lazy/quick-actions.nvim/schemas/quick-actions.schema.json"
	vim.lsp.config["yamlls"] = vim.tbl_deep_extend("force", vim.lsp.config["yamlls"] or {}, {
		settings = {
			yaml = {
				schemas = {
					[schema] = M.opts.config_filename,
				},
			},
		},
	})
end

function M.postSave()
	if vim.fn.executable("./onSave") == 1 then
		vim.notify("running ./onSave")
		vim.system({ "./onSave" }, { text = true }, function(obj)
			if obj.stdout ~= "" then
				vim.notify(obj.stdout)
			end
			if obj.stderr ~= "" then
				vim.notify(obj.stderr, vim.log.levels.WARN)
			end
		end)
	end
end

function M.postRead() end

---@param filepath string
function loadYaml(filepath)
	if vim.fn.filereadable(filepath) == 0 then
		return {}
	end
	local file = io.open(filepath, "r")
	if not file then
		return {}
	end
	local filecontent = file:read("*a")
	local contents = require("quick-actions.lib.lua-tinyyaml.tinyyaml").parse(filecontent)
	return contents
end

function M.loadConfig()
	local filepath = "./" .. M.opts.config_filename
	local content = loadYaml(filepath)
	if content == {} then
		return
	end
end

return M
