Kilnyy's dotfiles
====

Prerequisites
----
```
wget https://github.com/vim/vim/archive/v8.1.0042.tar.gz
tar -zxf v8.1.0042.tar.gz
cd vim-8.1.0042/src
make
sudo make install

git clone https://github.com/universal-ctags/ctags.git
./autogen.sh
./configure
make
sudo make install

wget https://github.com/tmux/tmux/releases/download/2.7/tmux-2.7.tar.gz
tar -zxf tmux-2.7.tar.gz
cd tmux-2.7
./configure
make
sudo make install
```
