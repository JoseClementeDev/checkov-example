#!/bin/bash

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Función para mostrar mensajes
print_message() {
    echo -e "${2}${1}${NC}"
}

# Verificar si Checkov está instalado
if ! command -v checkov &> /dev/null; then
    print_message "Checkov no está instalado. Instalando..." "${YELLOW}"
    pip install checkov
fi

# Directorios a escanear
CLOUDFORMATION_DIR="./cloudformation"
TERRAFORM_DIR="./terraform"

# Función para escanear un directorio
scan_directory() {
    local dir=$1
    local framework=$2

    print_message "\nEscaneando directorio: $dir" "${YELLOW}"

    checkov -d "$dir" \
        --framework "$framework" \
        --output cli

    if [ $? -eq 0 ]; then
        print_message "\nEscaneo completado sin problemas." "${GREEN}"
    else
        print_message "\nSe encontraron problemas durante el escaneo." "${RED}"
    fi
}

# Escanear CloudFormation
if [ -d "$CLOUDFORMATION_DIR" ]; then
    scan_directory "$CLOUDFORMATION_DIR" "cloudformation"
else
    print_message "Directorio de CloudFormation no encontrado: $CLOUDFORMATION_DIR" "${RED}"
fi

# Escanear Terraform
if [ -d "$TERRAFORM_DIR" ]; then
    scan_directory "$TERRAFORM_DIR" "terraform"
else
    print_message "Directorio de Terraform no encontrado: $TERRAFORM_DIR" "${RED}"
fi

print_message "\nProceso de escaneo completado." "${GREEN}"