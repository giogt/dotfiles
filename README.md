# dotfiles

My config files divided in packages, that can be installed using [GNU stow](https://www.gnu.org/software/stow/).

## How to install

Clone this repo under `~/.dotfiles`:

```sh
git clone https://github.com/giogt/dotfiles.git ~/.dotfiles
```

You can close it under a different directory, if you prefer, but `.dotfiles` is a good choice.
I normally keep my GitHub projects in a different directory, and then symlink this one to `~/.dotfiles`.

Install `stow`:

```sh
brew install stow
```

You can then `cd ~`, and install the config for each of the included packages as follows:
```sh
stow -d .dotfiles ${package_name}
```

where `${package_name}` is one of the project top-level directories (e.g., `nvim`, `zsh`).
I'm not sure why, but when I tried `stow -d ~/.dotfiles ${package_name}`, I didn't get
auto-completion for package names, that's why I suggest to `cd ~` first.

If you get an error saying that the target files and/or directories already exist, remove them
first. You should consider making a backup of the current config before deleting it.

## Brewfile for Homebrew bundle

Homebrew provides a `bundle` command to dump all the installed packages to a `Brewfile`, so that
they can be synced at any time on any machine that has access to the file.
See [this web page](https://docs.brew.sh/Brew-Bundle-and-Brewfile) for details.

I am using `brew bundle -g` (or `--global`), which expects the `Brewfile` to be located at
`~/.Brewfile`.

To use the `Brewfile` in this repo:

```sh
rm ~/.Brewfile
ln -s ~/.cli-config/.Brewfile ~
```

**IMPORTANT**: before installing the packages, review the content of `.Brewfile`.
There are some bugs causing the bundle functionality to dump to the file additional package
types that were not installed via Homebrew, such as `vscode` and `cargo`.
Please consider keeping only packages of type `brew` and `cask`, and remove all the others.

You can then install the packages in the Bundlefile by running:

```sh
brew bundle -g
```
