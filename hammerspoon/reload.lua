local M = {}

function M:reload(files)
	local doReload = false
	for _, file in pairs(files) do
		if file:sub(-4) == ".lua" then
			doReload = true
		end
	end
	if doReload then
		hs.reload()
	end
end

function M:init()
	self.watcher = hs.pathwatcher
		.new(
			os.getenv("HOME") .. "/.config/hammerspoon/",
			function(files) self:reload(files) end
		)
		:start()
	hs.notify.new({ title = "Hammerspoon", informativeText = "Config loaded" }):send()
end

M:init()
