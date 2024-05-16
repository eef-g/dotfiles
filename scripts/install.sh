echo "Installing dependencies"

PKGS=("1" "2" "3")

# This will be a loop to go through all of the needed dependencies
for PKG in ${PKGS[@]}; do
	echo "$PKG"
done
