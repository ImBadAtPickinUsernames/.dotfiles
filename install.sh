#!/bin/bash

clone_dotfiles() {
    yay --save --answerclean N --answerdiff N
    if yay -Qs git > /dev/null ; then
        echo "git ist schon installiert."
    else
        yay -S git
    fi
    git clone https://github.com/ImBadAtPickinUsernames/.dotfiles.git
}

install_basics() {
    yay --save --answerclean N --answerdiff N
    if yay -Qs neofetch > /dev/null ; then
        echo "Neofetch ist schon installiert."
    else
        yay -S neofetch
    fi
    if yay -Qs kitty > /dev/null ; then
        echo "Kitty ist schon installiert."
    else
        yay -S kitty
    fi
    if yay -Qs code > /dev/null ; then
        echo "VSCode ist schon installiert."
    else
        yay -S code
    fi
    if yay -Qs jq > /dev/null ; then
        echo "jq ist schon installiert."
    else
        yay -S jq
    fi
    if yay -Qs firefox > /dev/null ; then
        echo "Firefox ist schon installiert."
    else
        yay -S firefox
    fi
}

install_vs_code_extensions() {
    code --install-extension aaron-bond.better-comments
    code --install-extension catppuccin.catppuccin-vsc
    code --install-extension catppuccin.catppuccin-vsc-icons
    code --install-extension esbenp.prettier-vscode
    code --install-extension mechatroner.rainbow-csv
    code --install-extension ms-ceintl.vscode-language-pack-de
    code --install-extension ms-python.debugpy
    code --install-extension ms-python.python
    code --install-extension yzhang.markdown-all-in-one
}

install_standard_packages() {
    yay --save --answerclean N --answerdiff N
    if yay -Qs remmina > /dev/null ; then
        echo "Remmina ist schon installiert."
    else
        yay -S remmina
    fi
    if yay -Qs freerdp > /dev/null ; then
        yay -S freerdp
    else
        echo "FreeRDP ist schon installiert."
    fi
    if yay -Qs spotify > /dev/null ; then
        echo "Spotify ist schon installiert."
    else
        yay -S spotify
    fi
    if yay -Qs spicetify-cli > /dev/null ; then
        echo "Spicetify ist schon installiert."
    else
        yay -S spicetify-cli
    fi
    if yay -Qs cava > /dev/null ; then
        echo "cava ist schon installiert."
    else
        yay -S cava
    fi
    if yay -Qs discord > /dev/null ; then
        echo "Discord ist schon installiert."
    else
        yay -S discord
    fi
    if yay -Qs betterdiscordctl > /dev/null ; then
        echo "BetterDiscord ist schon installiert."
    else
        yay -S betterdiscordctl
    fi
    if yay -Qs geckodriver > /dev/null ; then
        echo "Geckodriver ist schon installiert."
    else
        yay -S geckodriver
    fi
    if yay -Qs thunderbird > /dev/null ; then
        echo "Thunderbird ist schon installiert."
    else
        yay -S thunderbird
    fi
    if yay -Qs pycharm-community-edition > /dev/null ; then
        echo "PyCharm ist schon installiert."
    else
        yay -S pycharm-community-edition
    fi
    if yay -Qs android-studio > /dev/null ; then
        echo "Android Studio ist schon installiert."
    else
        yay -S android-studio
    fi
}

install_fonts() {
    if yay -Qs ttf-roboto > /dev/null ; then
        echo "Roboto ist schon installiert."
    else
        yay -S ttf-roboto
    fi
    if yay -Qs ttf-jetbrains-mono-nerd > /dev/null ; then
        echo "JetBrains Nerd Font ist schon installiert."
    else
        yay -S ttf-jetbrains-mono-nerd
    fi
}

create_symlinks() {
    # Wenn Datei bereits existiert dann löschen
    if [ -f "$HOME/.gitconfig" ]; then
        sudo rm "$HOME/.gitconfig"
    fi
    if [ -f "$HOME/.bashrc" ]; then
        sudo rm "$HOME/.bashrc"
    fi
    if [ -f "$HOME/.config/neofetch/config.conf" ]; then
        sudo rm "$HOME/.config/neofetch/config.conf"
    fi
    if [ -f "$HOME/.config/kitty/kitty.conf" ]; then
        sudo rm "$HOME/.config/kitty/kitty.conf"
    fi
    if [ -f "$HOME/.config/Code - OSS/User/settings.json" ]; then
        sudo rm "$HOME/.config/Code - OSS/User/settings.json"
    fi
    if [ -f "$HOME/.config/Code - OSS/User/keybindings.json" ]; then
        sudo rm "$HOME/.config/Code - OSS/User/keybindings.json"
    fi
    # Anschließend durch Symlink ersetzen
    ln -s "$HOME/.dotfiles/.gitconfig" "$HOME/.gitconfig"
    ln -s "$HOME/.dotfiles/.bashrc" "$HOME/.bashrc"
    ln -s "$HOME/.dotfiles/.config/neofetch/config.conf" "$HOME/.config/neofetch/config.conf"
    ln -s "$HOME/.dotfiles/.config/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
    ln -s "$HOME/.dotfiles/.config/Code - OSS/User/settings.json" "$HOME/.config/Code - OSS/User/settings.json"
    ln -s "$HOME/.dotfiles/.config/Code - OSS/User/keybindings.json" "$HOME/.config/Code - OSS/User/keybindings.json"
}

