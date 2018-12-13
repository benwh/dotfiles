set -o nounset
set -o errexit

if [[ "$(uname)" == "Darwin" ]]; then
	READLINK=greadlink
	LN=gln
else
	READLINK=readlink
	LN=ln
fi

# Assumptions are made that the dotfiles directory is residing under $HOME, in order to provide
# relative symlinks
if [[ -z "$($READLINK -f $0 | grep $HOME)" ]]; then
	echo "$($READLINK -f $0) must reside under $HOME"
	exit 1
fi

command_exists () {
	type "$1" &> /dev/null ;
}

# Check for binaries on PATH that are required for installation of plugins
if	!			command_exists git \
		||	! command_exists vim
then
	echo "Install git and vim, then re-execute this script"
	exit 1
fi

DOTFILESDIR="$(dirname $($READLINK -f $0) | sed -e s,$HOME/,, )"
MAPFILE=$HOME/$DOTFILESDIR/install.mapping

# Check out all git submodules
pushd "$HOME/$DOTFILESDIR" > /dev/null
git submodule update --init --recursive

# cd to $HOME so that we can create relative symlinks
pushd "$HOME" > /dev/null

# Add some standard directories
mkdir -p ~/bin/
mkdir -p ~/.config/nvim/

# Iterate over the mappings in the mapping file
for kv in $(cat $MAPFILE); do
	# Split the two parts between the colon into SOURCE and DEST
	IFS=":" read -ra MAP <<< "$kv"
	SOURCE=${MAP[0]}
	DEST=${MAP[1]}

	# Check to see if there's already a symlink between the destination and source paths
	if [ "$($READLINK -e $HOME/$DEST)" != "$HOME/$DOTFILESDIR/$SOURCE" ]; then
		# If not, create a relative symlink, backing up any old file with the same name
		$LN -b -s -r "$DOTFILESDIR/$SOURCE" "$DEST"
	fi
done

popd > /dev/null

# Install vim plugins
vim +PlugInstall! +qall

echo "If this is the first time running this script, then start a new shell"
