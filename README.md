# unass
## ugh, not another system syncer
### What?
`unass` **is a framework, it is not a program**. It is meant to be kept alongside your store and run every time you reinstall or want to update your store. It was meant to be:

- Insanely modular, like, it reached a point where the script was blank.
- Scriptable enough to change literally everything. Literally.
- Easy enough to use so that I won't have to hurt myself everytime I use it.
- Set and forget, I don't ever want to see this mess again.
- Should be easy to store anywhere I want to.

Its hell on Earth.  

### Installation?
You need to make a [store](#Glossary?). Run this in your store in each [specific branch](#Glossary?):  
```sh
curl -L https://raw.githubusercontent.com/Skaytacium/unass/master/install.sh | /bin/sh
```
Update it the same way.

### Usage?
You can `run` different [verbs](#Glossary?) which have some basic default options:
- `apply`: Apply files from your repository to your filesystem, giving more priority to *specific* branches.
- `build`/`compile`: Build a repository, defaults to just `make`.
- `clone`: Clone or update a respository.
- `download`: Download a link.
- `extract`: Extract a downloaded archive.
- `install`: Install a program, from source or whatever.
- `sync`: Sync files from your filesystem to your repository, with user merging same files on `main` and `specific` branches.
- `service`: Enables a service, [runit](http://smarden.org/runit/) services by default.

Check the scripts for the default verbs to see what they do and parameters they need.

Not explaining the rest, check [my configuration](https://github.com/Skaytacium/.files) and figure it out from the examples.

### Examples?
Assume `alias run="$HOME/.files/unass/run.sh"` for all examples.

- Build `dwm`
```sh
# Tries to run `verbs/build/dwm.sh`, if its not available then it runs `verbs/build/default.sh dwm`
run build dwm
```
- Build and install `dwm` (in order)
```sh
run "build install" dwm
```
- Download, extract and install `jellyfin`, `dotnet`, and `lua-lsp`
```sh
run "download extract install" "jellyfin dotnet lua-lsp"
```

**The specific verbs are not defined, you need to make them yourself to your own liking, thats the entire point.**

### Why?
Sorry.  
- [yadm](https://yadm.io/) and [stow](https://www.gnu.org/software/stow/) weren't fitting my needs and my custom bootstrap script was getting too clustered.
- What does it even do? nothing really... but the default verbs are useful and its supposed to be modular I guess I don't know I'm lazy.

### Glossary?
- store: A git repository with a main branch and specific branches. Organized like the linux tree, check [my configuration](https://github.com/Skaytacium/.files).
- main branch: Universal main branch containing universal files (`~/.tmux.conf`, `.config/nvim`, `.config/kitty`).
- specb: Machine specific branch for each machine containing files specific to that machine (`/etc/X11/xorg.conf`, `~/.Xresources`, `/etc/udev/rules.d`)..
- verbs: folders with a default script for some action (compiling, extracting or downloading) and specific scripts for each item (specific script called `dwm.sh` in the `build` verb folder to build `dwm`).
