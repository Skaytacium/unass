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

### Installation?
You need a **git** repository, with *specific* branches for each system you have and a *main* (names can be whatever) branch that has the files that you want on every system.

Run this in your root configuration directory in each *specific* branch:  
```sh
git submodule add --force "https://github.com/Skaytacium/unass"; cd unass; cp unass.sh ..; git checkout installed; 
```

### Usage?
Start editing `unass.sh` with your specific installation instructions. All your changes should be after (after the `### User section`).

You can `run` different *verbs* which have some basic default options:
- `apply`: Apply files from your repository to your filesystem, giving more priority to *specific* branches.
- `build`/`compile`: Build a repository, defaults to just `make`.
- `clone`: Clone or update a respository.
- `download`: Download a link.
- `extract`: Extract a downloaded archive.
- `install`: Install a program, from source or whatever.
- `sync`: Sync files from your filesystem to your repository, with user merging same files on `main` and `specific` branches.
- `service`: Enables a service, [runit](http://smarden.org/runit/) services by default.

You can give each *verb* a different action with its name and it will automatically perform that when you `run` it. Check the default *verbs* for what parameters to use with them.

Prefixing the *verb* with space-delimited parameters will pass it as a prefix to the verb, but pass it in the same argument, for eg:  
```sh
run build dwm
run "sudo install" "dwm"
```
will run the build script for `dwm` normally and the install script as `sudo install/dwm.sh`.

Not explaining the rest, check [my configuration](https://github.com/Skaytacium/.files).

### Updating?
```sh

```

### And?
This entire project hurt my bones to make.

Contribute any *verbs* if you want, I added one for compiling [jellyfin](https://jellyfin.org/).  
Or don't, I'll do it myself as always.
