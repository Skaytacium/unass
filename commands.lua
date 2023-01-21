---@alias command
---| { state: number | string, command?: string, callback?: fun(input: string[]): nil }
---@type {[string]: command}
COMMANDS = {
	set = {
		state = 3,
		callback = function (input)
			OPTIONS[input[1]] = input[2]
		end
	},
	run = {
		state = 2,
		callback = function (input)
			print("run " .. table.concat(input, " "))
		end
	},
	shell = {
		state = 0,
		callback = function (input)
			-- os.execute(table.concat(input, " "))
			print("shell " .. table.concat(input, " "))
		end
	},
	dir = {
		state = 2,
	},
	branch = {
		state = 2,
	},
	args = {
		state = 2,
	}
}