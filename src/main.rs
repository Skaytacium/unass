use errors::{add_error, ErrorKind};
use lexer::Token;
use logos::Logos;
use std::{io::LineWriter, path::PathBuf, println};

mod errors;
mod lexer;
mod runner;

#[derive(Debug, Clone)]
pub struct Adverbs<'a> {
	pub path: Option<&'a str>,
	pub branch: Option<&'a str>,
	pub arg: Option<&'a str>,
}

#[derive(Debug, Clone)]
pub struct Verbs<'a> {
	pub adverb: Adverbs<'a>,
	pub verbs: Vec<&'a str>,
	pub defer: usize,
}
#[derive(Debug, Clone)]
pub struct Noun<'a> {
	pub noun: &'a str,
	pub adj: Option<&'a str>,
}

pub struct Config {
	elevate: Option<String>,
	store: Option<PathBuf>,
}

fn resize(act: &mut Vec<Verbs>, size: usize) {
	act.resize(
		size,
		Verbs {
			adverb: Adverbs {
				path: None,
				branch: None,
				arg: None,
			},
			verbs: Vec::new(),
			defer: 0,
		},
	)
}

fn main() {
	let mut config = Config {
		elevate: None,
		store: None,
	};

	let file = std::fs::read("unass");
	let bytes: Vec<u8>;

	match file {
		Ok(store) => bytes = store,
		Err(error) => {
			add_error(error, "{script}", 0);
			std::process::exit(1);
		}
	}

	let source = String::from_utf8(bytes).expect("Invalid UTF8 encoding.");
	let token_stream = Token::lexer(&source);

	let mut lines = 1;
	let mut depth = 0;
	let mut resized = false;
	let mut act: Vec<Verbs> = Vec::new();
	let mut adjective: Option<&str> = None;

	for (token, slice) in token_stream.spanned() {
		if token != Token::Line && token != Token::Indent && !resized {
			if depth == 0 {
				act.clear()
			}
			// Erase act[depth]+1
			resize(&mut act, depth);
			resize(&mut act, depth + 1);
			resized = true;
		}
		match token {
			Token::Line => {
				// Toggle for resizing (clearing) to happen only after indents
				resized = false;
				lines += 1;
				depth = 0;
			}
			Token::Indent => depth += 1,
			Token::Path(path) => act[depth].adverb.path = Some(path),
			Token::Branch(branch) => act[depth].adverb.branch = Some(branch),
			Token::Argument(arg) => act[depth].adverb.arg = Some(arg),
			Token::Verb(verb) => act[depth].verbs.push(verb),
			Token::Defer(verb) => {
				act[depth].verbs.insert(0, verb);
				act[depth].defer += 1;
			}
			Token::Noun(noun) => {
				let (verbs, adverbs) = runner::squash(&act);
				runner::run(&Noun { noun: noun, adj: adjective }, &verbs, &adverbs);
				adjective = None;
			}
			Token::Adjective(adj) => adjective = Some(adj),
			Token::Shell(shell) => {
				act[depth].verbs.push("shell");
				let (verbs, adverbs) = runner::squash(&act);
				runner::run(&Noun { noun: shell, adj: adjective }, &verbs, &adverbs);
			},
			Token::Error => add_error(ErrorKind::Token, &source[slice], lines)
		}
	}
}
