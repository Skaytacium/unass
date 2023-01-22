---@param repo string
---@param dir string
---@param args string?
return function(repo, dir, args)
	local remote = "https://%s.com/" .. repo

	if #TRY_UNTIL({
		"curl -fL https://github.com/" .. repo .. " >/dev/null 2>&1",
		repo .. " not available on GitHub, trying GitLab",
		"using GitHub for " .. repo
	}, {
		"curl -fL https://gitlab.com/" .. repo .. " >/dev/null 2>&1",
		repo .. " not available on GitLab",
		"using GitLab for " .. repo
	}) == 1 then remote = remote:format("github")
	else remote = remote:format("gitlab") end

	print(remote:match("[^/]+$"))
end

-- if [ -d "$1" ]; then
-- 	cd "$1"
-- 	git pull && git submodule update --recursive
-- else
-- 	git clone "$2" "$1"
-- fi