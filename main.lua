---@type {[string]: string}
OPTIONS = {
	["elevate"] = "sudo",
	["store"] = "~/store"
}

-- I know util is bad practice, but it really is util
require("util")
require("commands")

local script = io.open("unass", "r")

VERBS = READ_DIR("verbs")

-- 1: **bold**, 2: <sup>dim</sup>, 3: *italic*, 4: <u>uline</u>, 5: blinking, 7: inverse, 8: hidden, 9: ~~strike~~  
-- fg: 3, bg: fg +1, bright: fg/bg + 6  
-- 0: black, 1: red, 2: green, 3: yellow, 4: blue, 5: magenta, 6: cyan, 7: white
---@param x string?
---@param y string?
function P(x, y)
	if not y then
		io.write("\x1B[0m")
		if x then io.write("\x1B[" .. x .. "m") end
	else print(("\x1B[%sm"):format(x) .. y .. "\x1B[0m") end
end

local lex = require("lexer")
local parse = require("parser")
local sanitize = require("sanitizer")
local run = require("runner")

---@alias run_entry
---| { dir?: string, branch?: string, args?: string, verbs?: string[], defer?: integer }
---@type run_entry[]
RUNLIST = {}

local line = ""
repeat
	local items
	local tokens, depth = lex(line)

	if tokens and depth then items = parse(tokens, depth) end
	if items then
		for _, item in ipairs(items) do
			run(item, sanitize())
		end
	end

	---@diagnostic disable-next-line: need-check-nil
	line = script:read()
until not line