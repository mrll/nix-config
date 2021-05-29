#! /usr/bin/env nix-shell
#! nix-shell -i bash -p curl jq unzip
set -eu -o pipefail

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
NIX_FILE="${SCRIPTPATH}/extensions.nix"

# Helper to just fail with a message and non-zero exit code.
function fail() {
    echo "$1" >&2
    exit 1
}

function get_vsixpkg() {
    N="$1.$2"

    echo 'Getting extension: name = "'$2'"; publisher = "'$1'"'
    # Create a tempdir for the extension download
    EXTTMP=$(mktemp -d -t vscode_exts_XXXXXXXX)

    URL="https://$1.gallery.vsassets.io/_apis/public/gallery/publisher/$1/extension/$2/latest/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage"

    # Quietly but delicately curl down the file, blowing up at the first sign of trouble.
    curl --silent --show-error --fail -X GET -o "$EXTTMP/$N.zip" "$URL"
    # Unpack the file we need to stdout then pull out the version
    VER=$(jq -r '.version' <(unzip -qc "$EXTTMP/$N.zip" "extension/package.json"))
    # Calculate the SHA
    SHA=$(nix-hash --flat --base32 --type sha256 "$EXTTMP/$N.zip")

    echo '{name = "'$2'"; publisher = "'$1'"; version = "'$VER'"; sha256 = "'$SHA'";}' >> ${NIX_FILE}
}

CODE=$(command -v code)

if [ -z "$CODE" ]; then
    # Not much point continuing.
    fail "VSCode executable not found"
fi

# Begin the printing of the nix expression that will house the list of extensions.
# Note that we are only looking to update extensions that are already installed.
printf '[\n' > ${NIX_FILE}
for i in $($CODE --list-extensions)
do
    OWNER=$(echo "$i" | cut -d. -f1)
    EXT=$(echo "$i" | cut -d. -f2)

    get_vsixpkg "$OWNER" "$EXT"
done
printf ']' >> ${NIX_FILE}

nixpkgs-fmt ${NIX_FILE}
