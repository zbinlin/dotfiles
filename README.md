# dotfiles

## Prepare

Create user XDG directories

```sh
mkdir -p .{local/share/gnupg,config,cache}
```

## Profile ($HOME/.profile or $HOME/.zprofile)

### Requirements

* GnuPG
* sudo
* mount

### Source

```sh
[[ $HOME/.dotfiles/profile.sh ]] && . $HOME/.dotfiles/profile.sh
```


## Rc ($HOME/.bashrc or $HOME/.zshrc)


### Source

```sh
[[ $HOME/.dotfiles/rc.sh ]] && . $HOME/.dotfiles/rc.sh
```