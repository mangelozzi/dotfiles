# Dot (config) Files

- Runtime configuration files for my home directory.
- Bare repo to allow adding file directly in $HOME dir
- Use `dot` alias to refer to this config repo

## INSTALL SCRIPTS

- Refer to `install/` for scripts to install the various software.
- `install.sh` will run all the install scripts in order.
- `install_<APP>.sh` will install only that app.
- `install_lib.sh` is a lib for helping the installation scripts.

## CONFIGS

- [Bash](bash/README.md)
- [Git](git/README.md)
- [Neovim](nvim/README.md)

## INSTALL DOTFILES

```bash
curl https://raw.githubusercontent.com/mangelozzi/dotfiles/master/.config/install/_install_config.sh | bash
```
