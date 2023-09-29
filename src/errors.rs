use std::{error::Error as StdError, process::exit};
use colored::Colorize;
use std::{fmt, println};

pub enum Severity {
	Warning,
	Fatal,
}

pub trait SeverityLevel {
	fn severity(&self) -> Severity;
}

// currently a seperation for lexer/runner/execution error enums isn't needed
#[derive(Debug)]
pub enum Error {
	Token,
	Key,
	Adjective,
	Verbs,
	Argument,
	Path,
	Exists,
}

impl fmt::Display for Error {
	fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
		match self {
			Error::Token => f.write_str("unrecognized token"),
			Error::Adjective => f.write_str("adjective dropped"),
			Error::Key => f.write_str("invalid key"),
			Error::Verbs => f.write_str("no verbs found"),
			Error::Argument => f.write_str("an argument is mandatory"),
			Error::Path => f.write_str("path is mandatory"),
			Error::Exists => f.write_str("path doesn't exist"),
		}
	}
}
impl SeverityLevel for Error {
	fn severity(&self) -> Severity {
		match self {
			Error::Adjective => Severity::Warning,
			_ => Severity::Fatal,
		}
	}
}
impl SeverityLevel for std::io::Error {
	fn severity(&self) -> Severity {
		Severity::Fatal
	}
}
impl StdError for Error {}

// will shift to Result<(), !> when ! gets standardized, for now pray your error isn't fatal
pub fn raise(error: (impl StdError + SeverityLevel), line: usize, chr: usize, word: &str) /* -> Result<(), !> */ {
	match error.severity() {
		Severity::Fatal => {
			println!("{}", format!("fatal:{}:{}:\"{}\":{}", line, chr, word, error).on_red().bold().black());
			exit(1)
		}
		Severity::Warning => {
			println!("{}", format!("warn:{}:{}:\"{}\":{}", line, chr, word, error).on_yellow().bold().black());
		}
	}
}
