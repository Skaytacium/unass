use crate::parser::{Tree, Adverbs};

pub struct RunList<'a> {
	adverbs: Adverbs<'a>,
	verbs: Vec<&'a str>,
	adjective: Option<&'a str>,
	noun: &'a str,
}

pub struct Generator<'a> {
	tree: Tree<'a>,
	runlist: RunList<'a>
}

impl<'a> Generator<'a> {
	pub fn new() -> Generator<'a> {
		Generator {
			tree: Tree {
				adverbs: Adverbs { args: None, path: None, branch: None },
				verbs: Vec::new(),
				defer_at: 0,
				nouns: Vec::new(),
			},
			runlist: RunList { adverbs: , verbs: (), adjective: (), noun: () }
		}
	}

	pub fn add() -> {

	}
}