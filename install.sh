# Assumptions are made that the dotfiles directory is residing under $HOME, in order to provide relative symlinks
if [[ -z "$(readlink -f $0 | grep $HOME)" ]]; then
	echo "$(readlink -f $0) must reside under $HOME"
	exit 1
fi

command_exists () {
	type "$1" &> /dev/null ;
}

# Check for binaries on PATH that are required for installation of plugins
if	   ! command_exists git \
	|| ! command_exists vim \
	|| ! command_exists pip
then
	echo "Install git, vim and pip, then re-execute this script"
	exit 1
fi

DOTFILESDIR=$(dirname $(readlink -f $0) | sed -e s,$HOME/,, )
MAPFILE=$HOME/$DOTFILESDIR/install.mapping

# cd to $HOME so that we can create relative symlinks
pushd $HOME > /dev/null

# Iterate over the mappings in the mapping file
for kv in $(cat $MAPFILE); do
	# Split the two parts between the colon into SOURCE and DEST
	IFS=":" read -ra MAP <<< "$kv"
	SOURCE=${MAP[0]}
	DEST=${MAP[1]}

	# Check to see if there's already a symlink between the destination and source paths
	if [ "$(readlink -e $HOME/$DEST)" != "$HOME/$DOTFILESDIR/$SOURCE" ]; then
		# If not, create a relative symlink, backing up any old file with the same name
		ln -b -s $DOTFILESDIR/$SOURCE $DEST
	fi
done

popd > /dev/null

# Check out all git submodules
pushd $HOME/$DOTFILESDIR > /dev/null
git submodule update --init --recursive

# If we haven't already cloned vundle, then do it now
if [[ ! -d $DOTFILESDIR/vim/bundle/vundle/.git ]]; then
	git clone https://github.com/gmarik/vundle.git vim/bundle/vundle
fi

vim +BundleInstall! +qall
popd > /dev/null

# Build vimproc library
cd vim/bundle/vimproc > /dev/null
make
popd > /dev/null

echo "If this is the first time running this script, then start a new shell"
