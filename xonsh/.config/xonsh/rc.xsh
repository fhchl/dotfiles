from xonsh.built_ins import XSH
import os.path
from os import path

# $XONSH_COLOR_STYLE = 'dracula'
# $XONSH_SHOW_TRACEBACK = True
$XONTRIB_SH_SHELLS = ['bash', 'sh']
$STARSHIP_CONFIG = '~/.config/xonsh/starship.toml'

$user_bins = [
    f'{$HOME}/.cargo/bin',
    f'{$HOME}/.pyenv/bin',
    f'{$HOME}/.poetry/bin',
    f'{$HOME}/.local/bin', 
    f'{$HOME}/Miniconda3/bin',
]

for dir in $user_bins:
    if path.isdir(dir) and path.exists(dir):
        $PATH.add(dir,front=True, replace=True)

$EDITOR = "hx"

xontrib load coreutils
xontrib load prompt_starship
xontrib load sh
xontrib load fzf-completions
xontrib load direnv
# xontrib load pyenv

XSH.env['fzf_history_binding'] = "c-r"  # Ctrl+R
XSH.env['fzf_ssh_binding'] = "c-s"  # Ctrl+S
XSH.env['fzf_file_binding'] = "c-t"  # Ctrl+T
XSH.env['fzf_dir_binding'] = "c-g"  # Ctrl+G

aliases["lg"] = "lazygit"

execx($(zoxide init xonsh), 'exec', __xonsh__.ctx, filename='zoxide')

def y():
    tmp = $(mktemp -t "yazi-cwd.XXXXXX")
    $[yazi @(f"--cwd-file={tmp}")]
    with open(tmp) as f:
        cwd = f.read().strip()
    if cwd != $PWD:
        cd @(cwd)
    rm -f -- @(tmp)

aliases["y"] = y

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if !(test -f "/home/fheuchel/Miniconda3/bin/conda"):
    import sys as _sys
    from types import ModuleType as _ModuleType
    _mod = _ModuleType("xontrib.conda",
                    "Autogenerated from $(/home/fheuchel/Miniconda3/bin/conda shell.xonsh hook)")
    __xonsh__.execer.exec($("/home/fheuchel/Miniconda3/bin/conda" "shell.xonsh" "hook"),
                        glbs=_mod.__dict__,
                        filename="$(/home/fheuchel/Miniconda3/bin/conda shell.xonsh hook)")
    _sys.modules["xontrib.conda"] = _mod
    del _sys, _mod, _ModuleType
# <<< conda initialize <<<
