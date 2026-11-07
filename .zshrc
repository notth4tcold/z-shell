# 🛤️ PATH & Configs
export PATH="$HOME/.local/bin:${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
export ZSH="$HOME/.oh-my-zsh"

# JAVA_HOME via asdf (sem quebrar o shell se asdf/java não estiverem instalados)
if (( $+commands[asdf] )) && _java="$(asdf where java 2>/dev/null)"; then
    export JAVA_HOME="$_java"
fi
unset _java

# ⚙️ Oh My Zsh
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# 🌟 Starship Prompt
eval "$(starship init zsh)"

# 🛠️ Aliases

# Navegação
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Listagem e pesquisa
alias ll='ls -la --color=auto'
alias grep='grep --color=auto'
alias c='clear'

# Programação
alias py='python3'
alias gdb='gdb -q'
alias ngrokserver='curl -s http://localhost:4040/api/tunnels | jq ".tunnels[].public_url"'

# Rede e monitoramento
alias netstat='netstat -tulnp'
alias myip="curl -s https://ifconfig.me; echo"

# Produtividade
alias reload='source ~/.zshrc'
alias badapple='cd $HOME/videos/Bad-Apple && ./badapple-ffmpeg-linux.out'

# Pacotes (Arch Linux)
alias pacs='sudo pacman -S'
alias pacr='sudo pacman -R'
alias pacu='sudo pacman -Syu'

# 🚀 Fastfetch na inicialização
(( $+commands[fastfetch] )) && clear && fastfetch
