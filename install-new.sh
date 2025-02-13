#!/bin/bash

install_package() {
  local package="$1"

  # Ausnahme für "code": Installiere es immer, da aus irgendeinem Grund nicht erkannt wird dass es noch nicht installiert ist
  if [[ "$package" == "code" ]]; then
    echo "Installiere $package..."
    yay -S --save --answerclean N --answerdiff N "$package" || { echo "Fehler bei der Installation von $package" >&2; return 1; }
  elif ! yay -Qs "$package" > /dev/null 2>&1; then
    echo "Installiere $package..."
    yay -S --save --answerclean N --answerdiff N "$package" || { echo "Fehler bei der Installation von $package" >&2; return 1; }
  else
    echo "$package ist bereits installiert."
  fi

  local config_function="configure_${package//-/_}"
  if [[ -n "$(command -v "$config_function")" ]]; then
    read -r -p "Möchtest du $package einrichten? [J|N] " configresponse
    if [[ "$configresponse" =~ ^(j|Ja|J)$ ]]; then
      "$config_function" || { echo "Fehler bei der Konfiguration von $package" >&2; return 1; }
    else
      echo "$package wird nicht eingerichtet."
    fi
  fi
}

install_basics() {
  local packages=(
    kitty
    fastfetch
    btop
    code
    firefox
    vim
    neovim
    vim-plug
  )

  for package in "${packages[@]}"; do
    install_package "$package" || return 1 # Fehlerbehandlung: Wenn die Installation eines Pakets fehlschlägt, wird die Funktion beendet.
  done
}

install_standard_packages() {
  local packages=(
    cava
	tickrs
	ticker
    spotify
    spicetify-cli
    discord
    betterdiscordctl
    proton-vpn-gtk-app
    foliate
    remmina
    freerdp
    pinta
    bitwarden
    geckodriver
    thunderbird
    pycharm-community-edition
    android-studio
    libreoffice-still
    libreoffice-still-de
    virtualbox
    virtualbox-guest-iso
    virtualbox-host-dkms
	lmstudio
  )

  for package in "${packages[@]}"; do
    install_package "$package" || return 1 # Fehlerbehandlung: Wenn die Installation eines Pakets fehlschlägt, wird die Funktion beendet.
  done
}

install_fonts() {
  local packages=(
    ttf-roboto
    ttf-jetbrains-mono-nerd
  )

  for package in "${packages[@]}"; do
    install_package "$package" || return 1
  done
}

install_cli_fun() {
  local packages=(
    pipes.sh
    cbonsai
    rainfall
  )

  for package in "${packages[@]}"; do
    install_package "$package" || return 1
  done
}

