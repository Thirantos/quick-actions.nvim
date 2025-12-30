local M = {}
M.bindings = {}

---@param key string
---@param action string
function M.register(key, action)
	M.bindings[key] = action
end

function M.dispatch()
	local ok, key = pcall(vim.fn.getcharstr)
	if not ok then
		return
	end

	local action = M.bindings[key]
	if action then
		require("quick-actions.core").runAction("actions", action)
	else
		vim.notify("No action bound to " .. key, vim.log.levels.WARN)
	end
end

return M
