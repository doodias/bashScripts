#!/bin/bash
# Script de ferramentas do DNF
# Autor: Eduardo
# Descrição: Facilita a manutenção e configuração do sistema RHEL/Fedora

while true; do
    clear
    echo "================================================="
    echo "   Script de Ferramentas do DNF (RHEL / Fedora)  "
    echo "================================================="
    echo
    echo "===== ATUALIZAÇÃO E PACOTES ====="
    echo "1)  Verificar pacotes desatualizados"
    echo "2)  Atualizar o sistema"
    echo "3)  Remover pacotes órfãos (libera espaço)"
    echo "4)  Instalar suporte SNAP"
    echo "5)  Instalar suporte Flatpak"
    echo
    echo "===== LIMPEZA E OTIMIZAÇÃO ====="
    echo "6)  Limpeza de cache do DNF"
    echo "7)  Limpar arquivos temporários (/tmp e ~/.cache)"
    echo "8)  Atualizar cache do DNF"
    echo
    echo "===== LISTAR PACOTES ====="
    echo "9)  Listar pacotes RPM instalados"
    echo "10) Listar pacotes SNAP instalados"
    echo "11) Listar pacotes FLATPAK instalados"
    echo
    echo "===== SEGURANÇA E DIAGNÓSTICO ====="
    echo "12) Verificar integridade de pacotes"
    echo "13) Verificar atualizações de segurança"
    echo "14) Reparar permissões de sistema (SELinux)"
    echo "15) Análise de logs do sistema"
    echo "16) Uso de disco (por sistema de arquivos)"
    echo "17) Arquivos grandes no /home"
    echo
    echo "===== GESTÃO DE USUÁRIOS E GRUPOS ====="
    echo "18) Criar novo usuário"
    echo "19) Listar usuários do sistema"
    echo "20) Listar grupos do sistema"
    echo "23) Remover usuário"
    echo
    echo "===== GESTÃO DE SERVIÇOS ====="
    echo "21) Listar serviços do sistema"
    echo "22) Verificar status de um serviço específico"
    echo
    echo "0)  Sair"
    echo

    read -p "Digite a opção desejada: " opcao

    case $opcao in
        1)
            echo "Verificando pacotes desatualizados..."
            sudo dnf check-update
            ;;
        2)
            echo "Atualizando o sistema..."
            sudo dnf update
            ;;
        3)
            echo "Removendo pacotes órfãos..."
            sudo dnf autoremove
            ;;
        4)
            echo "Instalando snapd..."
            sudo dnf install snapd
            ;;
        5)
            echo "Instalando flatpak..."
            sudo dnf install flatpak
            ;;
        6)
            echo "Limpando cache do DNF..."
            sudo dnf clean all
            ;;
        7)
            echo "Limpando arquivos temporários..."
            rm -rf /tmp/*
            rm -rf ~/.cache/*
            echo "Limpeza concluída!"
            ;;
        8)
            echo "Atualizando cache do DNF..."
            sudo dnf makecache
            ;;
        9)
            echo "Listando pacotes RPM instalados..."
            dnf list installed | head -50
            echo "... (use 'dnf list installed' no terminal para ver todos)"
            ;;
        10)
            echo "Listando pacotes SNAP instalados..."
            snap list
            ;;
        11)
            echo "Listando pacotes FLATPAK instalados..."
            flatpak list
            ;;
        12)
            echo "Verificando integridade de pacotes..."
            sudo dnf check
            ;;
        13)
            echo "Verificando atualizações de segurança..."
            sudo dnf security check-update
            ;;
        14)
            echo "Reparando permissões de sistema (SELinux)..."
            sudo restorecon -Rv / 2>/dev/null
            echo "Reparação concluída!"
            ;;
        15)
            echo "Últimas mensagens de log do sistema:"
            sudo journalctl -xe | tail -30
            ;;
        16)
            echo "Uso de disco por sistema de arquivos:"
            df -h
            ;;
        17)
            echo "Arquivos maiores que 100MB no /home:"
            find /home -type f -size +100M -exec ls -lh {} \; 2>/dev/null | awk '{print $5, $9}'
            ;;
        18)
            echo "===== Criar Novo Usuário ====="
            read -p "Digite o nome do novo usuário: " username
            read -sp "Digite a senha: " password
            echo
            echo "Criando usuário $username..."
            sudo useradd -m -s /bin/bash "$username"
            echo "$username:$password" | sudo chpasswd
            echo "Usuário $username criado com sucesso!"
            ;;
        19)
            echo "Listando usuários do sistema:"
            cat /etc/passwd | cut -d: -f1,3,6 | grep -E ':[0-9]{3,}:' | column -t -s:
            ;;
        20)
            echo "Listando grupos do sistema:"
            cat /etc/group | cut -d: -f1,3 | column -t -s:
            ;;
        21)
            echo "Listando serviços do sistema:"
            sudo systemctl list-units --type=service --all | grep -E 'service|UNIT'
            ;;
        22)
            echo "===== Verificar Status de Serviço ====="
            read -p "Digite o nome do serviço: " service_name
            echo
            sudo systemctl status "$service_name"
            ;;
        23)
            echo "===== Remover Usuário ====="
            read -p "Digite o nome do usuário a remover: " username
            read -p "Deseja remover o diretório home também? (s/n): " remove_home
            echo "Removendo usuário $username..."
            if [[ $remove_home == "s" || $remove_home == "S" ]]; then
                sudo userdel -r "$username"
                echo "Usuário $username e seu diretório home foram removidos!"
            else
                sudo userdel "$username"
                echo "Usuário $username foi removido! (diretório home mantido)"
            fi
            ;;
        0)
            echo "Saindo..."
            break
            ;;
        *)
            echo "Opção inválida!"
            ;;
    esac

    read -p "Pressione ENTER para continuar..."
done