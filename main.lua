dump = require "pl.pretty".dump
-- I know util is bad practice, but it really is util
require("util")
require("commands")

local script = io.open("unass", "r")
if not script then print("unass script not found"); os.exit(false) end

VERBS = READ_DIR("verbs")

local parse = require("parse")
local generate = require("generate")
local perform = require("perform")

---@alias run_entry
---| { verbs?: string[], dir?: string, branch?: string, args?: string }
---@type run_entry[]
RUNLIST = {}

---@type {[string]: string}
OPTIONS = {
	["elevate"] = "sudo",
	["store"] = "~/store"
}

local line = ""
repeat
	local item
	local tokens, depth = parse(line)
	if tokens and depth then item = generate(tokens, depth) end
	if item then perform(item) end
	---@diagnostic disable-next-line: need-check-nil
	line = script:read()
until not line