# icon-rollbacker (OS X only) <img src ="https://raw.githubusercontent.com/Phoenixx19/icon-rollbacker/main/icon.png" width="80px" alt="logo" align ="right">

Rollback or change icons of your apps from a simple folder.

## Why? 
I made this because I highly dislike the new Big Sur app icons and it's also an hassle to change all app icons. So I sped up the process with this!

<img alt="Screenshot1" src="./Screenshot%202021-06-06%20at%2019.10.58.png" />

### Installation
1. Git clone this.
2. Change `FOLDER` on line 1 or create a folder **backup_icons** in Documents, storing your icons.
3. Open Terminal, cd in the directory where icon-rollbacker is.
4. `./icon-rollbacker.sh` to start it.
5. Done!

### Usage
Inside of the folder specified you will need to place the .icns file named as the Application you want to change.

### Compatibility
Tested on the latest version of OS X Catalina. Should work on earlier OS X versions too, not sure about the Big Sur app icons limitations.

### Known issues
- Adobe and Office programs are known to not work with this shell script. <br>[__Workaround to get the icons working.__](./WORKAROUND.md)

### License
GPL, I guess. 🤷
