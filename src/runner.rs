use crate::Adverbs;

 pub fn squash<'a>(actions: &'a Vec<crate::Verbs<'a>>) -> (Vec<&'a str>, Adverbs<'a>) {
	let mut adverbs = Adverbs {
		path: None,
		branch: None,
		arg: None
	};

	let mut defer = 0;
	let mut verbs: Vec<&str> = Vec::new();

	for act in actions {
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

pub fn run(noun: &crate::Noun, verbs: &Vec<&str>, adverbs: &Adverbs) {
	println!("noun: {:?}\nverbs: {:?}\nadverbs: {:?}\n", noun, verbs, adverbs);
}