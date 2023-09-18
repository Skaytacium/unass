use std::error::Error;
use std::{fmt, println};

pub enum SeverityLevel {
	Warning,
	Fatal,
}

pub trait Severity {
	fn severity(&self) -> SeverityLevel;
}

// currently a seperation for lexer/runner/execution error enums isn't needed
#[derive(Debug)]
pub enum ErrorKind {
	Token,
	InvalidKey,
	AdjectiveWithoutNoun,
}

impl fmt::Display for ErrorKind {
	fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
		match self {
			ErrorKind::Token => f.write_str("unrecognized token"),
			ErrorKind::AdjectiveWithoutNoun => f.write_str("no noun to describe"),
			ErrorKind::InvalidKey => f.write_str("invalid key"),
		}
	}
}
impl Severity for ErrorKind {
	fn severity(&self) -> SeverityLevel {
		SeverityLevel::Fatal
	}
}
impl Severity for std::io::Error {
	fn severity(&self) -> SeverityLevel {
		SeverityLevel::Fatal
	}
}
impl Error for ErrorKind {}

// exit by yourself if the error is fatal, since handling this here would cause
// a !|() return type, which isn't possible
pub fn add_error(error: (impl Error + Severity), at: &str, line: usize) {
	match error.severity() {
		SeverityLevel::Fatal => {
			println!("\x1B[1;31mfatal ({}) `{}`: {}\x1B[0m", line, at, error);
		}
		SeverityLevel::Warning => {
			println!("\x1B[1;33mwarn ({}) `{}`: {}\x1B[0m", line, at, error);
		}
	}
}
