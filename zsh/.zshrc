export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

export EDITOR=hx
export SUDO_EDITOR=hx
export VISUAL=$EDITOR
export ZSH=$HOME/.oh-my-zsh
export BUP_DIR=/media/M/Backup/bup-ubuntu
export PATH=$PATH:$HOME/.cabal/bin/
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/.local/zk
export TEXMACS_PATH=~/.local/texmacs/TeXmacs
export PATH=$TEXMACS_PATH/bin:$PATH

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

# export PATH="/home/fhchl/miniconda3/bin:$PATH"  # commented out by conda initialize
export PATH=/usr/local/texlive/2019/bin/x86_64-linux:$PATH
export PATH=$HOME/.local/bin:$PATH # julia
export MANPATH=/usr/local/texlive/2019/texmf-dist/doc/man:$MANPATH
export INFOPATH=/usr/local/texlive/2019/texmf-dist/doc/info:$INFOPATH

ZSH_THEME="robbyrussell"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git pip zoxide fzf aliases last-working-dir pyenv poetry)

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

alias n='NNN_PLUG='p:preview-tui' nnn -a -e -P p'

# classify ls and ll
alias la='ls -laF'
alias ll='exa -lF'
#alias ls='exa -F'

alias dotfiles='cd ~/dotfiles'
alias mirror='mplayer tv:// -tv driver=v4l2:width=640:height=480:device=/dev/video0:fps=30:outfmt=yuy2'
# for tlmgr
alias psudo='sudo env PATH="$PATH"'
alias sioyek='~/opt/Sioyek-x86_64.AppImage &>/dev/null & disown'



# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/fhchl/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/fhchl/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/fhchl/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/fhchl/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/fhchl/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/home/fhchl/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

if type conda >/dev/null 2>&1
then
  # hide conda env in prompt
  conda config --set changeps1 true
  conda config --set auto_activate_base false
fi


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

# source /home/fhchl/.config/broot/launcher/bash/br

# Pixi
export PATH=$PATH:/home/fhchl/.pixi/bin
if type pixi >/dev/null 2>&1
then
  eval "$(pixi completion --shell zsh)"
fi

# Direnv
if type direnv >/dev/null 2>&1
then
  eval "$(direnv hook bash)"
fi

# yazi file manager
function ya() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}