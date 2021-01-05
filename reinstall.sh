#!/bin/bash

# ==========
# refresh.sh
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

bash "$git_dir/$repo_name/clean.sh"
bash "$git_dir/$repo_name/install.sh"
