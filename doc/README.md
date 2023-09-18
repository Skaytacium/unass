# documentation
## overview?
unass is a full-system syncing tool that supports downloading, compiling, installing, extracting and of course, managing your dotfiles with conflict resolution and diffing. A unique approach is used to multi-machine dotfiles that can vary quite a bit, and control over even system configurations, like sshd, apt/xbps/pacman repositories, wi-fi configurations and more is given. Since the goal was to have a base set of dotfiles that can vary greatly from system to system, the program achieves this simply by using git branches.

## index?
- [concepts](concepts/)
	- [store](concepts/store)
	- [branches](concepts/branches)
	- [syncing](concepts/syncing)
	- [applying](concepts/applying)
- [scripting](scripting/)
	- [nouns](scripting/nouns)
	- [verbs](scripting/verbs)
	- [adverbs](scripting/adverbs)
	- [adjectives](scripting/adjectives)
	- [deferring verbs](scripting/deferring)
	- [internal verbs](scripting/internals/)
		- [set](scripting/internals/set)
		- [shell](scripting/internals/shell)
		- [sync](scripting/internals/sync)
		- [apply](scripting/internals/apply)

## example?
[my unass script](../unass)

## and?

comments start with `#` and include the rest of the line