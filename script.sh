#!/bin/bash

if [ -d "/Volumes/Macintosh HD - Data" ]; then
  diskutil rename "Macintosh HD - Data" "Data"
fi

echo -e "Create a new user"
echo -e "Press Enter to move to the next step, if not filled in, it will automatically receive the default value"
echo -e "Enter Real Name (Default: MAC)"

read realName
realName="${realName:=MAC}"
echo -e "Enter Username (Default: MAC)"

read username
username="${username:=MAC}"
echo -e "Enter password (default: 1234)"

read passw
passw="${passw:=1234}"

echo -e "Creating users"
dscl_path='/Volumes/Macintosh HD - Data/private/var/db/dslocal/nodes/Default'

# Create user
dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username"
dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" UserShell "/bin/zsh"
dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" RealName "$realName"
dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" RealName "$realName"
dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" UniqueID "501"
dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" PrimaryGroupID "20"
mkdir "/Volumes/Data/Users/$username"
dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" NFSHomeDirectory "/Users/$username"
dscl -f "$dscl_path" localhost -passwd "/Local/Default/Users/$username" "$passw"
dscl -f "$dscl_path" localhost -append "/Local/Default/Groups/admin" GroupMembership "$username"
