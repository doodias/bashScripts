#!/bin/bash

while true; do
    clear

echo "
***********************************************
*                Linux Tools                  *
***********************************************
[1] - Atualizar sistema 
[2] - Atualizar Snap
[3] - Atualizar Flatpak
[4] - limpar temporários
[5] - Limpar cache do Snap
[6] - Limpar cache do Flatpak
[0] - Sair
   
***********************************************

"
read -p "Escolha uma opção: " option

case $option in
     1)
         echo "Atualizando o sistema..."
         sudo dnf update -y
         ;;
     2)
         echo "Atualizando pacotes Snap..."
         sudo snap refresh
         ;;
     3)
         echo "Atualizando Flatpak..."
         flatpak update -y
         ;;
     4)
         echo "Limpando arquivos temporários..."
         sudo dnf clean all
         ;;
     5) 
         echo "Limpando cache do Snap..."
         sudo rm -rf /var/lib/snapd/cache/*
         ;;
     6)
         echo "Limpando cache do Flatpak..."
         flatpak uninstall --unused -y
         ;;
     0)
         echo "Saindo..."
         exit 0
         ;;
     *)
         echo "Opção inválida. Tente novamente."
         ;;
 esac

read -p "Pressione Enter para continuar..."
    
done
