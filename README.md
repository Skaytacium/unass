# unass
## ugh, not another system syncer
### Why?
Sorry.  
[yadm](https://yadm.io/) and [stow](https://www.gnu.org/software/stow/) weren't fitting my needs and my custom bootstrap script was getting too clustered.

### What?
`unass` **is a framework, it is not a program**. It is meant to be kept alongside your dotfiles and run every time you reinstall or want to update your system configuration. It was meant to be:

- Insanely modular, like, it reached a point where the script was blank.
- Scriptable enough to change literally everything. Literally.
- Easy enough to use so that I won't have to hurt myself everytime I use it.

### How?
Hell on Earth.  
It uses a bunch of shell scripts and standards. Don't ask for more.

### Don't care didn't ask, how do I use it?
You need a **git** repository, with `specific` branches for each system you have and a `main` (names can be whatever, keep track of it yourself) branch that has the files that you want on every system. You can differ files, but you'll have to keep track of that in your repository and script.

Run this in your root configuration directory:  
```sh
git clone "https://github.com/Skaytacium/unass"
cd unass
rm -rf .git .gitignore LICENSE README.md
```
Start editing `unass.sh` with your specific installation instructions.

You can `run` different `verb`s which have some basic default options:
- `apply`: Apply files from your repository to your filesystem, giving more priority to `specific` branches.
- `build`/`compile`: Build a repository, defaults to just `make`.
- `clone`: Clone or update a respository.
- `download`: Download a link.
- `extract`: Extract a downloaded archive.
- `install`: Install a program, from source or whatever.
- `sync`: Sync files from your filesystem to your repository, with user merging same files on `main` and `specific` branches.

You can give each `verb` a different action with its name and it will automatically perform that when you `run` it. Check the default `verb`s for what parameters to use with them.

Not explaining the rest, check [my configuration](https://github.com/Skaytacium/.files).

### And?
This entire project hurt my bones to make.

Contribute any `compile` verbs if you want, I added one for [jellyfin](https://jellyfin.org/). Or don't, I'll do it myself as always.
