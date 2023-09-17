# Adverbs
## What?
Modify the execution of a verb. They can be mandatory or optional. Can be from the following:
### Path
Starts with either `~` or `/` and contain valid path characters (regex `[\w.\-_/]`)

### Branch
Starts with `@` and contains valid git branch characters (regex `[\w.\-_/]`)

### Arguments
Are surrounded by `"` and can contain anything.

Only one adverb per type can modify a verb, it cannot have for example, 2 paths or 2 branches.
## How?
```
/some/dir "--with-this-argument" @on-this-branch +dothisverb
	on_this_noun
```

This will perform the verb `dothisverb` on the noun `on_this_noun` in `/some/dir` on ``