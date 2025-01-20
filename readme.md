# WSL Ubuntu

Quick customization scripts for WSL2 - Ubuntu


## Install zsh shell with theme
This script automates the required packages and basic setup.
```bash
curl -sL https://raw.githubusercontent.com/viceo/wsl-ubuntu/refs/heads/master/setup.bash | bash
```

## Install rust
Install pre-requisite (build-essential) and perform custom rust installation (enter when asked)
```bash
sudo apt install build-essential
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## Install eza
"ls" replacement
```bash
cargo install eza
echo "alias ls='eza -g'" >> $ZSH_CUSTOM/aliases.zsh
```
