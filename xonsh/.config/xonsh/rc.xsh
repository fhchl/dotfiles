from xonsh.built_ins import XSH

# $XONSH_COLOR_STYLE = 'dracula'
# $XONSH_SHOW_TRACEBACK = True
$XONTRIB_SH_SHELLS = ['bash', 'sh']
$STARSHIP_CONFIG = '~/.config/xonsh/starship.toml'
$PATH.prepend('~/.local/bin')
$PATH.prepend('~/.pyenv/bin')
$PATH.prepend('~/.cargo/bin')

$EDITOR = "hx"

xontrib load coreutils
xontrib load prompt_starship
xontrib load sh
xontrib load fzf-completions
xontrib load direnv
xontrib load pyenv

XSH.env['fzf_history_binding'] = "c-r"  # Ctrl+R
XSH.env['fzf_ssh_binding'] = "c-s"  # Ctrl+S
XSH.env['fzf_file_binding'] = "c-t"  # Ctrl+T
XSH.env['fzf_dir_binding'] = "c-g"  # Ctrl+G

aliases["lg"] = "lazygit"

execx($(zoxide init xonsh), 'exec', __xonsh__.ctx, filename='zoxide')

