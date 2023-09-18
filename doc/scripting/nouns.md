# nouns
## what?
The most basic item that will be worked on by verbs. It must start with an alphanumeric character (regex `\w`) and can contain anything after that.

## how?
```
+someverb
	noun1 noun2
	+someotherverb
		noun3 noun4
```

In this example, nouns 1 and 2 will be worked on by "some_verb", while 3 and 4 will be worked on by "some_verb" and "some_other_verb".