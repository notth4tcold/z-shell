# Backup e Criptografia de Configurações

Este guia explica como realizar backup e criptografia das suas configurações essenciais no Linux, bem como como descriptografar e restaurar os arquivos.

---

## 🔹 Sempre Fazer Backup de:

- `~/.zsh_history`
- `~/.ssh/`
- `~/.gitconfig`

---

## 💾 Backup Manual

Crie um arquivo tar com as configurações:

```bash
tar -czf backup_configs.tar.gz ~/.ssh ~/.zsh_history ~/.gitconfig
```

### Criptografia

Criptografe o backup com GPG:

```bash
gpg -c backup_configs.tar.gz
```

- Você será solicitado a inserir uma senha para criptografia.
- Isso gera o arquivo `backup_configs.tar.gz.gpg`.

### Limpar arquivo original (opcional)

```bash
rm -rf backup_configs.tar.gz
```

---

## 🔓 Descriptografar e Restaurar

Para recuperar o backup:

```bash
gpg -d backup_configs.tar.gz.gpg > backup_configs.tar.gz
tar -xzf backup_configs.tar.gz
```

- Você precisará da senha usada na criptografia.
- Isso irá extrair os arquivos originais para o diretório atual.

---

## ⚡ Automação com Script

Se você possui o `backup.sh`, basta executá-lo:

```bash
./backup.sh
```

- O script já cuida de copiar arquivos/pastas, criar o tar e criptografar automaticamente.
- O arquivo tar original será removido após a criptografia.

---

## 📝 Dicas

- Mantenha seu arquivo `.gpg` em um local seguro.
- Use senhas fortes e únicas para a criptografia.
- Faça backups periódicos para evitar perda de dados.
- Você pode criar backups automáticos usando cron ou systemd timers.
