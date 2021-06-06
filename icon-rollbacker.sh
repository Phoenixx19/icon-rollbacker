FOLDER=/Users/$(whoami)/Documents/backup_icons
CURRENTFOLDER=$PWD

# Read a single char from /dev/tty, prompting with "$*"
# Note: pressing enter will return a null string. Perhaps a version terminated with X and then remove it in caller?
# See https://unix.stackexchange.com/a/367880/143394 for dealing with multi-byte, etc.
function get_keypress {
  local REPLY IFS=
  >/dev/tty printf '%s' "$*"
  [[ $ZSH_VERSION ]] && read -rk1  # Use -u0 to read from STDIN
  # See https://unix.stackexchange.com/q/383197/143394 regarding '\n' -> ''
  [[ $BASH_VERSION ]] && </dev/tty read -rn1
  printf '%s' "$REPLY"
}

# Get a y/n from the user, return yes=0, no=1 enter=$2
# Prompt using $1.
# If set, return $2 on pressing enter, useful for cancel or defualting
function get_yes_keypress {
  local prompt="${1:-Are you sure}"
  local enter_return=$2
  local REPLY
  # [[ ! $prompt ]] && prompt="[y/n]? "
  while REPLY=$(get_keypress "$prompt"); do
    [[ $REPLY ]] && printf '\n' # $REPLY blank if user presses enter
    case "$REPLY" in
      Y|y)  return 0;;
      N|n)  return 1;;
      '')   [[ $enter_return ]] && return "$enter_return"
    esac
  done
}

# Prompt to confirm, defaulting to YES on <enter>
function confirm_yes {
  local prompt="${*:-Are you sure} [Y/n]? "
  get_yes_keypress "$prompt" 0
}

function astolfo {
    echo ""
    input="$FOLDER/app-list.txt"
    while IFS= read -r line
        do
            local currenticon="$line.icns"
            local currentapp="$line.app"
            echo "[$currentapp] Rollbacking from old icon..."
            local iconfile=`defaults read /Applications/"$currentapp"/Contents/Info CFBundleIconFile`
            sudo cp -v "$FOLDER/$currenticon" "/Applications/$currentapp/Contents/Resources/$iconfile"
            echo "[$currentapp] Finalizing..."
            touch "/Applications/$currentapp"
            echo "[$currentapp] Refreshing app..."
            killall "$line" || echo "[$currentapp] No need to refresh, app is already off."

    done < "$input"
    echo "\nRestarting Dock and Finder..."
    sudo killall Dock && sudo killall Finder
    echo "Done."
    return 1;
}


# actual echo
cd $FOLDER
ls -d *.icns > icon-list.txt
sed 's/.icns//' icon-list.txt > app-list.txt
cd $CURRENTFOLDER
echo "
 icon-rollbacker by phxx19
  Rollback or change icons of your apps from a simple folder.

 ---

Current icon folder (on line 1 in icon-rollbacker.sh):
$FOLDER"

echo "\nIcons in folder:"
cat $FOLDER/icon-list.txt
echo "\nWarning! This could force shutdown some apps."
confirm_yes "Proceed with the revert?" && astolfo
rm $FOLDER/icon-list.txt
rm $FOLDER/app-list.txt