configure_spotify() {
    git clone https://github.com/catppuccin/spicetify.git
    cp -r spicetify/catppuccin ~/.config/spicetify/Themes/
    rm -rf spicetify
    sudo chmod a+wr /opt/spotify
    sudo chmod a+wr /opt/spotify/Apps -R
    # Jetzt Spotify öffnen und einloggen damit prefs file generiert wird
    echo "Bitte Spotify öffnen und einloggen damit die Einstellungs Datei von Spotify generiert wird."
    read -p "Drücke [Enter] damit es weitergeht."
    # Warte auf Eingabe
    spicetify backup apply
    spicetify config current_theme catppuccin
    spicetify config color_scheme frappe
    spicetify config inject_css 1 inject_theme_js 1 replace_colors 1 overwrite_assets 1
    spicetify apply
}

configure_discord() {
    betterdiscordctl install
    cat << 'EOT' > ~/.config/BetterDiscord/data/stable/custom.css 
@import url("https://catppuccin.github.io/discord/dist/catppuccin-mocha.theme.css");
EOT
}

download_wallpapers() {
    git clone https://github.com/zhichaoh/catppuccin-wallpapers.git 
    mv $HOME/catppuccin-wallpapers $HOME/Bilder/catppuccin-wallpapers catppuccin-wallpapers
}

make_directories() {
    if [ -f "$HOME/workspace" ]; then
        echo "$HOME/workspace existiert bereits."
    else
        echo "$HOME/workspace wird angelegt."
        mkdir $HOME/workspace
    fi
}

configure_kde() {
    git clone --depth=1 https://github.com/catppuccin/kde catppuccin-kde
    mv $HOME/catppuccin-kde $HOME/Dokumente/catppuccin-kde
    cd $HOME/Dokumente/catppuccin-kde
    ./install.sh
}

# Dotfiles clonen
read -r -p "Möchtest du deine Dotfiles klonen? [Y|N] " configresponse
if [[ $configresponse =~ ^(y|yes|Y) ]];then
    clone_dotfiles
else
    echo "Die Dotfiles werden nicht geklont."
fi

# Wichtige Programme installieren
read -r -p "Möchtest du die wichtigsten Programme installieren? [Y|N] " configresponse
if [[ $configresponse =~ ^(y|yes|Y) ]];then
    install_basics
else
    echo "Die wichtigsten Programme werden nicht installiert."
fi

# VS Code einrichten
read -r -p "Möchtest du VSCode Erweiterungen installieren? [Y|N] " configresponse
if [[ $configresponse =~ ^(y|yes|Y) ]] ; then
    install_vs_code_extensions
else
    echo "VSCode Erweiterungen werden nicht installiert."
fi

# Standard Programme installieren
read -r -p "Möchtest du die restlichen Programme installieren? [Y|N] " configresponse
if [[ $configresponse =~ ^(y|yes|Y) ]];then
    install_standard_packages
else
    echo "Die restlichen Programme werden nicht installiert."
fi

# Fonts downloaden
read -r -p "Möchtest du Fonts installieren? [Y|N] " configresponse
    install_fonts
else
    echo "Fonts werden nicht installiert."
fi

# Symlinks erstellen
read -r -p "Möchtest du Symlinks erstellen? [Y|N] " configresponse
if [[ $configresponse =~ ^(y|yes|Y) ]];then
    create_symlinks
else
    echo "Die Symlinks werden nicht erstellt."
fi

# Spotify einrichten
read -r -p "Möchtest du Spicetify einrichten? [Y|N] " configresponse
if [[ $configresponse =~ ^(y|yes|Y) ]] ; then
    configure_spotify
else
    echo "Spicetify wird nicht eingerichtet."
fi

# Discord einrichten
read -r -p "Möchtest du BetterDiscord einrichten? [Y|N] " configresponse
    configure_discord
else
    echo "BetterDiscord wird nicht eingerichtet."
fi

# Wallpaper downloaden
read -r -p "Möchtest du Wallpaper downloaden und hinterlegen? [Y|N] " configresponse
    download_wallpapers
else
    echo "Wallpaper werden nicht gedownloaded und hinterlegt."
fi

# Ordner Strukturen einrichten
read -r -p "Möchtest du Ordner Strukturen erstellen? [Y|N] " configresponse
    make_directories
else
    echo "Ordner Strukturen werden nicht erstellt."
fi

# KDE einrichten
read -r -p "Möchtest du KDE einrichten? [Y|N] " configresponse
    configure_kde
else
    echo "KDE wird nicht eingerichtet."
fi
