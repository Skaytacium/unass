use crate::lexer::Token;
use crate::errors::{add_error, ParserError, Error};

#[derive(Debug, Clone)]
pub struct Adverbs<'a> {
	pub path: Option<&'a str>,
	pub branch: Option<&'a str>,
	pub args: Option<&'a str>,
}

#[derive(Debug, Clone)]
pub struct Tree<'a> {
	pub adverbs: Adverbs<'a>,
	pub verbs: Vec<&'a str>,
	pub defer_at: usize,
	pub nouns: Vec<(&'a str, Option<&'a str>)>,
}

pub struct Parser<'a> {
	depth: usize, // If you need more than 255 indents  this should panic, this is by design
	prev_depth: usize,
	trees: Vec<Tree<'a>>,
	last_token: Token<'a>,
}

impl<'a> Parser<'a> {
	pub fn new() -> Parser<'a> {
		Parser {
			depth: 0,
			prev_depth: 0,
			trees: Vec::new(),
			last_token: Token::Line,
		}
	}

	pub fn add(&mut self, token: Token<'a>) -> Option<&Vec<Tree<'a>>> {
		match token {
			Token::Indent => self.depth += 1,
			Token::Line => {
				if self.last_token == Token::Line {
					self.trees.truncate(0);
				} else {
					self.prev_depth = self.depth;
					self.depth = 0;
				}
				if self.trees.len() > 0 {
					self.last_token = token;
					return Some(&self.trees);
				}
			}
			_ => self.handle(&token),
		}

		self.last_token = token;
		None
	}

	fn post_indent(&mut self) {
		if self.prev_depth >= self.depth {
			self.trees.truncate(self.depth);
		}
		if self.trees.len() < self.depth + 1 {
			self.trees.resize(
				self.depth + 1,
				Tree {
					adverbs: Adverbs {
						path: None,
						branch: None,
						args: None,
					},
					verbs: Vec::new(),
					defer_at: 0,
					nouns: Vec::new(),
				},
			)
		}
	}

	fn handle(&mut self, token: &Token<'a>) {
		if self.last_token == Token::Indent || self.last_token == Token::Line {
			self.post_indent()
		}

		let mut depth_tree = &mut self.trees[self.depth];

		match token {
			Token::Path(path) => depth_tree.adverbs.path = Some(path),
			Token::Branch(branch) => depth_tree.adverbs.branch = Some(branch),
			Token::Argument(arguments) => depth_tree.adverbs.args = Some(arguments),
			Token::Defer(verb) => depth_tree.verbs.push(verb),
			Token::Noun(noun) => depth_tree.nouns.push((noun, None)),
			Token::Value(val) => {
				depth_tree.verbs.push("_set");
				depth_tree.nouns[0].1 = Some(val)
			}
			Token::Verb(verb) => {
				depth_tree.verbs.insert(depth_tree.defer_at, verb);
				depth_tree.defer_at += 1;
			}
			Token::Shell(cmd) => {
				depth_tree.verbs.insert(depth_tree.defer_at, "shell");
				depth_tree.defer_at += 1;
				depth_tree.nouns.push((cmd, None));
			}
			Token::Adjective(adjective) => {
				let nouns_length = depth_tree.nouns.len();
				if nouns_length < 1 {
					add_error(Error::Parser(ParserError::AdjectiveWithoutNoun(&adjective)))
				}
				depth_tree.nouns[nouns_length - 1].1 = Some(adjective);
			}
			_ => {}
		}
	}
}
