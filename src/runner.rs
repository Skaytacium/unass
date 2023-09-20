use crate::{errors::{Error, raise}, util, Adverbs};

pub fn squash<'a>(actions: &'a Vec<crate::Verbs<'a>>) -> (Vec<&'a str>, Adverbs<'a>) {
	let mut adverbs = Adverbs {
		path: None,
		branch: None,
		arg: None,
	};

	let mut defer = 0;
	let mut verbs: Vec<&str> = Vec::new();

	for act in actions {
		// someone tell me a better way to do this man
		if let Some(path) = act.adverb.path {
			adverbs.path = Some(path);
		}
		if let Some(branch) = act.adverb.branch {
			adverbs.branch = Some(branch);
		}
		if let Some(arg) = act.adverb.arg {
			adverbs.arg = Some(arg);
		}

		for (i, verb) in act.verbs.iter().enumerate() {
			if i < act.defer {
				verbs.insert(defer, verb);
			} else {
				verbs.insert(defer, verb);
				defer += 1;
			}
		}
	}

	(verbs, adverbs)
}

pub fn run(noun: &crate::Noun, verbs: &Vec<&str>, adverbs: &Adverbs) -> Result<(), Error> {
	if verbs.len() < 1 {
		return Err(Error::Verbs);
	}

	if verbs.len() == 1 {
		match verbs[0] {
			"set" => {
				match noun.noun {
					"elevate" => {},
					"store" => {},
				 	_ => return Err(Error::Key),
				}
			},
			"shell" => {},
			_ => (),
		}
	}

	util::print(noun, verbs, adverbs);
	Ok(())
}
