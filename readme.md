# WSL Ubuntu

Quick customization scripts for WSL2 - Ubuntu


## Install zsh shell with theme
```bash
curl -sL https://raw.githubusercontent.com/viceo/wsl-ubuntu/refs/heads/master/install.bash | bash
```

## Install rust
```bash
# Pre-requisite
sudo apt install build-essential
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## Install eza
```bash
cargo install eza
echo "alias ls='eza -g'" >> $ZSH_CUSTOM/aliases.zsh
```
