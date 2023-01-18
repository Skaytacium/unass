dump = require "pl.pretty".dump
-- I know util is bad practice, but it really is util
require("util")
require("commands")

local script = io.open("unass", "r")

VERBS = READ_DIR("verbs")

local lex = require("lexer")
local parse = require("parser")
local perform = require("perform")

---@alias run_entry
---| { dir?: string, branch?: string, args?: string, verbs?: string[], depth?: integer }
---@type run_entry[]
RUNLIST = {}

---@type {[string]: string}
OPTIONS = {
	["elevate"] = "sudo",
	["store"] = "~/store"
}

local line = ""
repeat
	local items
	local tokens, depth = lex(line)

	if tokens and depth then items = parse(tokens, depth) end
	if items then perform(items) end

	---@diagnostic disable-next-line: need-check-nil
	line = script:read()
until not line