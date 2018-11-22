# vim-tmux-configs

## Steps

### 1 Create vimrc file
```cd $HOME ```

``` vim .vimrc```

### 2: Install Vundle
```git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim```

### 3: Install Plugins:
Launch vim and run ```:PluginInstall```

To install from command line: ```vim +PluginInstall +qall```

### If YCMD server has issues
```sudo apt-get install build-essential cmake```
Note: On older systems (e.g. Ubuntu 14.04) you may run into compilation issues with cmake. Therefore, install the following instead:
```sudo apt-get install build-essential cmake3```

Make sure you have Python headers installed:
```sudo apt-get install python-dev python3-dev```
```
Compiling YCM with semantic support for C-family languages:
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer
Compiling YCM without semantic support for C-family languages:
cd ~/.vim/bundle/YouCompleteMe
./install.py
```
### 4: Install vim-autopep8
Follow the installation instructions [here](https://github.com/tell-k/vim-autopep8)

### 5: Install requirements
```
pip install flake8
pip install --upgrade autopep8 
git clone https://github.com/arl/tmux-gitbar.git ~/.tmux-gitbar
```

### 6: To fix difference in color in tmux vim and normal vim (Ubuntu)
These are already in the dotfiles

In .tmux.conf:
```
set -g default-terminal "screen-256color"
```
And in .vimrc:
```
set background=dark
```

### 7: Swapping \<Esc\> with \<Caps\>
```
sudo apt-get install gnome-tweak-tool
```
