#!/bin/bash
set -euo pipefail
umask 077

# Sempre trabalhar na pasta do repositório, de onde quer que o script seja chamado
cd "$(dirname "$(realpath "$0")")"

OUT="backup_configs.tar.gz.gpg"
TMP="$(mktemp "${OUT}.XXXXXX")"
trap 'rm -f "$TMP"' EXIT

# Sincronizar configs públicas (--delete remove do repo o que foi apagado em ~)
mkdir -p .config
rsync -a --delete ~/.config/fastfetch/ .config/fastfetch/
rsync -a --delete ~/ascii/ ascii/
cp ~/.config/starship.toml .config/
cp ~/.zshrc .

# Configs sensíveis: só inclui o que existir, com caminhos relativos ao $HOME
SECRETS=()
for f in .ssh .zsh_history .gitconfig; do
    if [[ -e "$HOME/$f" ]]; then
        SECRETS+=("$f")
    else
        echo "Aviso: ~/$f não existe, pulando." >&2
    fi
done
(( ${#SECRETS[@]} )) || { echo "Nada para fazer backup." >&2; exit 1; }

# tar direto no gpg: o .tar.gz em texto puro nunca toca o disco.
# Sem --batch, o pinentry pede a senha duas vezes (evita erro de digitação).
tar -czf - -C "$HOME" --exclude='.ssh/*.sock' --exclude='.ssh/control*' "${SECRETS[@]}" \
    | gpg --symmetric --yes --no-symkey-cache \
          --cipher-algo AES256 \
          --s2k-mode 3 --s2k-digest-algo SHA512 --s2k-count 65011712 \
          --output "$TMP"

# Conferir se o arquivo é íntegro antes de substituir o backup antigo
echo "Verificando backup (digite a senha novamente)..."
gpg --quiet --decrypt --no-symkey-cache "$TMP" | tar -tzf - >/dev/null

mv -f "$TMP" "$OUT"
trap - EXIT

echo "Backup completo e criptografado com sucesso: $OUT"
