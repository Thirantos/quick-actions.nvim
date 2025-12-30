local M = {}

---@param filepath string
function M.loadYaml(filepath)
	if vim.fn.filereadable(filepath) == 0 then
		return {}
	end

	local file = io.open(filepath, "r")
	if not file then
		return {}
	end

	local filecontent = file:read("*a")
	if filecontent == "" then
		return {}
	end

	local contents = require("quick-actions.lib.lua-tinyyaml.tinyyaml").parse(filecontent or "")
	return contents
end

---@param command string
function M.runShell(command)
	vim.system({ "/usr/bin/env", "sh", "-c", command }, { text = true }, function(obj)
		if obj.stdout ~= "" then
			vim.notify(obj.stdout)
		end
		if obj.stderr ~= "" then
			vim.notify(obj.stderr, vim.log.levels.WARN)
		end
	end)
end

return M
