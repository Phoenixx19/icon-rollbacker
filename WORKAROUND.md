## Workaround for
- Adobe programs (.app inside another folder)
- Office programs (chmod issues?)
- Other

---

1. Find the Info.plist file inside the Package Contents on the Application (right-click app and Show Package Contents). It should be inside: `APPNAME.app/Contents`.

2. Search for in the Info.plist file:
```plist
    <key>CFBundleIconFile</key>
    <string>NAMEFILE.icns</string>
```
2. Get the string value below **CFBundleIconFile** (so in this case, NAMEFILE.icns)

3. Once you get the string value, you want to rename your **NEW** .icns file with the name you just found.

4. Navigate inside /Resources and overwrite the OLD .icns icon with the NEW version.

    4a. If asked, provide the credentials to replace the new icon.

5. Open Terminal and write `touch /Applications/APPNAME.app`.

    5a. If it doesn't end well, try putting `sudo` before `touch`.

6. Write `sudo killall Finder` and `sudo killall Dock` to refresh both the finder and the dock icons.

Done!