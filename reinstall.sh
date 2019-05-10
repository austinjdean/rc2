#!/bin/bash

# ==========
# refresh.sh
# ==========

sudo whoami > /dev/null 2>&1
return_value=$?

if [ "$return_value" -ne 0 ]; then
	echo "[x] Best learn that root password first." 
	exit 1
fi

repo_name="rc2"
git_dir="$HOME/git"
package_dir="$git_dir/$repo_name/nice_package"

bash "$git_dir/$repo_name/clean.sh"
bash "$git_dir/$repo_name/install.sh"
