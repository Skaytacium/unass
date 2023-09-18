# adjectives
## what?
Give a noun additional info that it needs. This depends on the noun *and* the verb and is usually mandatory. They start with `,` and can contain anything. Adjectives are **single-use only**, they will only be applicable to the noun that follows them and will immediately be dropped after that noun.

## how?
```
verb
	,adjective noun1 noun2
```
```
,adjective

verb
	noun1 noun2
```

In both cases, `verb` will be performed on `noun1`, which will be given `adjective`, and `noun2`, which will have no adjective. Although the first syntax is *strongly recommended* it is not mandatory, since due to lexing and parsing limitations, adjectives can be put anywhere before a noun.

```
verb
,adjective
	noun1 noun2
```

Do **not** do this, this will cause `verb` to be dropped since the next line isn't indented, so `noun1` and `noun2` will have no verbs which is an error. Currently, only adjectives have this syntax quirk.