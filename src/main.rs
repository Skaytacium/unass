use errors::{raise, Error};
use lexer::Token;
use logos::Logos;
use std::path::PathBuf;

mod errors;
mod lexer;
mod runner;
mod util;

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

pub struct Config<'a> {
	elevate: Option<&'a str>,
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
			raise(error, 0, 0, "{script}");
			std::process::exit(1);
		}
	}

	let source = String::from_utf8(bytes).expect("Invalid UTF8 encoding.");
	let token_stream = Token::lexer(&source);

	let mut lines = 1;
	let mut chr = 1;
	let mut depth = 0;
	let mut resized = false;
	let mut act: Vec<Verbs> = Vec::new();
	let mut adjective: Option<&str> = None;

	for (ptoken, slice) in token_stream.spanned() {
		if let Err(_) = ptoken {
			raise(Error::Token, lines, slice.start - chr, &source[slice]);
			break;
		}
		let token = ptoken.unwrap();
		if matches!(adjective, Some(_)) && matches!(token, Token::Adjective(_)) {
			raise(Error::Adjective, lines, slice.start - chr, adjective.unwrap());
		}
		if token != Token::Line && token != Token::Indent && !resized {
			if depth == 0 {
				act.clear()
			}
			// erase act[depth]+1
			resize(&mut act, depth);
			resize(&mut act, depth + 1);
			resized = true;
		}
		match token {
			Token::Line => {
				// toggle for resizing (clearing) to happen only after indents
				chr = slice.start;
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
				let (verbs, adverbs) = runner::squash(&mut act);
				if let Err(err) = runner::run(
					&Noun {
						noun: noun,
						adj: adjective,
					},
					&verbs,
					&adverbs,
					// &mut config,
				) {
					raise(err, lines, slice.start - chr, &source[slice]);
				}
				adjective = None;
			}
			Token::Adjective(adj) => adjective = Some(adj),
			Token::Shell(shell) => {
				act[depth].verbs.push("shell");
				println!("{} {:p}", act[depth].verbs[0], act[depth].verbs[0]);
				let (verbs, adverbs) = runner::squash(&act);
				println!("{} {:p}", act[depth].verbs[0], act[depth].verbs[0]);
				println!("{} {:p}", verbs[0], verbs[0]);
				println!("{:p}", &source);
				config.elevate = Some(verbs[0]);
				if let Err(err) = runner::run(
					&Noun {
						noun: shell,
						adj: adjective,
					},
					&verbs,
					&adverbs,
					// &mut config,
				) {
					raise(err, lines, slice.start - chr, &source[slice]);
				}
			}
		}
	}
}
