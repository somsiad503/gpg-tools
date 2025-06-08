#!/bin/bash
# Script: gpg-tools
# Author: somsiad503
# License: GNU GPL v3
# This program is free software. You can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.

create_key(){
    clear
    echo "======Generating new key======"
    gpg --full-generate-key
}

encrypt_file(){
    clear
    echo -n "Enter the full file path: "
    read fullfilepath
    clear
    echo "1) Use Key ID"
    echo "2) Use User ID"
    echo -n "Choose option (1/2): "
    read opc
    case $opc in
    1)
        clear
        echo -n "Key ID: "
        read keyid
        clear
        echo "1) .gpg"
        echo "2) .asc"
        echo -n "Choose output file extension (default: gpg): "
        read opc
        case $opc in
        1) gpg --recipient "$keyid" --encrypt $fullfilepath ;;
        2) gpg --recipient "$keyid" --armor --encrypt $fullfilepath ;;
        *) gpg --recipient "$keyid" --encrypt $fullfilepath ;;
        esac
        ;;
    2)
        clear
        echo -n "First name: "
        read name
        echo -n "Last name (optional): "
        read surname
        echo -n "Email: "
        read mail
        if [ -n "$surname" ]; then
            userid="$name $surname <$mail>"
        else
            userid="$name <$mail>"
        fi
        clear
        echo "1) .gpg"
        echo "2) .asc"
        echo -n "Choose output file extension (default: gpg): "
        read opc
        case $opc in
        1) gpg --recipient "$userid" --encrypt $fullfilepath ;;
        2) gpg --recipient "$userid" --armor --encrypt $fullfilepath ;;
        *) gpg --recipient "$userid" --encrypt $fullfilepath ;;
        esac
        ;;
    esac
}

decrypt_file(){
    clear
    echo -n "Enter full path to file (without encryption extension): "
    read filefp
    clear
    echo "1) gpg"
    echo "2) asc"
    echo "3) pgp"
    echo -n "Choose file extension: "
    read extension
    case $extension in
    1) gpg --decrypt $filefp.gpg > $filefp ;;
    2) gpg --decrypt $filefp.asc > $filefp ;;
    3) gpg --decrypt $filefp.pgp > $filefp ;;
    *) echo "Invalid option!" ;;
    esac
}

list_keys(){
    clear
    echo "======Public Keys======"
    gpg --list-keys --keyid-format LONG
    echo "======Private Keys======"
    gpg --list-secret-keys --keyid-format LONG
}

encrypt_password(){
    clear
    echo -n "Enter full path to file: "
    read ffp
    gpg --symmetric $ffp
}

encrypt_text_file(){
    echo -n "Enter output path and filename (without extension): "
    read fn
    clear
    echo "1) Use Key ID"
    echo "2) Use User ID"
    echo -n "Choose option (1/2): "
    read opc
    case $opc in
    1)
        clear
        echo -n "Key ID: "
        read keyid
        clear
        echo "1) .gpg"
        echo "2) .asc"
        echo -n "Choose output file extension (default: asc): "
        read opc
        case $opc in
        1)
        echo "# Write the message (remove this comment), then save with Ctrl + O -> Enter -> Ctrl + X" > tmp_files/tmp_mess.txt
        nano tmp_files/tmp_mess.txt
        gpg --output $fn.txt.gpg --recipient "$keyid" --encrypt tmp_files/tmp_mess.txt
        rm -rf tmp_files/tmp_mess.txt;;
        2)
        echo "# Write the message (remove this comment), then save with Ctrl + O -> Enter -> Ctrl + X" > tmp_files/tmp_mess.txt
        nano tmp_files/tmp_mess.txt
        gpg --output $fn.txt.asc  --recipient "$keyid" --armor --encrypt tmp_files/tmp_mess.txt
        rm -rf tmp_files/tmp_mess.txt;;
        *) 
        echo "# Write the message (remove this comment), then save with Ctrl + O -> Enter -> Ctrl + X" > tmp_files/tmp_mess.txt
        nano tmp_files/tmp_mess.txt
        gpg --output $fn.txt.asc --recipient "$keyid" --armor --encrypt tmp_files/tmp_mess.txt
        rm -rf tmp_files/tmp_mess.txt;;
        esac
        ;;
    2)
        clear
        echo -n "First name: "
        read name
        echo -n "Last name (optional): "
        read surname
        echo -n "Email: "
        read mail
        if [ -n "$surname" ]; then
            userid="$name $surname <$mail>"
        else
            userid="$name <$mail>"
        fi
        clear
        echo "1) .gpg"
        echo "2) .asc"
        echo -n "Choose output file extension (default: asc): "
        read opc
        case $opc in
        1) 
        echo "# Write the message (remove this comment), then save with Ctrl + O -> Enter -> Ctrl + X" > tmp_files/tmp_mess.txt
        nano tmp_files/tmp_mess.txt
        gpg --output $fn.txt.gpg --recipient "$userid" --encrypt tmp_files/tmp_mess.txt
        rm -rf tmp_files/tmp_mess.txt;;
        2)
        echo "# Write the message (remove this comment), then save with Ctrl + O -> Enter -> Ctrl + X" > tmp_files/tmp_mess.txt
        nano tmp_files/tmp_mess.txt
        gpg --output $fn.txt.asc  --recipient "$userid" --armor --encrypt tmp_files/tmp_mess.txt
        rm -rf tmp_files/tmp_mess.txt;;
        *) 
        echo "# Write the message (remove this comment), then save with Ctrl + O -> Enter -> Ctrl + X" > tmp_files/tmp_mess.txt
        nano tmp_files/tmp_mess.txt
        gpg --output $fn.txt.asc --recipient "$userid" --armor --encrypt tmp_files/tmp_mess.txt
        rm -rf tmp_files/tmp_mess.txt;;
        esac
        ;;
    esac
}

