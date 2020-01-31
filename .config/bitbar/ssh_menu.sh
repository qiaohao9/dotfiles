#!/bin/bash

# <bitbar.title>SSH Menu</bitbar.title>
# <bitbar.version>v0.1</bitbar.version>
# <bitbar.author>tinyRat</bitbar.author>
# <bitbar.author.github>tinyRatP</bitbar.author.github>
# <bitbar.desc>SSH host quickly</bitbar.desc>
# <bitbar.image>http://www.hosted-somewhere/pluginimage</bitbar.image>
# <bitbar.dependencies>bash</bitbar.dependencies>
# <bitbar.abouturl>https://github.com/tinyRatP/Bitbar-Plugins</bitbar.abouturl>

echo "SSH"
echo "---"

# If you need ssh other hosts not only from `.ssh/config`
# Replace ${ServerName}
# echo "Hosts from custom | color=red"
# echo "ServerName | bash='ssh ServerName'"

echo "---"

echo "Hosts from config | color=green"
awk '/Host / { for(i=2;i<=NF;i++) host=$i; printf "%s | bash=\"ssh %s\"\n", host, host }' "${HOME}"/.ssh/config
