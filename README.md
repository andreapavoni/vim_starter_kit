My vim configuration
==========================

This configuration started as a Janus fork where I put my own configs, plugins
and shortcuts. But I was quite unhappy with the way the plugins were managed, so
I re-started from [Mislav](https://github.com/mislav/vimfiles)'s config, adding my own customizations.

It uses [vundle](https://github.com/gmarik/vundle) instead of [Pathogen](https://github.com/tpope/vim-pathogen), gitmodules are handy, but I prefer
the vundle approach.

Some credits are necessary, I learned/stolen a lot from their code/configs/tips:

* [Tim Pope](http://tbaggery.com),
* [Janus project](https://github.com/carlhuda/janus).
* [Mislav] (mislav.uniqpath.com/2011/12/vim-revisited)
* [Jeff Kreeftmeijer] (http://jeffkreeftmeijer.com)


## Installation:

Prerequisites: ruby, git.

1. Move your existing configuration somewhere else:
   `mv ~/.vim* ~/.gvim* my_backup`
2. Clone this repo into ".vim":
   `git clone https://github.com/apeacox/myvimfiles ~/.vim`
3. Go into ".vim" and run "rake":
   `cd ~/.vim && rake`

This will install "~/.vimrc" and "~/.gvimrc" symlinks that point to
files inside the ".vim" directory.

## Features:

* 2 spaces, no tabs
* incremental, case-insensitive search
* 'Leader' character mapped to "," (comma)
* `,t` opens file search via FuzzyFinder plugin (instead of Command-T)
* `<C-j/k/h/l>` switches between windows (no need to prepend `<C-w>`)
* cursor keys for movement disabled!
* `,n` open/closes NerdTree
* `F5` re-indent file
* `,cc` add comment to current (or selected) lines

I suggest to check vimrc to know the rest of shortcuts ;)

## Plugins:

I use the following plugins by default, you can edit the bundles in ```vimrc``` file to
add/remove them.

* Utils
   * ack
   * FuzzyFinder
   * git
   * fugitive
   * nerdtree
   * powerline

* Editing
   * nerdcommenter
   * ZooWin
   * surround
   * supertab
   * snipmate
   * matchit

* Syntaxes
   * markdown
   * ruby
   * rails
   * coffee-script
   * javascript
   * cucumber
   * haml
   * scss
   * rspec
   * html5

* Themes
   * solarized
   * vividchalk
   * mytheme (a custom name for theme generated with http://themes.sweyla.com)

