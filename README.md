# unass
## ugh, not another system syncer
### Why?
Sorry.  
[yadm](https://yadm.io/) and [stow](https://www.gnu.org/software/stow/) weren't fitting my needs and my custom bootstrap script was getting too clustered.

### What?
`unass` is more of a framework to start your system syncer, providing a bunch of helper scripts and hooks to simplify installation in new systems.  
The shell scripts are short and readable because I hate reading code as much as you do. I might also make a simple guide soon enough.

1. `sync`: sync files to your system.
2. `source`: compile programs from source.
3. `install`: download & install programs.
4. `service`: enable [runit](http://smarden.org/runit/) services.
5. `group`: add user to groups.
6. `maintain`: sync files from your sytem.
