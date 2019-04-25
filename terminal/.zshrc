# Red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"
 
# Enable Prezto
if [ -f $HOME/.zprezto/init.zsh ]; then
    source $HOME/.zprezto/init.zsh
fi

# Source bashrc file
source $HOME/.bashrc

# Zsh specific aliases
alias zshr="source ~/.zshrc"
# Get full history by default
alias history="history -E 1"

# Add some autocompletions
compdef shally=ssh
compdef vims=vim

zstyle ':prezto:module:prompt' theme 'nicoulaj'

# Enable fzf
if [ -e ~/.fzf ]; then
  export PATH="$PATH:$HOME/.fzf/bin"
  source $HOME/.fzf/shell/key-bindings.zsh
  source $HOME/.fzf/shell/completion.zsh

  # Update fzf options
  export FZF_DEFAULT_OPTS="--bind ctrl-t:down,ctrl-s:up"

  # Set default command
  export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
fi
