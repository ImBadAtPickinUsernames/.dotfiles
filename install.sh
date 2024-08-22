#!/bin/bash

install_basics() {
	yay --save --answerclean N --answerdiff N
	if yay -Qs kitty > /dev/null ; then
		echo "Kitty ist schon installiert."
	else
		yay -S kitty
	fi
	configure_kitty
	if yay -Qs fastfetch > /dev/null ; then
		echo "Fastfetch ist schon installiert."
	else
		yay -S fastfetch
	fi
	configure_fastfetch
	if yay -Qs btop > /dev/null ; then
		echo "btop ist schon installiert."
	else
		yay -S btop
	fi
	configure_btop
	# Muss neu installiert werden weil die Commandline sonst nicht funktioniert
	yay -S code
	configure_vscode
	if yay -Qs firefox > /dev/null ; then
		echo "Firefox ist schon installiert."
	else
		yay -S firefox
	fi
	if yay -Qs vim > /dev/null ; then
		echo "Vim ist schon installiert."
	else
		yay -S vim
	fi
	if yay -Qs neovim > /dev/null ; then
		echo "Neovim ist schon installiert."
	else
		yay -S neovim
	fi
	if yay -Qs vim-plug > /dev/null ; then
		echo "vim-plug ist schon installiert."
	else
		yay -S vim-plug
	fi
	configure_neovim
}

