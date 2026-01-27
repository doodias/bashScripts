#!/bin/bash
# Script de limpeza do DNF
# Autor: Eduardo
# Descrição: Facilita a execução dos comandos "dnf clean"

clear
echo "============================================="
echo "   Script de Limpeza do DNF (RHEL / Fedora)  "
echo "============================================="
echo
echo "Escolha uma opção de limpeza:"
echo "1) dnf clean dbcache      - Remove cache de metadados"
echo "2) dnf clean expire-cache - Expira metadados"
echo "3) dnf clean metadata     - Remove metadados"
echo "4) dnf clean packages     - Remove pacotes em cache"
echo "5) dnf clean all          - Faz todas as limpezas"
echo "0) Sair"
echo

read -p "Digite a opção desejada: " opcao

case $opcao in
    1)
        echo "Executando: dnf clean dbcache"
        sudo dnf clean dbcache
        ;;
    2)
        echo "Executando: dnf clean expire-cache"
        sudo dnf clean expire-cache
        ;;
    3)
        echo "Executando: dnf clean metadata"
        sudo dnf clean metadata
        ;;
    4)
        echo "Executando: dnf clean packages"
        sudo dnf clean packages
        ;;
    5)
        echo "Executando: dnf clean all"
        sudo dnf clean all
        ;;
    0)
        echo "Saindo..."
        exit 0
        ;;
    *)
        echo "Opção inválida!"
        ;;
esac

