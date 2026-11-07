#!/bin/bash
# Uso: ./restore.sh [destino]
# Descriptografa o backup e extrai em [destino] (padrão: um diretório temporário novo),
# para você conferir antes de copiar qualquer coisa para o $HOME.
set -euo pipefail
umask 077

cd "$(dirname "$(realpath "$0")")"

DEST="${1:-$(mktemp -d "${TMPDIR:-/tmp}/restore.XXXXXX")}"
mkdir -p "$DEST"

gpg --quiet --decrypt backup_configs.tar.gz.gpg | tar -xzf - -C "$DEST"

echo "Arquivos extraídos em: $DEST"
echo
echo "Para aplicar (revise antes!):"
echo "  cp -a \"$DEST\"/. ~/"
echo "  chmod 700 ~/.ssh && chmod 600 ~/.ssh/*"