install_standard_packages() {
	yay --save --answerclean N --answerdiff N
	if yay -Qs cava > /dev/null ; then
		echo "cava ist schon installiert."
	else
		yay -S cava
	fi
	# Cava einrichten
	read -r -p "Möchtest du cava einrichten? [J|N] " configresponse
	if [[ $configresponse =~ ^(j|Ja|J) ]]; then
		configure_cava
	else
		echo "Cava wird nicht eingerichtet."
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
	# Spotify einrichten
	read -r -p "Möchtest du Spicetify einrichten? [J|N] " configresponse
	if [[ $configresponse =~ ^(j|Ja|J) ]]; then
		configure_spotify
	else
		echo "Spicetify wird nicht eingerichtet."
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
	# Discord einrichten
	read -r -p "Möchtest du BetterDiscord einrichten? [J|N] " configresponse
	if [[ $configresponse =~ ^(j|Ja|J) ]]; then
		configure_discord
	else
		echo "BetterDiscord wird nicht eingerichtet."
	fi
	if yay -Qs proton-vpn-gtk-app > /dev/null ; then
		echo "ProtonVPN ist schon installiert."
	else
		yay -S proton-vpn-gtk-app
	fi
	# Bei Nvidia Problemen mit Variable WEBKIT_DISABLE_COMPOSITING_MODE=1 starten
	# -> WEBKIT_DISABLE_COMPOSITING_MODE=1 foliate
	if yay -Qs foliate > /dev/null ; then
		echo "Foliate ist schon installiert."
	else
		yay -S foliate
	fi
	# Foliate einrichten
	read -r -p "Möchtest du Foliate einrichten? [J|N] " configresponse
	if [[ $configresponse =~ ^(j|Ja|J) ]]; then
		configure_foliate
	else
		echo "Foliate wird nicht eingerichtet."
	fi
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
	if yay -Qs pinta > /dev/null ; then
		echo "Pinta ist schon installiert."
	else
		yay -S pinta
	fi
	if yay -Qs bitwarden > /dev/null ; then
		echo "Bitwarden ist schon installiert."
	else
		yay -S bitwarden
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
	if yay -Qs libreoffice-still > /dev/null ; then
		echo "Libre Office ist schon installiert."
	else
		yay -S libreoffice-still
	fi
	if yay -Qs libreoffice-still-de > /dev/null ; then
		echo "Sprache Deutsch für Libre Office ist schon installiert."
	else
		yay -S libreoffice-still-de
	fi
	if yay -Qs virtualbox > /dev/null ; then
		echo "VirtualBox ist schon installiert."
	else
		yay -S virtualbox
	fi
	if yay -Qs virtualbox-guest-iso > /dev/null ; then
		echo "virtualbox-guest-iso ist schon installiert."
	else
		yay -S virtualbox-guest-iso
	fi
	if yay -Qs virtualbox-host-dkms > /dev/null ; then
		echo "virtualbox-host-dkms ist schon installiert."
	else
		yay -S virtualbox-host-dkms
	fi
	: ' Verschiebe Kommentar um Packages auszuschließen
	'
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

install_cli_fun() {
	if yay -Qs pipes.sh > /dev/null ; then
		echo "pipes.sh ist schon installiert."
	else
		yay -S pipes.sh
	fi
	if yay -Qs cbonsai > /dev/null ; then
		echo "cbonsai ist schon installiert."
	else
		yay -S cbonsai
	fi
	if yay -Qs rainfall > /dev/null ; then
		echo "rainfall ist schon installiert."
	else
		yay -S rainfall
	fi
}

install_vs_code_extensions() {
	code --install-extension aaron-bond.better-comments
	code --install-extension catppuccin.catppuccin-vsc
	code --install-extension catppuccin.catppuccin-vsc-icons
	code --install-extension donjayamanne.githistory
	code --install-extension esbenp.prettier-vscode
	code --install-extension mechatroner.rainbow-csv
	code --install-extension ms-ceintl.vscode-language-pack-de
	code --install-extension ms-python.debugpy
	code --install-extension ms-python.python
	code --install-extension naumovs.color-highlight
	code --install-extension yzhang.markdown-all-in-one
}

configure_neovim() {
	echo "Erstelle Symlinks..."
	if ! [ -d "$HOME/.config/nvim" ]; then
		mkdir "$HOME/.config/nvim"
	fi
	ln -s -f "$HOME/.dotfiles/.config/nvim/init.vim" "$HOME/.config/nvim/init.vim"
	echo "Führe beim ersten Start von neovim :PlugInstall aus, damit das Theme angewendet wird."
	echo "Fertig."
}

configure_vscode() {
	install_vs_code_extensions
	echo "Erstelle Symlinks..."
	ln -s -f "$HOME/.dotfiles/.config/Code - OSS/User/settings.json" "$HOME/.config/Code - OSS/User/settings.json"
	ln -s -f "$HOME/.dotfiles/.config/Code - OSS/User/keybindings.json" "$HOME/.config/Code - OSS/User/keybindings.json"
	echo "Fertig."
}

configure_kitty() {
	echo "Erstelle Symlinks..."
	if ! [ -d "$HOME/.config/kitty" ]; then
		mkdir "$HOME/.config/kitty"
	fi
	ln -s -f "$HOME/.dotfiles/.config/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
	echo "Fertig."
}

configure_fastfetch() {
	echo "Erstelle Symlinks..."
	if ! [ -d "$HOME/.config/fastfetch" ]; then
		mkdir "$HOME/.config/fastfetch"
	fi
	ln -s -f "$HOME/.dotfiles/.config/fastfetch/config.jsonc" "$HOME/.config/fastfetch/config.jsonc"
	echo "Fertig."
}

configure_foliate() {
	echo "Erstelle Symlinks..."
	if ! [ -d "$HOME/.config/com.github.johnfactotum.Foliate" ]; then
		mkdir "$HOME/.config/com.github.johnfactotum.Foliate"
	fi
	if ! [ -d "$HOME/.config/com.github.johnfactotum.Foliate/themes" ]; then
		mkdir "$HOME/.config/com.github.johnfactotum.Foliate/themes"
	fi
	ln -s -f "$HOME/.dotfiles/.config/com.github.johnfactotum.Foliate/themes/catppuccin-mocha.json" "$HOME/.config/com.github.johnfactotum.Foliate/themes/catppuccin-mocha.json"
	echo "Fertig."
}

configure_btop() {
	echo "Erstelle Symlinks..."
	if ! [ -d "$HOME/.config/btop" ]; then
		mkdir "$HOME/.config/btop"
	fi
	if ! [ -d "$HOME/.config/btop/themes" ]; then
		mkdir "$HOME/.config/btop/themes"
	fi
	ln -s -f "$HOME/.dotfiles/.config/btop/themes/catppuccin_mocha.theme" "$HOME/.config/btop/themes/catppuccin_mocha.theme"
	echo "Fertig."
}

configure_cava() {
	echo "Erstelle Symlinks..."
	if ! [ -d "$HOME/.config/cava" ]; then
		mkdir "$HOME/.config/cava"
	fi
	ln -s -f "$HOME/.dotfiles/.config/cava/config" "$HOME/.config/cava/"
	echo "Fertig."
}

create_basic_symlinks() {
	echo "Erstelle Symlinks..."
	# Git
	ln -s -f "$HOME/.dotfiles/.gitconfig" "$HOME/.gitconfig"
	# Bash
	ln -s -f "$HOME/.dotfiles/.bashrc" "$HOME/.bashrc"
	echo "Fertig."
}

configure_spotify() {
	# Spotify vorbereiten
	sudo chmod a+wr /opt/spotify
	sudo chmod a+wr /opt/spotify/Apps -R
	# Theme installieren
	install_spicetify_text_catppuccin
	# Erstelle Symlinks
	echo "Erstelle Symlinks..."
	ln -s -f "$HOME/.dotfiles/.config/spicetify/config-xpui.ini" "$HOME/.config/spicetify/config-xpui.ini"
	ln -s -f "$HOME/.dotfiles/.config/spicetify/Themes/text/color.ini" "$HOME/.config/spicetify/Themes/text/color.ini"
	ln -s -f "$HOME/.dotfiles/.config/spicetify/Themes/text/user.css" "$HOME/.config/spicetify/Themes/text/user.css"
	echo "Fertig."
	# Wende neue Config an
	spicetify restore 
	spicetify backup 
	spicetify apply
}

install_spicetify_text_catppuccin() {
	# Hole spicetify-themes
	git clone --depth=1 https://github.com/spicetify/spicetify-themes.git 
	if ! [ -d "$HOME/.config/spicetify" ]; then
		mkdir "$HOME/.config/spicetify"
	fi
	if ! [ -d "$HOME/.config/spicetify/Themes" ]; then
		mkdir "$HOME/.config/spicetify/Themes"
	fi
	cp -r $HOME/spicetify-themes/* $HOME/.config/spicetify/Themes
	rm -rf "$HOME/spicetify-themes"
	# Jetzt Spotify öffnen und einloggen damit prefs file generiert wird
	echo "Bitte Spotify öffnen und einloggen damit die Einstellungs Datei von Spotify generiert wird."
	read -p "Drücke [Enter] damit es weitergeht."
	# Warte auf Eingabe
	spicetify backup 
	spicetify apply
}

configure_discord() {
	# Jetzt Discord öffnen und einloggen damit prefs file generiert wird
	echo "Bitte Discord öffnen und einloggen damit die Einstellungs Datei von Discord generiert wird."
	read -p "Drücke [Enter] damit es weitergeht."
	betterdiscordctl install
	if ! [ -d "$HOME/.config/BetterDiscord" ]; then
		mkdir "$HOME/.config/BetterDiscord"
	fi
	if ! [ -d "$HOME/.config/BetterDiscord/data" ]; then
		mkdir ".config/BetterDiscord/data"
	fi
	if ! [ -d "$HOME/.config/BetterDiscord/data/stable" ]; then
		mkdir ".config/BetterDiscord/data/stable"
	fi
	echo "Erstelle Symlinks..."
	ln -s -f "$HOME/.dotfiles/.config/BetterDiscord/data/stable/custom.css" "$HOME/.config/BetterDiscord/data/stable/custom.css"
	echo "Fertig."
}

download_wallpapers() {
	git clone https://github.com/zhichaoh/catppuccin-wallpapers.git catppuccin
	mkdir "$HOME/Bilder/wallpapers"
	mv "$HOME/catppuccin" "$HOME/Bilder/wallpapers"
}

make_directories() {
	if [ -d "$HOME/workspace" ]; then
		echo "$HOME/workspace existiert bereits."
	else
		echo "$HOME/workspace wird angelegt."
		mkdir "$HOME/workspace"
	fi
}

delete_kde_bloat() {
	if yay -Qs kate > /dev/null ; then
		yay -Rn kate
	else
		echo "Kate ist nicht installiert."
	fi
	if yay -Qs okular > /dev/null ; then
		yay -Rn okular
	else
		echo "Okular ist nicht installiert."
	fi
	if yay -Qs meld > /dev/null ; then
		yay -Rn meld
	else
		echo "Meld ist nicht installiert."
	fi
}

configure_kde() {
	# Installiere Icon Pack
	if yay -Qs papirus-icon-theme > /dev/null ; then
		echo "Papirus ist schon installiert."
	else
		yay -S papirus-icon-theme
	fi
	if yay -Qs papirus-folders-catppuccin-git > /dev/null ; then
		echo "papirus-folders-catppuccin-git ist schon installiert."
	else
		yay -S papirus-folders-catppuccin-git
	fi
	papirus-folders -t Papirus-Dark -C cat-mocha-lavender
	# KDE Konfig
	read -r -p "Möchtest du KDE per konsave einrichten? [J|N] " configresponse
	if [[ $configresponse =~ ^(j|Ja|J) ]]; then
		konsave_install
	else
    	catppuccin_manual_install
	fi
}

configure_sddm() {
	# Braucht man für SSDM catppuccin Theme
	if yay -Qs qt6-svg > /dev/null ; then
		echo "qt6-svg ist schon installiert."
	else
		yay -S qt6-svg
	fi
	if yay -Qs qt6-declarative > /dev/null ; then
		echo "qt6-declarative ist schon installiert."
	else
		yay -S qt6-declarative
	fi
	# Hole Theme
	echo "Downloade neuesten Catppuccin SDDM Release ..."
    if yay -Qs sddm-theme-catppuccin > /dev/null ; then
		echo "sddm-theme-catppuccin ist schon installiert."
	else
		yay -S sddm-theme-catppuccin
	fi
	# Erstelle Ordner für Konfig
	if ! [ -d "/etc/sddm.conf.d/" ]; then
		echo "Erstelle Ordner für SDDM Konfig"
		sudo mkdir "/etc/sddm.conf.d/"
	fi
	# Wenn Konfig bereits existiert ersetze alte konfig
	if ! [ -z "$(ls -A /etc/sddm.conf.d)" ]; then
		echo "Alte Konfig wird gelöscht und ersetzt"
		sudo rm /etc/sddm.conf.d/*
	fi
	echo "Erstelle Symlinks..."
	sudo ln -s -f "$HOME/.dotfiles/sddm/sddm.conf" "/etc/sddm.conf.d/"
	echo "Fertig."
}

konsave_install() {
	# Installiere konsave
	if yay -Qs konsave > /dev/null ; then
		echo "Konsave ist schon installiert."
	else
		yay -S konsave
	fi
	# Wende persönliche KDE Konfig an
	konsave -s backup
	konsave -i $HOME/.dotfiles/kde/konsave/profile/catppuccin-mocha-kde.knsv
	konsave -a catppuccin-mocha-kde
}

# Wird aktuell von konsave übernommen
catppuccin_manual_install() {
	# Installiere unzip (wird benötigt von Catppuccin Theme)
	if yay -Qs unzip > /dev/null ; then
		echo "unzip ist schon installiert."
	else
		yay -S unzip
	fi
	# Installiere Catppuccin KDE Theme
	git clone --depth=1 https://github.com/catppuccin/kde catppuccin-kde
	mv "$HOME/catppuccin-kde" "$HOME/Dokumente/catppuccin-kde"
	cd "$HOME/Dokumente/catppuccin-kde"
	./install.sh
	ln -s "$HOME/.local/share/icons/" "$HOME/.icons"
	cd
}

# Prüfe ob yay istalliert ist
ISYAY=/sbin/yay
if [ -f "$ISYAY" ]; then 
    echo -e "yay wurde gefunden, weiter geht's.\n"
    yay -Suy
else 
    echo -e "yay wurde nicht gefunden, bitte installiere yay.\n"
	# Wichtige Programme installieren
	read -r -p "Möchtest du versuchen yay zu installieren (experimentell)? [J|N] " configresponse
	if [[ $configresponse =~ ^(j|Ja|J) ]]; then
		sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
		cd
	else
		echo "yay wurde nicht installiert. Beende Script."
    	exit 
	fi
fi

# Wichtige Programme installieren
read -r -p "Möchtest du die wichtigsten Programme installieren? [J|N] " configresponse
if [[ $configresponse =~ ^(j|Ja|J) ]]; then
	install_basics
else
	echo "Die wichtigsten Programme werden nicht installiert."
fi

# Fonts installieren
read -r -p "Möchtest du Fonts installieren? [J|N] " configresponse
if [[ $configresponse =~ ^(j|Ja|J) ]]; then
	install_fonts
else
	echo "Fonts werden nicht installiert."
fi

# Standart Symlinks erstellen
read -r -p "Möchtest du die üblichen Symlinks erstellen (nur git und bashrc)? [J|N] " configresponse
if [[ $configresponse =~ ^(j|Ja|J) ]]; then
	create_basic_symlinks
else
	echo "Die Symlinks werden nicht erstellt."
fi

# Standard Programme installieren
read -r -p "Möchtest du die restlichen Programme installieren? [J|N] " configresponse
if [[ $configresponse =~ ^(j|Ja|J) ]]; then
	install_standard_packages
else
	echo "Die restlichen Programme werden nicht installiert."
fi

# Fonts installieren
read -r -p "Möchtest du unnütze Terminal-Screensaver installieren? [J|N] " configresponse
if [[ $configresponse =~ ^(j|Ja|J) ]]; then
	install_cli_fun
else
	echo "Terminal-Screensaver werden nicht installiert."
fi

# Wallpaper downloaden
read -r -p "Möchtest du Wallpaper downloaden und hinterlegen? [J|N] " configresponse
if [[ $configresponse =~ ^(j|Ja|J) ]]; then
	download_wallpapers
else
	echo "Wallpaper werden nicht gedownloaded und hinterlegt."
fi

# Ordner Strukturen einrichten
read -r -p "Möchtest du Ordner Strukturen erstellen? [J|N] " configresponse
if [[ $configresponse =~ ^(j|Ja|J) ]]; then
	make_directories
else
	echo "Ordner Strukturen werden nicht erstellt."
fi

# Falls bei der KDE Base Installation vergessen wurde die Bloat Programme auszuschließen
read -r -p "Möchtest du KDE Bloat entfernen? [J|N] " configresponse
if [[ $configresponse =~ ^(j|Ja|J) ]]; then
	delete_kde_bloat
else
	echo "KDE Bloat wird nicht entfernt."
fi

# SDDM einrichten
read -r -p "Möchtest du SDDM einrichten? [J|N] " configresponse
if [[ $configresponse =~ ^(j|Ja|J) ]]; then
	configure_sddm
else
	echo "SDDM wird nicht eingerichtet."
fi

# KDE einrichten
read -r -p "Möchtest du KDE einrichten? [J|N] " configresponse
if [[ $configresponse =~ ^(j|Ja|J) ]]; then
	configure_kde
else
	echo "KDE wird nicht eingerichtet."
fi

echo "Fertig."
