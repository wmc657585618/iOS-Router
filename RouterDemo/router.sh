#!/bin/bash

folder=${SRCROOT}
temp_file=$folder/RouterDemo/Other/RouterPath.h
: > $temp_file

filter_key_value () {

    str=$1
    parametes=${str#*#}
    key=${parametes%&*}
    value=${parametes#*&}
    path=${key//\//"_"}
    key_up=$(echo $path | tr 'a-z' 'A-Z')

    echo -e "NSString *const "$key_up"= @\"${key}\";" "// in $2\n" >> $temp_file
}

headers=$(/usr/libexec/PlistBuddy -c 'Print' $folder/RouterDemo/files.plist)
headers=${headers#*\{}
headers=${headers%\}*}

for header in $headers;do

    for file in $(find $folder -name $header.h); do

        filter_key_value "$(head -n 1 ${file})" $header.h

    done

done









