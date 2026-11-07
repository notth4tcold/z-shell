# Backup e Criptografia de Configurações

Este guia explica como realizar backup e criptografia das suas configurações essenciais no Linux, bem como como descriptografar e restaurar os arquivos.

---

## 🔹 Sempre Fazer Backup de:

- `~/.zsh_history`
- `~/.ssh/`
- `~/.gitconfig`

---

## ⚡ Backup (script)

```bash
./backup.sh
```

- Sincroniza `.zshrc`, `starship.toml`, `fastfetch/` e `ascii/` para o repo.
- Empacota `~/.ssh`, `~/.zsh_history` e `~/.gitconfig` e envia **direto** para o GPG
  (o `.tar.gz` em texto puro nunca é gravado em disco).
- Pede a senha duas vezes e depois verifica o arquivo gerado (pede a senha de novo).
  O backup antigo só é substituído se a verificação passar.
- Criptografia fixada: AES256, S2K SHA512 com contagem máxima de iterações.

## 🔓 Restaurar

```bash
./restore.sh            # extrai em um diretório temporário novo
./restore.sh ~/restore  # ou em um destino à sua escolha
```

O script não sobrescreve nada no `$HOME`; ele mostra o comando para copiar depois de você revisar.

<details>
<summary>Manual (sem os scripts)</summary>

```bash
# backup
tar -czf - -C ~ .ssh .zsh_history .gitconfig | gpg -c --cipher-algo AES256 -o backup_configs.tar.gz.gpg
# restaurar
mkdir -p ~/restore && gpg -d backup_configs.tar.gz.gpg | tar -xzf - -C ~/restore
```
</details>

> Backups feitos antes desta versão guardam os caminhos absolutos (`home/mei/.ssh/...`),
> então ao restaurá-los os arquivos aparecem em `<destino>/home/mei/`.

---

## 📝 Dicas

- Use senhas fortes e únicas para a criptografia.
- Faça backups periódicos para evitar perda de dados.
- Você pode criar backups automáticos usando cron ou systemd timers.
