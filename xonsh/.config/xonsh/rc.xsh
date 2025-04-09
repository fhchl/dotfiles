from xonsh.built_ins import XSH
import os.path
from os import path

# $XONSH_COLOR_STYLE = 'dracula'
# $XONSH_SHOW_TRACEBACK = True
$XONTRIB_SH_SHELLS = ['bash', 'sh']
$STARSHIP_CONFIG = '~/.config/xonsh/starship.toml'
$PATH.prepend('~/.local/bin')
$PATH.prepend('~/.cargo/bin')

$EDITOR = "hx"

xontrib load coreutils
xontrib load prompt_starship
xontrib load sh
xontrib load fzf-completions
xontrib load direnv

XSH.env['fzf_history_binding'] = "c-r"  # Ctrl+R
XSH.env['fzf_ssh_binding'] = "c-s"  # Ctrl+S
XSH.env['fzf_file_binding'] = "c-t"  # Ctrl+T
XSH.env['fzf_dir_binding'] = "c-g"  # Ctrl+G

aliases["lg"] = "lazygit"

execx($(zoxide init xonsh), 'exec', __xonsh__.ctx, filename='zoxide')

def _y(args):
    tmp = $(mktemp -t "yazi-cwd.XXXXXX")
    args.append(f"--cwd-file={tmp}")
    $[yazi @(args)]
    with open(tmp) as f:
        cwd = f.read().strip()
    if cwd != $PWD:
        cd @(cwd)
    rm -f -- @(tmp)

aliases["y"] = _y