encrypt_text_pas(){
    echo -n "Enter output path and filename (without extension): "
    read fn
    clear
    echo "1) .gpg"
    echo "2) .asc"
    echo -n "Choose output file extension (default: asc): "
    read opc
    case $opc in
    1) echo "# Write the message (remove this comment), then save with Ctrl + O -> Enter -> Ctrl + X" > tmp_files/tmp_mess.txt
        nano tmp_files/tmp_mess.txt
        gpg --output $fn.txt.gpg --symmetric tmp_files/tmp_mess.txt
        rm -rf tmp_files/tmp_mess.txt
        ;;
    2) 
        echo "# Write the message (remove this comment), then save with Ctrl + O -> Enter -> Ctrl + X" > tmp_files/tmp_mess.txt
        nano tmp_files/tmp_mess.txt
        gpg --output $fn.txt.asc --armor --symmetric tmp_files/tmp_mess.txt
        rm -rf tmp_files/tmp_mess.txt
        ;;
    *) 
        echo "# Write the message (remove this comment), then save with Ctrl + O -> Enter -> Ctrl + X" > tmp_files/tmp_mess.txt
        nano tmp_files/tmp_mess.txt
        gpg --output $fn.txt.asc --armor --symmetric tmp_files/tmp_mess.txt
        rm -rf tmp_files/tmp_mess.txt
        ;;
    esac
}

decrypt_text(){
    echo "# Paste the encrypted message in ASC format below, then save with Ctrl + O -> Enter -> Ctrl + X" > tmp_files/tmp_mess.txt.asc
    nano tmp_files/tmp_mess.txt.asc
    gpg --decrypt tmp_files/tmp_mess.txt.asc
    rm -rf tmp_files/tmp_mess.txt.asc
}

import_key(){
    clear
    echo "1) This computer"
    echo "2) Keyserver"
    echo -n "Choose source of the key: "
    read opt
    case $opt in
        1) echo -n "Enter full path to key file (with extension): "
           read key
           gpg --import $key ;;
        2) echo -n "Enter keyserver address: "
           read keyserver
           clear
           echo -n "Enter name or email to search: "
           read keysearch
           gpg --keyserver $keyserver --search-keys "$keysearch" ;;
    esac
}

clear
while true; do
echo "+==========gpg-tools==========+"
echo "| 1) Create key               |"
echo "| 2) List keys                |"
echo "| 3) Import key               |"
echo "| 4) Decrypt file             |"
echo "| 5) Encrypt file (key)       |"
echo "| 6) Encrypt file (password)  |"
echo "| 7) Encrypt text (key)       |"
echo "| 8) Encrypt text (password)  |"
echo "| 9) Decrypt text             |"
echo "| 10) Exit                    |"
echo "+=============================+"
echo -n "Choose option: "
read opt
case $opt in
1) create_key;;
2) list_keys;;
3) import_key;;
4) decrypt_file;;
5) encrypt_file;;
6) encrypt_password;;
7) encrypt_text_file;;
8) encrypt_text_pas;;
9) decrypt_text;;
10) exit 0;;
*) echo "Invalid option";;
esac
done
