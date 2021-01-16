As root:
```bash
dscl . -create /Groups/nexus
dscl . -create /Groups/nexus PrimaryGroupID 1000

dscl . -create /Users/nexus
dscl . -create /Users/nexus UserShell /bin/false
dscl . -create /Users/nexus RealName "Nexus OSS"
dscl . -create /Users/nexus UniqueID "1000"
dscl . -create /Users/nexus PrimaryGroupID 1000
```


# References 

[Create nexus user from command line](https://jamesmead.org/blog/2011-01-20-adding-a-user-in-osx-on-command-line)