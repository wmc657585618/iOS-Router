#!/bin/bash

folder=${SRCROOT}
file_h=$folder/RouterDemo/Other/HiRouterPath.h
file_m=$folder/RouterDemo/Other/HiRouterPath.m
: > $file_h
: > $file_m

echo -e "#import <Foundation/Foundation.h>" >> $file_h
echo -e "#import \"HiRouterPath.h\"\n" >> $file_m

dic_m="\n"

filter_key_value () {

    str=$1
    parametes=${str#*#}
    key=${parametes%&*}
    value=${parametes#*&}
    path=${key//\//"_"}
    key_up=$(echo $path | tr 'a-z' 'A-Z')

    echo -e "// in $2" >> $file_m
    echo -e "NSString *const "$key_up"= @\"${key}\";\n" >> $file_m
    #echo -e "NSString *const "$value"= @\"${value}\";\n" >> $file_m

    echo -e "\nextern NSString *const "$key_up";" "// in $2">> $file_h
    dic_m=$dic_m"\t\t\t$key_up: @\"$value\",\n"
}

headers=$(/usr/libexec/PlistBuddy -c 'Print' $folder/files.plist)
headers=${headers#*\{}
headers=${headers%\}*}

for header in $headers;do

    for file in $(find $folder -name $header.h); do

        filter_key_value "$(head -n 1 ${file})" $header.h

    done

done

h_end="\n@interface HiRouterPath : NSObject\
\n\n@property (nonatomic, readonly, class) NSDictionary *pathDictionary;\
\n\n@end"
echo -e $h_end >> $file_h

m_end="@implementation HiRouterPath\
\n\n+ (NSDictionary *)pathDictionary {\
\n\treturn @{$dic_m\t\t\t};\
\n}\
\n\n@end"
echo -e $m_end >> $file_m









