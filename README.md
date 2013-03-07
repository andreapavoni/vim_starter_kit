Vim starter kit (yet another one)
==========================

This configuration started as a Janus fork where I put my own configs, plugins
and shortcuts. But I was quite unhappy with the way the plugins were managed, so
I re-started from [Mislav](https://github.com/mislav/vimfiles)'s leaner config, then I've added my own customizations, ending to a completely different result.

It uses [vundle](https://github.com/gmarik/vundle) instead of [Pathogen](https://github.com/tpope/vim-pathogen), gitmodules are handy, but I prefer the vundle's approach: manage plugins by editing a file, instead of tracking external repos.

Some credits are necessary, I learned/stolen a lot from their code/configs/tips:

* [Tim Pope](http://tbaggery.com),
* [Janus project](https://github.com/carlhuda/janus).
* [Mislav] (mislav.uniqpath.com/2011/12/vim-revisited)
* [Jeff Kreeftmeijer] (http://jeffkreeftmeijer.com)
* [Vimcasts] (http://vimcasts.org/)


## Installation:

Prerequisites: ruby, git.

1. Move your existing configuration somewhere else:
   `mkdir ~/my_backup && mv ~/.vim* ~/.gvim* my_backup`
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
   * FuzzyFinder
   * git
   * fugitive
   * nerdtree
   * powerline
   * tabular (aka Tabularize)
   * vim-gutter (shows git diff in the gutter)
   * EasyGrep

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
   * cucumber + patch to align tables (see [here](https://gist.github.com/287147))
   * haml
   * scss
   * rspec
   * html5

* Themes
   * solarized
   * vividchalk
   * vsk_dark (generated with http://themes.sweyla.com)
   * Tomorrow Night Bright (see [Tomorrow Theme] (https://github.com/chriskempson/tomorrow-theme))
   * jellybeans

