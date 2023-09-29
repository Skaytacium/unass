use std::path::PathBuf;

use crate::{errors::Error, util, Adverbs, Config};

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
			verbs.insert(defer, verb);
			if i >= act.defer {
				defer += 1;
			}
		}
	}

	(verbs, adverbs)
}

pub fn run<'a>(noun: &crate::Noun, verbs: &Vec<&'a str>, adverbs: &Adverbs<'a>, /* config: &mut Config<'a> */) -> Result<(), Error> {
	if verbs.len() < 1 {
		return Err(Error::Verbs);
	}

	if verbs.len() == 1 {
		match verbs[0] {
			"set" => {
				match noun.noun {
					"elevate" => {
						if let Some(arg) = adverbs.arg {
							// config.elevate = arg;
						} else {
							return Err(Error::Argument);
						}
					},
					"store" => {
						if let Some(path) = adverbs.path {
							// config.store = PathBuf::from(path);
							// if config.store.try_exists().expect("error checking path") {
							// 	return Err(Error::Exists)
							// }
						} else {
							return Err(Error::Path);
						}
					},
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
