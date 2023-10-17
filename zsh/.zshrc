export LANG=en_US.UTF-8
export EDITOR=hx
export VISUAL=$EDITOR
export ZSH=$HOME/.oh-my-zsh
export BUP_DIR=/media/M/Backup/bup-ubuntu
export PATH=$PATH:$HOME/.cabal/bin/
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/.local/zk
export TEXMACS_PATH=~/.local/texmacs/TeXmacs
export PATH=$TEXMACS_PATH/bin:$PATH

# export PATH="/home/fhchl/miniconda3/bin:$PATH"  # commented out by conda initialize
export PATH=/usr/local/texlive/2019/bin/x86_64-linux:$PATH
export PATH=$HOME/.local/bin:$PATH # julia
export MANPATH=/usr/local/texlive/2019/texmf-dist/doc/man:$MANPATH
export INFOPATH=/usr/local/texlive/2019/texmf-dist/doc/info:$INFOPATH

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
alias rr='ranger'
alias nv='nvim'

# open as on mac
alias open='xdg-open &>/dev/null'

# conda environment
alias ea='conda activate'
alias ed='conda deactivate'
alias el='conda env list'

alias checkcode='pycodestyle && pydocstyle'

# classify ls and ll
alias l='exa -lahF'
alias la='exa -lahF'
alias ll='exa -lhF'
alias ls='exa -F'

alias dotfiles='cd ~/dotfiles'
alias mirror='mplayer tv:// -tv driver=v4l2:width=640:height=480:device=/dev/video0:fps=30:outfmt=yuy2'
# for tlmgr
alias psudo='sudo env PATH="$PATH"'
alias sioyek='~/opt/Sioyek-x86_64.AppImage &>/dev/null & disown'

# modified "fishy" prompt
# https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/fishy.zsh-theme
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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/fhchl/mambaforge/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/fhchl/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/home/fhchl/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/home/fhchl/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/fhchl/mambaforge/etc/profile.d/mamba.sh" ]; then
    . "/home/fhchl/mambaforge/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

# hide conda env in prompt
conda config --set changeps1 false
conda config --set auto_activate_base false


[ -f "/home/fhchl/.ghcup/env" ] && source "/home/fhchl/.ghcup/env" # ghcup-env

# https://github.com/phiresky/ripgrep-all
rga-fzf() {
	RG_PREFIX="rga --files-with-matches"
	local file
	file="$(
		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
				--phony -q "$1" \
				--bind "change:reload:$RG_PREFIX {q}" \
				--preview-window="70%:wrap"
	)" &&
	echo "opening $file" &&
	xdg-open "$file"
}

# https://github.com/jesseduffield/lazygit#changing-directory-on-exit
lg()
{
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/home/fhchl/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<
