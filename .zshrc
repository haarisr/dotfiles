# Auto install zap
# Auto install oh my posh
# Auto install fzf
# Auto install fd

# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-completions"
plug "zap-zsh/supercharge"
plug "Aloxaf/fzf-tab"

unsetopt AUTO_MENU
unsetopt MENU_COMPLETE

# # Load Git completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
zstyle ':completion:*' menu no
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

bindkey -v

alias gpureload="sudo rmmod nvidia_uvm ; sudo modprobe nvidia_uvm"
alias audioreload="sudo alsa force-reload"

export EDITOR="nvim"
export VISUAL="nvim"

export CC="/usr/bin/gcc-13"
export CXX="/usr/bin/g++-13"

export CUDA_HOME=/usr/local/cuda-12
export PATH=$CUDA_HOME/bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$CUDA_HOME/lib64"

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'

export FZF_DEFAULT_OPTS="
  --height 45%
  --layout=reverse
  --border
  --ansi
  --preview 'bat --style=numbers --color=always --line-range :200 {} || ls --color=always {}'
  --preview-window=right:60%
"


# eval "$(oh-my-posh init zsh --config "~/zen.toml")"
# zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'


autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd r edit-command-line

cursor_mode() {
    # See https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html for cursor shapes
    cursor_block='\e[2 q'
    cursor_beam='\e[6 q'

    function zle-keymap-select {
        if [[ ${KEYMAP} == vicmd ]] ||
            [[ $1 = 'block' ]]; then
            echo -ne $cursor_block
        elif [[ ${KEYMAP} == main ]] ||
            [[ ${KEYMAP} == viins ]] ||
            [[ ${KEYMAP} = '' ]] ||
            [[ $1 = 'beam' ]]; then
            echo -ne $cursor_beam
        fi
    }

    zle-line-init() {
        echo -ne $cursor_beam
    }

    zle -N zle-keymap-select
    zle -N zle-line-init
}

cursor_mode

# fnm
FNM_PATH="/home/haarisr/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/haarisr/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi

. "$HOME/.local/bin/env"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# export __NV_PRIME_RENDER_OFFLOAD=1
# export __GLX_VENDOR_LIBRARY_NAME=nvidia

eval "$(starship init zsh)"


# vf() {
#     local file
#     file=$(fzf --height=40% --reverse --preview 'bat --style=numbers --color=always {} || cat {}')
#     if [ -n "$file" ]; then
#         nvim "$file"
#     fi
# }

# opencode
export PATH=/home/haarisr/.opencode/bin:$PATH
source ~/.zshrc.work