install_vs_code_extensions() {
  local extensions=(
    aaron-bond.better-comments
    catppuccin.catppuccin-vsc
    catppuccin.catppuccin-vsc-icons
    donjayamanne.githistory
    esbenp.prettier-vscode
    mechatroner.rainbow-csv
    ms-ceintl.vscode-language-pack-de
    ms-python.debugpy
    ms-python.python
    naumovs.color-highlight
    yzhang.markdown-all-in-one
  )

  for extension in "${extensions[@]}"; do
    echo "Installiere VS Code Extension: $extension"
    code --install-extension "$extension" || { echo "Fehler bei der Installation von $extension" >&2; return 1; }
  done
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

configure_code() {
	install_vs_code_extensions
	echo "Erstelle Symlinks..."
	ln -s -f "$HOME/.dotfiles/.config/Code - OSS/User/settings.json" "$HOME/.config/Code - OSS/User/settings.json"
	ln -s -f "$HOME/.dotfiles/.config/Code - OSS/User/keybindings.json" "$HOME/.config/Code - OSS/User/keybindings.json"
	echo "Fertig."
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

configure_kde() {
  local icon_packages=(
    papirus-icon-theme
    papirus-folders-catppuccin-git
  )

  # Installiere Icon Packs
  for package in "${icon_packages[@]}"; do
    install_package "$package" || return 1
  done

  # Konfiguriere Ordnerfarben (mit Fehlerprüfung)
  echo "Setze Ordnerfarben mit papirus-folders..."
  papirus-folders -t Papirus-Dark -C cat-mocha-lavender || { echo "Fehler bei der Konfiguration der Ordnerfarben" >&2; return 1; }

  # KDE Konfiguration
  read -r -p "Möchtest du KDE per Konsave einrichten? [J|N] " configresponse
  if [[ "$configresponse" =~ ^(j|Ja|J)$ ]]; then
    konsave_install || return 1 # Fehlerbehandlung hinzufügen
  else
    catppuccin_manual_install || return 1 # Fehlerbehandlung hinzufügen
  fi

  echo "KDE Konfiguration abgeschlossen."
}

configure_kitty() {
	echo "Erstelle Symlinks..."
	if ! [ -d "$HOME/.config/kitty" ]; then
		mkdir "$HOME/.config/kitty"
	fi
	ln -s -f "$HOME/.dotfiles/.config/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
	echo "Fertig."
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

configure_sddm() {
  local sddm_config_dir="/etc/sddm.conf.d/"
  local sddm_config_file="$sddm_config_dir/sddm.conf"
  local sddm_theme_package="sddm-theme-catppuccin"

  # Installiere benötigte Pakete
  install_package qt6-svg || return 1
  install_package qt6-declarative || return 1
  install_package "$sddm_theme_package" || return 1

  # Erstelle Konfigurationsordner, falls er nicht existiert
  if [[ ! -d "$sddm_config_dir" ]]; then
    echo "Erstelle Ordner für SDDM Konfig: $sddm_config_dir"
    sudo mkdir -p "$sddm_config_dir" || { echo "Fehler beim Erstellen des Ordners" >&2; return 1; } # -p erstellt bei Bedarf übergeordnete Ordner
  fi

  # Lösche vorhandene Konfigurationen (optional, aber sicherer)
  if [[ -n "$(ls -A "$sddm_config_dir")" ]]; then
    echo "Alte Konfig wird gelöscht: $sddm_config_dir/*"
    sudo rm -f "$sddm_config_dir/*" || { echo "Fehler beim Löschen der alten Konfiguration" >&2; return 1; } # -f erzwingt das Löschen
  fi

  # Symlink erstellen (mit Fehlerprüfung)
  echo "Erstelle Symlink: $HOME/.dotfiles/sddm/sddm.conf -> $sddm_config_file"
  sudo ln -sf "$HOME/.dotfiles/sddm/sddm.conf" "$sddm_config_file" || { echo "Fehler beim Erstellen des Symlinks" >&2; return 1; } # -s erstellt symbolischen Link, -f erzwingt das Ersetzen

  echo "SDDM Konfiguration abgeschlossen."
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

configure_ticker() {
	echo "Erstelle Symlinks..."
	if ! [ -d "$HOME/.config/ticker" ]; then
		mkdir "$HOME/.config/ticker"
	fi
	# ln -s -f "$HOME/.dotfiles/.config/ticker/.ticker.yaml" "$HOME/.config/ticker/.ticker.yaml"
	cp "$HOME/.dotfiles/.config/ticker/.ticker.yaml" "$HOME/.config/ticker/"
	echo "Fertig."
}

configure_tickrs() {
	echo "Erstelle Symlinks..."
	if ! [ -d "$HOME/.config/tickrs" ]; then
		mkdir "$HOME/.config/tickrs"
	fi
	ln -s -f "$HOME/.dotfiles/.config/tickrs/config.yml" "$HOME/.config/tickrs/config.yml"
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

colorize_pacman() {
  # Pfad zur pacman.conf-Datei
  local pacman_conf="/etc/pacman.conf"

  # Überprüfen, ob die Datei existiert
  if [[ ! -f "$pacman_conf" ]]; then
    echo "Fehler: $pacman_conf nicht gefunden." >&2
    return 1
  fi

  # Überprüfen, ob 'Color' bereits aktiviert ist
  if grep -q "^Color" "$pacman_conf"; then
    echo "Farbe in $pacman_conf ist bereits aktiviert."
    return 0
  fi

  # Zeile mit '#Color' suchen und ersetzen
  if sudo sed -i 's/^#Color/Color/' "$pacman_conf"; then
    echo "Farbe in $pacman_conf erfolgreich aktiviert."
    return 0
  else
    echo "Fehler: Farbe in $pacman_conf konnte nicht aktiviert werden." >&2
    return 1
  fi
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

# Pacman Farben verpassen
read -r -p "Möchtest du pacman Farben verpassen? [J|N] " configresponse
if [[ $configresponse =~ ^(j|Ja|J) ]]; then
	colorize_pacman
else
	echo "pacman bleibt langweilig."
fi

echo "Fertig."
