#!/bin/bash

# --- CONFIGURATION ---
DB_FILE="$HOME/.vault_db"
BASH_RC="$HOME/.bashrc"
DEV="123Tool"

# --- UI COLORS ---
C='\033[0,36m'
G='\033[0,32m'
R='\033[0,31m'
Y='\033[1,33m'
NC='\033[0m'

_banner() {
    clear
    echo -e "${C}"
    cat << "EOF"
     _______  _______  _______  _______ 
    |       ||   _   ||       ||       |
    |    ___||  |_|  ||_     _||    ___|
    |   | __ |       |  |   |  |   |___ 
    |   ||  ||       |  |   |  |    ___|
    |   |_| ||   _   |  |   |  |   |___ 
    |_______||__| |__|  |___|  |_______|
           TERMINAL GATEKEEPER
EOF
    echo -e "      [ System Security by $DEV ]"
    echo -e "----------------------------------------${NC}"
}

_init_db() {
    if [ ! -f "$DB_FILE" ]; then
        echo -e "${Y}[!] No account found. Directing to Registration...${NC}"
        _register
    fi
}

_register() {
    echo -e "${G}[ REGISTRATION MODE ]${NC}"
    read -p "Create Username: " new_user
    read -s -p "Create Password: " new_pass
    echo ""
    read -p "Create Security Key (for Recovery): " s_key
    
    # Simpan dengan format simple (user:pass:key)
    echo "$new_user:$new_pass:$s_key" > "$DB_FILE"
    echo -e "${G}[+] Account created successfully!${NC}"
    sleep 2
    _login
}

_recovery() {
    echo -e "\n${Y}[ RECOVERY MODE ]${NC}"
    read -p "Enter your Security Key: " input_key
    stored_key=$(cut -d: -f3 "$DB_FILE")
    
    if [[ "$input_key" == "$stored_key" ]]; then
        stored_user=$(cut -d: -f3 "$DB_FILE")
        stored_pass=$(cut -d: -f2 "$DB_FILE")
        echo -e "${G}[+] Access Granted!${NC}"
        echo -e "Your Username: $stored_user"
        echo -e "Your Password: $stored_pass"
        echo -e "\nPress Enter to login..."
        read
        _login
    else
        echo -e "${R}[!] Invalid Key. Closing terminal...${NC}"
        exit 1
    fi
}

_remove_lock() {
    echo -e "\n${R}[ REMOVE SYSTEM ]${NC}"
    read -s -p "Enter Admin Password to uninstall: " check_p
    stored_pass=$(cut -d: -f2 "$DB_FILE")
    
    if [[ "$check_p" == "$stored_pass" ]]; then
        sed -i "/vault-lock.sh/d" "$BASH_RC"
        rm "$DB_FILE"
        echo -e "\n${G}[+] System removed. Restart Termux.${NC}"
        exit 0
    else
        echo -e "\n${R}[!] Wrong Password.${NC}"
    fi
}

_login() {
    _banner
    stored_user=$(cut -d: -f1 "$DB_FILE")
    stored_pass=$(cut -d: -f2 "$DB_FILE")
    
    while true; do
        echo -e "Options: [1] Login [2] Forgot [3] Remove"
        read -p "Select > " opt
        
        case $opt in
            1)
                read -p "Username: " u
                read -s -p "Password: " p
                echo ""
                if [[ "$u" == "$stored_user" && "$p" == "$stored_pass" ]]; then
                    echo -e "${G}[+] Authorized. Welcome back.${NC}"
                    break
                else
                    echo -e "${R}[!] Login Failed.${NC}"
                fi
                ;;
            2) _recovery ;;
            3) _remove_lock ;;
            *) echo "Invalid option" ;;
        esac
    done
}

# Execution
_init_db
_login
