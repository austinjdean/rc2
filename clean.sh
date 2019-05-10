#!/bin/bash

# ========
# clean.sh
# ========

sudo whoami > /dev/null 2>&1
return_value=$?

if [ "$return_value" -ne 0 ]; then
	echo "[x] Best learn that root password first." 
	exit 1
fi

repo_name="rc2"
git_dir="$HOME/git"
package_dir="$git_dir/$repo_name/nice_package"

# Remove symlinks to config files
# ===============================
echo "[i] Removing zshrc symlink..."
rm -f "$HOME/.zshrc"

echo "[i] Removing Sublime config..."
rm -f "$HOME/.config/sublime-text-3/Packages/User"

echo "[i] Removing symlinks to utility scripts..."
# lns
sudo rm -f "/usr/local/bin/lns"
# repo status
sudo rm -f "/usr/local/bin/rs"
# repo update
sudo rm -f "/usr/local/bin/ru"
echo "[+] Done."
