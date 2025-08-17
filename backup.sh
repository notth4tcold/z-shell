#!/bin/bash

# Criar diretório .config se não existir
mkdir -p .config

# Copiar arquivos e pastas para .config/ ou diretório atual
cp -r ~/.config/fastfetch .config/
cp -r ~/.config/starship.toml .config/
cp -r ~/.zshrc .
cp -r ~/ascii .

# Criar arquivo tar com configs sensíveis
tar -czf backup_configs.tar.gz ~/.ssh ~/.zsh_history ~/.gitconfig

# Criptografar o backup (override automático)
gpg -c --batch --yes backup_configs.tar.gz

# Remover o tar original
rm -rf backup_configs.tar.gz

echo "Backup completo e criptografado com sucesso."
