#!/bin/bash

folder=$(pwd)
file_h=$folder/RouterDemo/Other/HiRouterPath.h
file_m=$folder/RouterDemo/Other/HiRouterPath.m
plist_path=$folder/files.plist

: > $file_h
: > $file_m

echo -e "#import <Foundation/Foundation.h>" >> $file_h
echo -e "#import \"HiRouterPath.h\"\n" >> $file_m

dic_m="\n"
dic_name="pathDictionary"
const_pre="NSString *const"
extern_pre="extern $const_pre"

filter_key_value () {

    str=$1
    parametes=${str#*#}
    key=${parametes%&*}
    value=${parametes#*&}

    key_up=$(echo ${key//\//"_"} | tr 'a-z' 'A-Z')

    echo -e "// in $2" >> $file_m
    echo -e "$const_pre "$key_up"= @\"${key}\";\n" >> $file_m
    echo -e "$const_pre "$value"= @\"${value}\";\n" >> $file_m

    echo -e "\n$extern_pre "$key_up";" "// in $2">> $file_h
    dic_m=$dic_m"\t\t\t$key_up: @\"$value\",\n"
}

index=0

while :;do

    /usr/libexec/PlistBuddy -c "Print :$index" $folder/files.plist > /dev/null 2>&1 || break
    header=`/usr/libexec/PlistBuddy -c "Print :$index" $plist_path`

    filter_key_value "$(head -n 1 `find $folder -name $header.h`)" $header.h

    let "index++"
done

h_end="\n@interface HiRouterPath : NSObject\
\n\n@property (nonatomic, readonly, class) NSDictionary *$dic_name;\
\n\n@end"
echo -e $h_end >> $file_h

m_end="@implementation HiRouterPath\
\n\n+ (NSDictionary *)$dic_name {\
\n\treturn @{$dic_m\t\t\t};\
\n}\
\n\n@end"
echo -e $m_end >> $file_m
