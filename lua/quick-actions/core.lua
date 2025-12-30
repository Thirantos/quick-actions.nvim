local M = {}

M.actions = {}
M.auto = {
	onSave = nil,
	onOpen = nil,
	onExit = nil,
	onNew = nil,
}

---@alias actionsSet
---| 'auto'
---| 'actions'

---@param set actionsSet
---@param action string
function M.runAction(set, action)
	if M[set][action] == nil then
		vim.notify("Action " .. action .. " not found.", vim.log.levels.ERROR)
		return
	end

	vim.notify("Running " .. action)

	if M[set][action].cmd ~= nil then
		for _, command in pairs(M[set][action].cmd) do
			require("quick-actions.utils").runShell(command)
		end
	end

	if M[set][action].vim ~= nil then
		for _, command in pairs(M[set][action].vim) do
			vim.cmd(command)
		end
	end
end
return M
