#!/bin/bash

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # Sin color

# Detección de la distribución y versión
if [ -f /etc/almalinux-release ]; then
    DISTRO="AlmaLinux"
    VERSION=$(cat /etc/almalinux-release)
elif [ -f /etc/os-release ]; then
    DISTRO=$(awk -F'=' '/^NAME/{print $2}' /etc/os-release | tr -d '"')
    VERSION=$(lsb_release -d | awk -F':' '{ print $2 }' | xargs)
else
    DISTRO="Desconocido"
    VERSION="No disponible"
fi

# Información del sistema con colores
echo -e "${GREEN}RAM:${NC} ${YELLOW}$(free -h --si | awk '/^Mem:/ { print $3 "/" $2 }')${NC}"
echo -e "${GREEN}Disk Space:${NC} ${YELLOW}$(df -h --total | awk '/^total/ { print $3 "/" $2 }')${NC}"
echo -e "${GREEN}Distribución:${NC} ${BLUE}$DISTRO${NC}"
echo -e "${GREEN}Versión:${NC} ${BLUE}$VERSION${NC}"
echo -e "${GREEN}CPU Model:${NC} ${CYAN}$(lscpu | awk -F':' '/Model name/ { print $2 }' | xargs)${NC}"
echo -e "${GREEN}CPU Cores:${NC} ${CYAN}$(lscpu | awk -F':' '/^CPU\(s\)/ { print $2 }' | xargs)${NC}"
echo -e "${GREEN}IP Pública:${NC} ${PURPLE}$(curl -s https://ipinfo.io | awk -F'"' '/"ip":/ { print $4 }')${NC}"
echo -e "${GREEN}Región:${NC} ${PURPLE}$(curl -s https://ipinfo.io | awk -F'"' '/"region":/ { print $4 }')${NC}"
