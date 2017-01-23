-- Stage 1: build initrd:
local config = require('buildconfig')

function slurp(file)
	local fh       = io.open(file, 'rb')
	local contents = fh:read('*all')
	fh:close()
	return contents
end

local initrd = 'INITRD = { '
for _, v in ipairs(config.initrd_files) do
	local file_contents = slurp(v)
	initrd = initrd .. "['/" .. v .. "']=[==[ " .. file_contents .. " ]==],"
end
initrd = initrd .. '}'
local fh = io.open('kernel/core.lua', 'rb')
local core = fh:read('*all')
fh:close()

local fh = io.open('kimage.lua', 'wb')
fh:write(initrd .. ' ' .. core)
fh:close()
