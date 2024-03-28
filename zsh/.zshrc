# Envs
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

export EDITOR=nvim
export SUDO_EDITOR=nvim
export VISUAL=$EDITOR
export ZSH=$HOME/.oh-my-zsh
export PATH=$PATH:/opt/nvim-linux64/bin
export PATH=$HOME/.local/bin:$PATH # julia

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"A

export PATH=/usr/local/texlive/2019/bin/x86_64-linux:$PATH
export MANPATH=/usr/local/texlive/2019/texmf-dist/doc/man:$MANPATH
export INFOPATH=/usr/local/texlive/2019/texmf-dist/doc/info:$INFOPATH

# ZSH
ZSH_THEME="robbyrussell"
COMPLETION_WAITING_DOTS="true"
plugins=(git pip zoxide fzf last-working-dir pyenv poetry direnv)
source $ZSH/oh-my-zsh.sh

# Conda
# for conda-zsh-completion https://github.com/esc/conda-zsh-completion
autoload -U compinit && compinit

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

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# https://github.com/Sonico98/yazi-prompt.sh
YAZI_TERM=""
if [ -n "$YAZI_LEVEL" ]; then
	YAZI_TERM="|  Yazi terminal: "
fi
PS1="$PS1$YAZI_TERM"
