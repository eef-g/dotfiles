# My Dotfiles
This is a collection of my dotfiles for my linux systems. With a fully fledged install script that will allow for installing all of the dependencies that are needed in my dotfiles.

Please note that if you run the install script, it will overwrite any existing configurations that you have on your system, so do not forget to take backups of any CLI tools or other file-based configurations on your system!

____

# Showcase
* An example of my laptop
![An example of my laptop](./resc/README/desktop.png)

* An example of the terminal
![An example of my terminal](./resc/README/termnial_example.gif)
* Another terminal example
![An example of my tmux workflow](./resc/README/tmux_example.gif)
____

# Installation
To install my dotfile setup:

1. First, clone the git repository
```bash
git clone https://www.github.com/eef-g/dotfiles.git ~/dotfiles
```

2. Next, navigate into the Installation
```bash
cd ~/dotfiles
```

3. Run the installation script to install and setup the dotfiles
```bash
bin/install.sh
```

4. The dotfiles should now be installed, but some plugins may need to be loaded, such as for tmux. 

5. Any time you make changes to the dotfiles and need to resync them, run the following command in a zsh session:
```bash
syncdots
```

