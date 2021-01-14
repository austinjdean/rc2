#!/bin/bash

# ==========
# install.sh
# ==========

userName=$(sudo whoami)

if [[ "$userName" = "root" ]]; then
	# continue
	:
else
	echo "[x] Best learn that root password first."
	exit 69
fi

repo_name="rc2"
git_dir="$HOME/git"
package_dir="$git_dir/$repo_name/nice_package"
repo_programs="zsh vim guake sublime-text xclip nmap dconf-cli jq"
default_directories="Desktop Documents Downloads Music Pictures Public Templates Videos"

# Add Sublime to repos and update apt sources
# ===========================================
echo "[i] Adding Sublime Text to repos..."

# Install the GPG key:
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -

# Ensure apt is set up to work with https sources:
sudo apt-get install -y apt-transport-https

# Select the channel to use (Stable):
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

# Update apt sources:
sudo apt-get update
echo "[+] Done."

# Install from apt
# ================
echo "[i] Installing programs from apt..."

sudo apt-get install -y --ignore-missing $repo_programs
# no quotes so that string is split on spaces
# fault tolerant if a package can't be found for some reason
echo "[+] Done."

# Relocate default directories
# ============================
echo "[i] Relocating default directories..."

for dir in $default_directories; do
	echo "[i] Creating new directory: $dir..."
	mkdir -p $HOME/defaults/$dir
	echo "[i] Moving contents of $dir..."
	mv $HOME/$dir/* $HOME/defaults/$dir
	echo "[i] Removing default directory: $dir..."
	rm -rf $HOME/$dir
done

echo "[i] Overwriting ~/.config/user-dirs.dirs to reflect changes..."
cp "$package_dir/lib/modified-user-dirs.dirs" "$HOME/.config/user-dirs.dirs"
echo "[+] Done."

# Create symlinks to configs and such
# ===================================
echo "[i] Creating zshrc symlink..."
ln -si "$package_dir/config/zshrc" "$HOME/.zshrc"

echo "[i] Setting up Sublime config..."
# ensure sublime directory exists
mkdir -p "$HOME/.config/sublime-text-3/Packages"
rm -rf "$HOME/.config/sublime-text-3/Packages/User"
ln -siT "$package_dir/sublime" "$HOME/.config/sublime-text-3/Packages/User"

echo "[i] Setting up Guake config..."
guake --restore-preferences "$package_dir/config/guake.conf"

echo "[i] Creating symlinks to utility scripts..."
# lns
sudo ln -si "$package_dir/scripts/lns.sh" "/usr/local/bin/lns"
# repo status
sudo ln -si "$package_dir/scripts/status.sh" "/usr/local/bin/rs"
# repo update
sudo ln -si "$package_dir/scripts/update.sh" "/usr/local/bin/ru"
echo "[+] Done."
echo
echo "[i] Possible remaining tasks:"
echo "[i]  - chsh to zsh"
echo "[i]  - install chrome"
echo "[i]  - install pls"
echo "[i]  - add guake to startup programs"
echo
echo "[+] Initialization complete. Reboot is recommended."
