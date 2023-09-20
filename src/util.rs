use colored::Colorize;

pub fn print(noun: &crate::Noun, verbs: &Vec<&str>, adverbs: &crate::Adverbs) {
	let mut out = String::new();

	out = format!("{}", verbs.join(" & ").red());
	out = format!("{} {}", out, noun.noun.green());
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
