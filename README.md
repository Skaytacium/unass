# unass (archived)
## ugh, not another system syncer
### wait, archived? again?
sometimes you should just [cut your losses](https://github.com/void-linux/void-packages/blob/master/Manual.md#Introduction)

### what?
another system syncer, script based

### why?
I felt like tools like [chezmoi](https://www.chezmoi.io/), although very powerful, do not offer what I feel is true system synchronization. [Puppet](https://www.ansible.com/) and [Ansible](https://www.ansible.com/) are way too overkill and offer way more than necessary, plus their target is more focused on computing clusters

also it's 2023 and you're telling me I can't install web programs or manage more than just my dotfiles?[^1]

and I'm like shit and love reinveting stuff

[^1]: [chezmoi](https://www.chezmoi.io) has the capacity to do that, but it is [strongly discouraged](https://www.chezmoi.io/user-guide/frequently-asked-questions/design/#can-i-use-chezmoi-to-manage-files-outside-my-home-directory).

### wait, lua? and dash??
um

### how?
check out [the docs](doc/) and [my script as an example](unass).

### and?
this project uses the fantastic [Logos](https://github.com/maciejhirsz/logos) for lexing since I don't want to make a lexer in rust