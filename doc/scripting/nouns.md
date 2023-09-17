# Nouns
## What?

The thing itself that a [verb](verb) will be performing on. This is the most basic element in a script. It starts with an alphanumeric character (regex \w) and can contain anything after that.

## How?

```r
+some_verb
	noun1 noun2
	+some_other_verb
		noun3 noun4
```

In this example, nouns 1 and 2 will be worked on by "some_verb", while 3 and 4 will be worked on by "some_verb" and "some_other_verb".