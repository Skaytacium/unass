enum Severity {
	Warning,
	Fatal,
}

pub enum IOError {
	Script,
}
pub enum LexerError<'a> {
	Token(&'a str),
}
pub enum ParserError<'a> {
	InvalidKey,
	AdjectiveWithoutNoun(&'a str),
}

pub enum Error<'a> {
	Lexer(LexerError<'a>),
	IOError(IOError),
	Parser(ParserError<'a>),
}

pub fn add_error(error: Error) {
	match error {
		Error::Lexer(suberror) => match suberror {
			LexerError::Token(token) => handle_error(
				"lexer",
				format!("unrecognized token: {}", token),
				Severity::Fatal,
			),
		},
		Error::IOError(suberror) => match suberror {
			IOError::Script => handle_error(
				"io",
				"unass script not found".to_string(),
				Severity::Fatal,
			),
		},
		Error::Parser(suberror) => match suberror {
			ParserError::InvalidKey => handle_error(
				"parser",
				"invalid configuration key".to_string(),
				Severity::Fatal,
			),
			ParserError::AdjectiveWithoutNoun(adj) => handle_error(
				"parser",
				format!("adjective isn't describing any noun: {}", adj),
				Severity::Fatal,
			),
		},
	}
}

fn handle_error(scope: &str, message: String, severity: Severity) {
	match severity {
		Severity::Warning => println!("\x1B[1;33mwarning({}): {}\x1B[0m", scope, message),
		Severity::Fatal => {
			println!("\x1B[1;31mfatal({})@line: {}\x1B[0m", scope, message);
			std::process::exit(1);
		}
	}
}
