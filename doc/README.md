# Documentation
## Overview?
unass is a full-system syncing tool that supports downloading, compiling, installing, extracting and of course, managing your dotfiles with conflict resolution and diffing. A unique approach is used to multi-machine dotfiles that can vary quite a bit, and control over even system configurations, like sshd, apt/xbps/pacman repositories, wi-fi configurations and more is given. Since the goal was to have a base set of dotfiles that can vary greatly from system to system, the program achieves this simply by using git branches.

## Index?
- [Concepts](concepts/)
	- [Store](concepts/store)
	- [Branches](concepts/branches)
	- [Syncing](concepts/syncing)
	- [Applying](concepts/applying)
- [Scripting](scripting/)
	- [Nouns](scripting/nouns)
	- [Verbs](scripting/verbs)
	- [Adverbs](scripting/adverbs)
	- [Adjectives](scripting/adjectives)
	- [Deferring verbs](scripting/deferring)
	- [Internal verbs](scripting/internals/)
		- [Set](scripting/internals/set)
		- [Shell](scripting/internals/shell)
		- [Sync](scripting/internals/sync)
		- [Apply](scripting/internals/apply)

## Example?
[My unass script](../unass)

## And?

Comments start with `#` and include the rest of the line