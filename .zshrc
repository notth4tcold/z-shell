# 🛤️ PATH & Configs
export PATH="$PATH:/usr/bin:/usr/sbin"
export JAVA_HOME=$(asdf where java)
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
export ZSH="$HOME/.oh-my-zsh"
export STARSHIP_CONFIG="$HOME/.config/starship.toml"

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
alias myip="curl ifconfig.me"

# Produtividade
alias reload='source ~/.zshrc'
alias badapple='cd $HOME/videos/Bad-Apple && ./badapple-ffmpeg-linux.out'

# Pacotes (Arch Linux)
alias pacs='sudo pacman -S'
alias pacr='sudo pacman -R'
alias pacu='sudo pacman -Syu'

# 🚀 Fastfetch na inicialização
clear && fastfetch
