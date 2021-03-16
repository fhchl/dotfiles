Requires stow

    sudo apt install stow

Clone and init submodules

   git clone --recurse-submodules https://github.com/fhchl/dotfiles.git

Install for single app

    stow zsh

Install all

    stow *

For sublime

   ln -s ~/dotfiles/sublime/.config/sublime-text-3/Packages/User ~/.config/sublime-text-3/Packages/User

Check ignored files

    git status --ignored


