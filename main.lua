dump = require "pl.pretty".dump
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

local lex = require("lexer")
local parse = require("parser")
local sanitize = require("sanitizer")
local run = require("runner")

---@alias run_entry
---| { dir?: string, branch?: string, args?: string, verbs?: string[], depth?: integer }
---@type run_entry[]
RUNLIST = {}

local line = ""
repeat
	local items
	local tokens, depth = lex(line)

	if tokens and depth then items = parse(tokens, depth) end
	if items then
		for _, item in ipairs(items) do
			print(run(item, sanitize()))
		end
	end

	---@diagnostic disable-next-line: need-check-nil
	line = script:read()
until not line