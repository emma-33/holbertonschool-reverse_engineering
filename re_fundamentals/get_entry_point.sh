#!/bin/bash

source ./messages.sh

#check if an argument is provided
if [ $# -eq 0 ];
    then
    echo "Usage : $0 <file_name>"
    exit 1
fi

file_name="$1"

#check if file exists
if [ ! -f "$file_name" ]
    then
    echo "Error: '$file_name' doesn't exist"
    exit 1
fi

#check if file is an ELF
if ! file "$file_name" | grep -q 'ELF'
    then
    echo "Error: '$file_name' is not a valid ELF file"
fi

#get needed info
magic_number=$(readelf -h $file_name | grep 'Magic:' | cut -d: -f2 | xargs)
class=$(readelf -h $file_name | grep 'Class:' | cut -d: -f2 | xargs)
byte_order=$(readelf -h $file_name | grep 'Data:' | cut -d, -f2 | sed 's/^[[:space:]]*//')
entry_point_address=$(readelf -h $file_name | grep 'Entry point address:' | cut -d: -f2 | xargs)

#display info using func in messages.sh
display_elf_header_info
