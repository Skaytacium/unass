dump = require "pl.pretty".dump
-- I know util is bad practice, but it really is util
require("util")
FILE = io.open("unass", "r")
INTERNALS = require("internals")
SETTERS = require("setters")

---@alias run_entry
---| { verb: string, dir: string, branch?: string, args?: string }
---@type run_entry[][]
RUNLIST = {}

POINTER=1

---@type {[string]: string}
OPTIONS = {
	["elevate"] = "sudo",
	["store"] = "~/.store"
}


---@param line string line to parse
---@return nil | false
function PARSE(line)
	if line == nil then return false end
	if #line == 0 then return end

	-- Syntax is rigid, so this will always be in the beginning
	local _, depth = line:gsub("\t", "")
	---@type run_entry[]

	for word in line:gmatch("%g+") do
		if word == "#" then break end

		if IS_KEY(INTERNALS, word) then
			-- Don't waste iterations and pass remaining line to internal
			if INTERNALS[word](line:gsub("^.-" .. word .. " ", "")) then break end
		elseif IS_KEY(SETTERS, word) then
			table.insert(RUNLIST[depth + 1], { [SETTERS[word]] =  })
		else
			print("bruhh " .. word)
		end
	end
end

repeat until PARSE(FILE:read("l")) == false