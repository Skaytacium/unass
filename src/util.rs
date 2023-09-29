use colored::Colorize;

pub fn print(noun: &crate::Noun, verbs: &Vec<&str>, adverbs: &crate::Adverbs) {
	let mut out = format!("{} {}", verbs.join(" & ").red(), noun.noun.green());
	// someone tell me a better way to do this man 2
	if let Some(adj) = noun.adj {
		out = format!("{} {} {}", out, "as".italic().bold(), adj.blue());
	}
	if let Some(path) = adverbs.path {
		out = format!("{} {} {}", out, "in".italic().bold(), path.blue());
	}
	if let Some(branch) = adverbs.branch {
		out = format!("{} {} {}", out, "on".italic().bold(), branch.blue());
	}
	if let Some(arg) = adverbs.arg {
		out = format!("{} {} {}", out, "with".italic().bold(), arg.blue());
	}

	println!("{}", out);
}
