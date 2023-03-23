use logos::Logos;

#[derive(Logos, Debug, PartialEq, Clone)]
pub enum Token<'a> {
	#[token("\n")]
	Line,
	#[token("\t")]
	Indent,
	#[regex(r"[/~][\w.\-/]+", |lex| lex.slice())]
	Path(&'a str),
	#[regex(r"@[\w.\-/]+", |lex| &lex.slice()[1..])]
	Branch(&'a str),
	#[regex(r#""([^"]|\\")+""#, |lex| &lex.slice()[1..lex.slice().len() - 1])]
	Argument(&'a str),
	#[regex(r"\+[a-z]+", |lex| &lex.slice()[1..])]
	Verb(&'a str),
	#[regex(r"-[a-z]+", |lex| &lex.slice()[1..])]
	Defer(&'a str),
	#[regex(r"=\S+", |lex| &lex.slice()[1..])]
	Value(&'a str),
	// Should override the rest
	#[regex(r"!.+", |lex| &lex.slice()[1..], priority=100)]
	Shell(&'a str),
	#[regex(r"\w[^\s,=]+", |lex| lex.slice())]
	Noun(&'a str),
	#[regex(r",\S+", |lex| &lex.slice()[1..])]
	Adjective(&'a str),
	#[error]
	#[regex(r"\#.+", logos::skip)]
	#[token(" ", logos::skip)]
	Error
}