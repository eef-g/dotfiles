<h1 align="center"> <img src="https://imgs.search.brave.com/FBoXoc3z1QYFD0Tx-q_Mt0m7RIO3IGGQvQVxJmTgwfg/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pY29u/LmljZXBhbmVsLmlv/L1RlY2hub2xvZ3kv/c3ZnL05peE9TLnN2/Zw.svg" alt="NixOS_Logo" width="40" height="40"/> Eef's NixOS Configuration Files <img src="https://imgs.search.brave.com/FBoXoc3z1QYFD0Tx-q_Mt0m7RIO3IGGQvQVxJmTgwfg/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pY29u/LmljZXBhbmVsLmlv/L1RlY2hub2xvZ3kv/c3ZnL05peE9TLnN2/Zw.svg" alt="NixOS_Logo" width="40" height="40"/> </h1>
<p align="center">This is a repo for me to store and update my NixOS configurations. Feel free to reuse and edit/customize them or simply copy-paste them into your own NixOS installation</p>

<br> <br> <br>
<h2 align="center"> <img src="https://imgs.search.brave.com/FBoXoc3z1QYFD0Tx-q_Mt0m7RIO3IGGQvQVxJmTgwfg/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pY29u/LmljZXBhbmVsLmlv/L1RlY2hub2xvZ3kv/c3ZnL05peE9TLnN2/Zw.svg" alt="NixOS_Logo" width="20" height="20"/> Building <img src="https://imgs.search.brave.com/FBoXoc3z1QYFD0Tx-q_Mt0m7RIO3IGGQvQVxJmTgwfg/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pY29u/LmljZXBhbmVsLmlv/L1RlY2hub2xvZ3kv/c3ZnL05peE9TLnN2/Zw.svg" alt="NixOS_Logo" width="20" height="20"/> </h2>

1. Install NixOS on a machine 
2. If you do not have the git package installed, run the following command:
```bash
nix-shell -p git
```
3. Clone this repository into a folder (__NOTE: If you want to avoid issues with git and NixOS, make a fork of this repository and clone the fork instead of the original__). Below is the command I usually use for this step:
```bash
git clone https://github.com/eef-g/nix-dots.git ~/nix
```
4. Run the help command on the build script
```bash
./rebuild.sh -h
```
5. To use the installation script, run the following command _as sudo_. The installation script will prompt you questions about preferences.
(**To use default customization, press enter to decline any customization and use the defaults. The default customization files are for my system**)
```bash
sudo ./rebuild.sh -i
```
6. Reboot and log in. 

**IF YOU HAVE NOT ALREADY SET A PASSWORD FOR YOUR USER, THE DEFAULT PASSWORD IS THE USERNAME**
<br> <br> <br>
<h2 align="center"> <img src="https://imgs.search.brave.com/FBoXoc3z1QYFD0Tx-q_Mt0m7RIO3IGGQvQVxJmTgwfg/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pY29u/LmljZXBhbmVsLmlv/L1RlY2hub2xvZ3kv/c3ZnL05peE9TLnN2/Zw.svg" alt="NixOS_Logo" width="20" height="20"/> Customization <img src="https://imgs.search.brave.com/FBoXoc3z1QYFD0Tx-q_Mt0m7RIO3IGGQvQVxJmTgwfg/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pY29u/LmljZXBhbmVsLmlv/L1RlY2hub2xvZ3kv/c3ZnL05peE9TLnN2/Zw.svg" alt="NixOS_Logo" width="20" height="20"/> </h2>

* This will be filled in later once I figure out the entire workflow to cover most FAQs about customization :)
<br> <br> <br>
<h2 align="center"> <img src="https://imgs.search.brave.com/FBoXoc3z1QYFD0Tx-q_Mt0m7RIO3IGGQvQVxJmTgwfg/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pY29u/LmljZXBhbmVsLmlv/L1RlY2hub2xvZ3kv/c3ZnL05peE9TLnN2/Zw.svg" alt="NixOS_Logo" width="20" height="20"/> Huge Thanks <img src="https://imgs.search.brave.com/FBoXoc3z1QYFD0Tx-q_Mt0m7RIO3IGGQvQVxJmTgwfg/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pY29u/LmljZXBhbmVsLmlv/L1RlY2hub2xvZ3kv/c3ZnL05peE9TLnN2/Zw.svg" alt="NixOS_Logo" width="20" height="20"/> </h2>

* A huge thank you to [Aylur](https://github.com/Aylur) for creating the widgets found in the ags/ directory as well as the initial inspiration post on [reddit](https://www.reddit.com/r/unixporn/comments/1avnfjn/hyprland_animations_theme_generation_settings/). The post inspired me to redo my NixOS configuration similar to his. Please go show them some suport and star the [original repo](https://github.com/Aylur/dotfiles?tab=readme-ov-file) if you enjoy my dotfiles!
<br> <br> <br>
<img src="https://avatars.githubusercontent.com/u/74423016?v=4" alt="Eef GitHub Icon" height="40" width="40">

> "That's all. Enjoy the configuration and the modular customization of my NixOS setup!"
>  -Eef
