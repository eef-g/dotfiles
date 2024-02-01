<h1 align="center"> <img src="https://imgs.search.brave.com/FBoXoc3z1QYFD0Tx-q_Mt0m7RIO3IGGQvQVxJmTgwfg/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pY29u/LmljZXBhbmVsLmlv/L1RlY2hub2xvZ3kv/c3ZnL05peE9TLnN2/Zw.svg" alt="NixOS_Logo" width="40" height="40"/> Eef's NixOS Configuration Files <img src="https://imgs.search.brave.com/FBoXoc3z1QYFD0Tx-q_Mt0m7RIO3IGGQvQVxJmTgwfg/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pY29u/LmljZXBhbmVsLmlv/L1RlY2hub2xvZ3kv/c3ZnL05peE9TLnN2/Zw.svg" alt="NixOS_Logo" width="40" height="40"/> </h1>
<p align="center">This is a repo for me to store and update my NixOS configurations. Feel free to reuse them or simply copy-paste them into your own NixOS installation</p>

<br> <br> <br>
<h2 align="center"> <img src="https://imgs.search.brave.com/FBoXoc3z1QYFD0Tx-q_Mt0m7RIO3IGGQvQVxJmTgwfg/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pY29u/LmljZXBhbmVsLmlv/L1RlY2hub2xvZ3kv/c3ZnL05peE9TLnN2/Zw.svg" alt="NixOS_Logo" width="20" height="20"/> Building <img src="https://imgs.search.brave.com/FBoXoc3z1QYFD0Tx-q_Mt0m7RIO3IGGQvQVxJmTgwfg/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pY29u/LmljZXBhbmVsLmlv/L1RlY2hub2xvZ3kv/c3ZnL05peE9TLnN2/Zw.svg" alt="NixOS_Logo" width="20" height="20"/> </h2>

1. Install NixOS on a machine (if using NixOS on WSL, follow the instructions [here](https://github.com/nix-community/NixOS-WSL))
2. Clone this repository into a folder. Below is the command I usually use for this step:
```bash
git clone https://github.com/eef-g/nix-dots.git ~/nix
``` 
3. Enable the build script within the new directory if you want to have an easy time building the NixOS images
```bash
sudo chmod +x ~/nix/build.sh
```
4. Run the help command on the build script
```bash
./build.sh -h
```
5. To use one of my configurations, run one of the following commands. These are based off of <u><b>my</b></u> hardware, so you may experience issues if you do this (__make sure you are within the ~/nix directory to run the following commands__):
```bash
sudo ./build.sh <CONFIG_LISTED_FROM_HELP_COMMAND>
```
6. If you want to use one of your configurations after creating one, run the following command:
```bash
sudo ./build.sh <NAME_OF_YOUR_CONFIG>
```

<br> <br> <br>
<h2 align="center"> <img src="https://imgs.search.brave.com/FBoXoc3z1QYFD0Tx-q_Mt0m7RIO3IGGQvQVxJmTgwfg/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pY29u/LmljZXBhbmVsLmlv/L1RlY2hub2xvZ3kv/c3ZnL05peE9TLnN2/Zw.svg" alt="NixOS_Logo" width="20" height="20"/> Customization <img src="https://imgs.search.brave.com/FBoXoc3z1QYFD0Tx-q_Mt0m7RIO3IGGQvQVxJmTgwfg/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pY29u/LmljZXBhbmVsLmlv/L1RlY2hub2xvZ3kv/c3ZnL05peE9TLnN2/Zw.svg" alt="NixOS_Logo" width="20" height="20"/> </h2>

- __How can I make my own configurations?__
  - To create your own configuration, create a new folder in the hosts/ directory and include the pre-existing configuration.nix and hardware-configuration.nix files from your system (as long as it is not a multi-fle configuration). Afterwards, add the configuration to the flake.nix file with the following structure (replace any 'config_name' with the name of your configuration):
```nix
config_name = nixpkgs.lib.nixosSystem {
  specialArgs = {inherit inputs;};
  modules = [
    ./hosts/config_name/configuration.nix
    ./hosts/config_name/hardware_configuration.nix
  ];
};
```
-   __How do I add or remove modules to configurations?__
  - To add and remove modules from the repository to the configuration, there are two different ways to do so.
```nix
# Adding specific .nix file from modules/ directory
config_name = nixpkgs.lib.nixosSystem {
  specialArgs = {inherit inputs;};
  modules = [
    ./hosts/config_name/configuration.nix
    ./hosts/config_name/hardware_configuration.nix
    # Add specific .nix files here. For example, this is how to add only the neofetch module:
    ./modules/home-manager/cli-tools/neofetch.nix
  ];
};
```
```nix
# Adding pre-organized module collections
config_name = nixpkgs.lib.nixosSystem {
  specialArgs = {inherit inputs;};
  modules = [
    ./hosts/config_name/configuration.nix
    ./hosts/config_name/hardware_configuration.nix
  ]
  # Add specific oranized modules with this syntax:
  # ++ builtins.attrValues modlues.<name_of_module>;

  # For multiple collections, use this format:
  # ++builtins.attrValues modueles.<name_of_module_1>
  # ++builtins.attrValues modueles.<name_of_module_2>;

  # Example: adding cli-tools collection
  ++ builtins.attrValues modules.cli-tools;
  # ^^ Make sure the semi-colon ending the modules variable is only placed AFTER all of the module collections are added
};
```
- __How can I create my own modules?__
  - To create your own modules, you can create either a new directory or a new .nix file in the modules/ directory. The way that the modules are currently organized is as follows:
    - modules > type_of_module > module_collection > individual_module_nix_files
  - Once your modules are created, you can include them from the instructions above.
  - To add your own module collections to the flake, edit the outputs.modules variable by adding the following line within the modules = {} section of the program:
```nix
# Replace the variable name and the string variables to include the name of your collection and the path to the directory of your collection
collection_name = builtins.mapAttrs (name: path: "$self}/path_to_module_collection_dir/${name}") (builtins.redDir "${self}/path_to_module_collection_dir");
```

<br> <br> <br>
<img src="https://avatars.githubusercontent.com/u/74423016?v=4" alt="Eef GitHub Icon" height="40" width="40">
> "That's all. Enjoy the configuration and the modular customization of my NixOS setup!"
>  -Eef
