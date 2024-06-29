#!/bin/bash

install_basics() {
	yay --save --answerclean N --answerdiff N
	if yay -Qs kitty > /dev/null ; then
		echo "Kitty ist schon installiert."
	else
		yay -S kitty
	fi
	configure_kitty
	if yay -Qs neofetch > /dev/null ; then
		echo "Neofetch ist schon installiert."
	else
		yay -S neofetch
	fi
	configure_neofetch
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
	configure_vscode
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
	if yay -Qs cava > /dev/null ; then
		echo "cava ist schon installiert."
	else
		yay -S cava
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
	if yay -Qs ttf-jetbrains-mono > /dev/null ; then
		echo "JetBrains Font ist schon installiert."
	else
		yay -S ttf-jetbrains-mono
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

configure_vscode() {
	install_vs_code_extensions
	if [ -f "$HOME/.config/Code - OSS/User/settings.json" ]; then
		rm "$HOME/.config/Code - OSS/User/settings.json"
	fi
	if [ -f "$HOME/.config/Code - OSS/User/keybindings.json" ]; then
		rm "$HOME/.config/Code - OSS/User/keybindings.json"
	fi
	ln -s "$HOME/.dotfiles/.config/Code - OSS/User/settings.json" "$HOME/.config/Code - OSS/User/settings.json"
	ln -s "$HOME/.dotfiles/.config/Code - OSS/User/keybindings.json" "$HOME/.config/Code - OSS/User/keybindings.json"
}

configure_kitty() {
	if ! [ -d "$HOME/.config/kitty" ]; then
		mkdir "$HOME/.config/kitty"
	fi
	if [ -f "$HOME/.config/kitty/kitty.conf" ]; then
		rm "$HOME/.config/kitty/kitty.conf"
	fi
	ln -s "$HOME/.dotfiles/.config/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
}

configure_neofetch() {
	if ! [ -d "$HOME/.config/neofetch" ]; then
		mkdir "$HOME/.config/neofetch"
	fi
	if [ -f "$HOME/.config/neofetch/config.conf" ]; then
		rm "$HOME/.config/neofetch/config.conf"
	fi
	ln -s "$HOME/.dotfiles/.config/neofetch/config.conf" "$HOME/.config/neofetch/config.conf"
}

configure_btop() {
	if ! [ -d "$HOME/.config/btop" ]; then
		mkdir "$HOME/.config/btop"
	fi
	if ! [ -d "$HOME/.config/btop/themes" ]; then
		mkdir "$HOME/.config/btop/themes"
	fi
	ln -s "$HOME/.dotfiles/.config/btop/themes/catppuccin_mocha.theme" "$HOME/.config/btop/themes/catppuccin_mocha.theme"
}

create_basic_symlinks() {
	# Git
	if [ -f "$HOME/.gitconfig" ]; then
		rm "$HOME/.gitconfig"
	fi
	ln -s "$HOME/.dotfiles/.gitconfig" "$HOME/.gitconfig"
	# Bash
	if [ -f "$HOME/.bashrc" ]; then
		rm "$HOME/.bashrc"
	fi
	ln -s "$HOME/.dotfiles/.bashrc" "$HOME/.bashrc"
}

configure_spotify() {
	# Spotify vorbereiten
	sudo chmod a+wr /opt/spotify
	sudo chmod a+wr /opt/spotify/Apps -R
	# Theme installieren
	install_spicetify_text_catppuccin
	# Erstelle Symlinks
	if [ -f "$HOME/.config/spicetify/config-xpui.ini" ]; then
		rm "$HOME/.config/spicetify/config-xpui.ini"
	fi
	ln -s "$HOME/.dotfiles/.config/spicetify/config-xpui.ini" "$HOME/.config/spicetify/config-xpui.ini"
	if [ -f "$HOME/.config/spicetify/Themes/text/color.ini" ]; then
		rm "$HOME/.config/spicetify/Themes/text/color.ini"
	fi
	ln -s "$HOME/.dotfiles/.config/spicetify/Themes/text/color.ini" "$HOME/.config/spicetify/Themes/text/color.ini"
	if [ -f "$HOME/.config/spicetify/Themes/text/user.css" ]; then
		rm "$HOME/.config/spicetify/Themes/text/user.css"
	fi
	ln -s "$HOME/.dotfiles/.config/spicetify/Themes/text/user.css" "$HOME/.config/spicetify/Themes/text/user.css"
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
	if [ -f "$HOME/.config/BetterDiscord/data/stable/custom.css" ]; then
		rm "$HOME/.config/BetterDiscord/data/stable/custom.css"
	fi
	ln -s "$HOME/.dotfiles/.config/BetterDiscord/data/stable/custom.css" "$HOME/.config/BetterDiscord/data/stable/custom.css"
}

download_wallpapers() {
	git clone https://github.com/zhichaoh/catppuccin-wallpapers.git catppuccin-wallpapers
	mkdir "$HOME/Bilder/wallpapers"
	mv "$HOME/catppuccin-wallpapers" "$HOME/Bilder/wallpapers"
}

make_directories() {
	if [ -f "$HOME/workspace" ]; then
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
	# Braucht man später für SSDM catppuccin Theme
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

# Depricated
catppuccin_manual_install() {
	# Braucht man später für SSDM catppuccin Theme
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
	# Installiere catppuccin KDE Theme
	git clone --depth=1 https://github.com/catppuccin/kde catppuccin-kde
	mv "$HOME/catppuccin-kde $HOME/Dokumente/catppuccin-kde"
	cd "$HOME/Dokumente/catppuccin-kde"
	./install.sh
	ln -s "$HOME/.local/share/icons/" "$HOME/.icons"
}

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
read -r -p "Möchtest du die üblichen Symlinks erstellen? [J|N] " configresponse
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

# Spotify einrichten
read -r -p "Möchtest du Spicetify einrichten? [J|N] " configresponse
if [[ $configresponse =~ ^(j|Ja|J) ]]; then
	configure_spotify
else
	echo "Spicetify wird nicht eingerichtet."
fi

# Discord einrichten
read -r -p "Möchtest du BetterDiscord einrichten? [J|N] " configresponse
if [[ $configresponse =~ ^(j|Ja|J) ]]; then
	configure_discord
else
	echo "BetterDiscord wird nicht eingerichtet."
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

# Ordner Strukturen einrichten
read -r -p "Möchtest du KDE Bloat entfernen? [J|N] " configresponse
if [[ $configresponse =~ ^(j|Ja|J) ]]; then
	delete_kde_bloat
else
	echo "KDE Bloat wird nicht entfernt."
fi


# KDE einrichten
read -r -p "Möchtest du KDE einrichten? [J|N] " configresponse
if [[ $configresponse =~ ^(j|Ja|J) ]]; then
	configure_kde
else
	echo "KDE wird nicht eingerichtet."
fi

echo "Fertig."