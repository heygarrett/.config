local M = {}

---@type table | nil
M.inputDevice = hs.audiodevice.defaultInputDevice()

---@return boolean | nil
function M:micMuted() return M.inputDevice and M.inputDevice:muted() end

function M:updateMenubarIcon()
	local status = "⭕️"
	if M:micMuted() ~= nil then
		status = M:micMuted() and "⚪️" or "🔴"
	end
	self.menubarIcon:setTitle("🎙️" .. status)
end

function M:toggleMute()
	if M:micMuted() ~= nil then
		M.inputDevice:setInputMuted(not M.inputDevice:muted())
	end
	self:updateMenubarIcon()
end

function M:init()
	self.menubarIcon = hs.menubar.new()
	self.menubarIcon:setClickCallback(function() self:toggleMute() end)
	self:updateMenubarIcon()

	hs.audiodevice.watcher.setCallback(function(arg)
		if arg:find("dIn ") then
			self:updateMenubarIcon()
		end
	end)
	hs.audiodevice.watcher.start()
end

M:init()
