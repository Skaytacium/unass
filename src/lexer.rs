use logos::Logos;

#[derive(Logos, Debug, PartialEq, Clone)]
#[logos(skip r"#.+")]
#[logos(skip " ")]
#[logos(skip "\r")]
pub enum Token<'a> {
	#[token("\n")]
	Line,
	#[token("\t")]
	Indent,
	#[regex(r"[/~][\w.\-_/]+", |lex| lex.slice())]
	Path(&'a str),
	#[regex(r"@[\w.\-_/]+", |lex| &lex.slice()[1..])]
	Branch(&'a str),
	#[regex(r#""([^"]|\\")+""#, |lex| &lex.slice()[1..lex.slice().len() - 1])]
	Argument(&'a str),
	#[regex(r"\+[a-z]+", |lex| &lex.slice()[1..])]
	Verb(&'a str),
	#[regex(r"-[a-z]+", |lex| &lex.slice()[1..])]
	Defer(&'a str),
	// should override the rest
	#[regex(r"!.+", |lex| &lex.slice()[1..])]
	Shell(&'a str),
	#[regex(r"\w[^\s]*", |lex| lex.slice())]
	Noun(&'a str),
	#[regex(r",[^\s#]+", |lex| &lex.slice()[1..])]
	Adjective(&'a str),
}
