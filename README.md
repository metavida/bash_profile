# metavida ~/.bash_profile

A quick repo to store my bash customizations.

# Usage

1. Check out this repo.
```
$ git clone git@github.com:metavida/bash_profile.git ~/.bash_scripts
```
2. Symlink bash_profile and gitconfig into place.
```
$ ln -nfs ~/.bash_scripts/bash_profile ~/.bash_profile
$ ln -nfs ~/.bash_scripts/gitconfig ~/.gitconfig
```
3. Create a `keys.sh` file and add any secrets there.
```
$ touch ~/.bash_scripts/keys.sh && chmod 600 ~/.bash_scripts/keys.sh
```
4. Enjoy!
