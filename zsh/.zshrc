export LANG=en_US.UTF-8
export EDITOR='/usr/bin/nvim -w'
export VISUAL='/usr/bin/code -w'
export ZSH=$HOME/.oh-my-zsh
export BUP_DIR=/media/M/Backup/bup-ubuntu

export PATH=$HOME/miniconda/bin:$PATH
export PATH=/usr/local/texlive/2019/bin/x86_64-linux:$PATH
export PATH=$HOME/.local/bin # julia
export MANPATH=/usr/local/texlive/2019/texmf-dist/doc/man:$MANPATH
export INFOPATH=/usr/local/texlive/2019/texmf-dist/doc/info:$INFOPATH

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/fhchl/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/fhchl/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/fhchl/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/fhchl/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# hide conda env in prompt
conda config --set changeps1 false

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git pip fasd conda-zsh-completion)

source $ZSH/oh-my-zsh.sh

# for conda-zsh-completion https://github.com/esc/conda-zsh-completion
autoload -U compinit && compinit

# Aliases
alias jn='jupyter notebook'
alias jl='jupyter lab'
alias jc='jupyter notebook \
  --NotebookApp.allow_origin='https://colab.research.google.com' \
  --port=8888 \
  --NotebookApp.port_retries=0'

# open as on mac
alias open='xdg-open &>/dev/null'

# conda environment
alias ea='conda activate'
alias ed='conda deactivate'
alias el='conda env list'

alias checkcode='pycodestyle && pydocstyle'

# classify ls and ll
alias l='ls -lahF'
alias la='ls -lAhF'
alias ll='ls -lhF'
alias ls='ls --color=tty -F'
alias lsa='ls -lahF'

alias rsync_tmbackup=$HOME/GitHub/rsync-time-backup/rsync_tmbackup.sh

# git clone https://github.com/bhilburn/powerlevel9k.git ~/powerlevel9

alias mirror='mplayer tv:// -tv driver=v4l2:width=640:height=480:device=/dev/video0:fps=30:outfmt=yuy2'

# for tlmgr
alias psudo='sudo env PATH="$PATH"'


# # modified "fishy" prompt
# # https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/fishy.zsh-theme
_fishy_collapsed_wd() {
  echo $(pwd | perl -pe '
   BEGIN {
      binmode STDIN,  ":encoding(UTF-8)";
      binmode STDOUT, ":encoding(UTF-8)";
   }; s|^$ENV{HOME}|~|g; s|/([^/.])[^/]*(?=/)|/$1|g; s|/\.([^/])[^/]*(?=/)|/.$1|g
')
}

local user_color='green'; [ $UID -eq 0 ] && user_color='red'
NEWLINE=$'\n'
PROMPT='%{$fg[$user_color]%}$(_fishy_collapsed_wd)%{$reset_color%} ($CONDA_DEFAULT_ENV) ${NEWLINE}%(!.#.>) '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'

local return_status="%{$fg_bold[red]%}%(?..%?)%{$reset_color%}"
RPROMPT="${RPROMPT}"'${return_status}$(git_prompt_info)$(git_prompt_status)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=" "
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[blue]%}!"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%}-"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[magenta]%}>"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[yellow]%}#"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[cyan]%}?"

# initialize fzf
source /usr/share/doc/fzf/examples/key-bindings.zsh
