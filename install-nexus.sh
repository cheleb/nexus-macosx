if [ -e /Library/LaunchDaemons/limit.maxfiles.plist ]; then
  echo MaxFiles Ok
else
  echo Fixing maxfiles.
  sudo cp resources/limit.maxfiles.plist /Library/LaunchDaemons/
  sudo chown root:wheel /Library/LaunchDaemons/limit.maxfiles.plist
  sudo launchctl load -w /Library/LaunchDaemons/limit.maxfiles.plist
fi

if dscl . -list /Users/nexus; then
    echo 'Nexus user already exists, attempting to change the shell to /bin/bash'
    # Will fail if UserShell is not /usr/bin/false, but that's ok.
    # Then we will assume an admin has changed it.
else
  echo 'No nexus user found, creating nexus user and group'
  sudo dscl . -create /Groups/nexus
  sudo dscl . -create /Groups/nexus PrimaryGroupID 1000
  sudo dscl . -create /Users/nexus
  sudo dscl . -create /Users/nexus UserShell /bin/false
  sudo dscl . -create /Users/nexus RealName "Nexus OSS"
  sudo dscl . -create /Users/nexus UniqueID "1000"
  sudo dscl . -create /Users/nexus PrimaryGroupID 1000
fi

if [ -e /Library/LaunchDaemons/com.sonatype.nexus.plist ]; then
  echo Nexus service Ok
else
  echo Installing nexus launchctl.
  sudo cp resources/com.sonatype.nexus.plist /Library/LaunchDaemons/
  sudo chown root:wheel /Library/LaunchDaemons/com.sonatype.nexus.plist
  sudo launchctl load -w /Library/LaunchDaemons/com.sonatype.nexus.plist
fi


cp resources/repositories $HOME/.sbt/