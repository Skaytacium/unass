use std::path::PathBuf;
use errors::{Error, IOError, LexerError};
use lexer::Token;
use logos::Logos;

mod errors;
mod lexer;
mod parser;
mod generator;

pub struct Config {
	elevate: Option<String>,
	store: Option<PathBuf>,
}

fn main() {
	let mut config = Config {
		elevate: None,
		store: None,
	};

	if let Ok(bytes) = std::fs::read("unass") {
		let source = String::from_utf8(bytes).expect("Invalid UTF8 encoding.");

		let token_stream = Token::lexer(&source);
		let mut parser = parser::Parser::new();
		let generator = generator::Generator::new();

		for (token, slice) in token_stream.spanned() {
			if token == Token::Error {
				errors::add_error(Error::Lexer(LexerError::Token(&source[slice])));
			}
			if let Some(trees) = parser.add(token) {
				generator.
			}
		}
		// Once EOF is reached, put a line in the parser so that it sends back the last line.
		parser.add(Token::Line);
	} else {
		errors::add_error(Error::IOError(IOError::Script));
	}
}
