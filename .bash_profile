# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

 source ~/.sdkman/bin/sdkman-init.sh

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
BREW_PREFIX=$(brew --prefix)
if command -v brew &> /dev/null 2>&1; then
	if [ -f "$BREW_PREFIX//share/bash-completion/bash_completion" ]; then
		source "$BREW_PREFIX/share/bash-completion/bash_completion";
	elif [ -f /etc/bash_completion ]; then
		source /etc/bash_completion;
	fi
	if [ -f $BREW_PREFIX/etc/profile.d/z.sh ]; then
		source $BREW_PREFIX/etc/profile.d/z.sh
	fi
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g;
fi;


# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;

#Load rbenv
eval "$(rbenv init -)"

java_home 8

#Use MACOS ssh-add to add all keys from Keychain
/usr/bin/ssh-add -A

export AWS_KEYCHAIN_FILE="$HOME/Library/Keychains/aws-keychain.keychain-db" #temp work around
export MAVEN_OPTS="-Djava.awt.headless=true -XX:+TieredCompilation -XX:TieredStopAtLevel=1"
