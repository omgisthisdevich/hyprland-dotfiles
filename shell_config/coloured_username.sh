#!/bin/bash


# to use this in the bashrc, for example:
#
# colorss=(33 69 105 141 177 213)
# PS1='\[$(colour_username "$USER" colorss)\] × \h \W \n↳ '

colour_username(){
    local username="$1"
    local -n colors="$2"
    # local colors=( 33 69 105 141 177 213 )

    #reversed array
    reversed=()
    for (( i=${#colors[@]}-1 ; i>=0 ; i-- )); do
        reversed+=("${colors[i]}")
    done
    # echo "${reversed[@]}"

    result=""
    num_colors=${#colors[@]}

    for (( i=0; i<${#username}; i++ )); do
        char="${username:$i:1}"


        if [[ $(( $((i / $num_colors ))  %2 )) -eq 0 ]]; then
            color=${colors[ $(( i% ${#colors[@]} )) ]}
        else 
            color=${reversed[ $(( i% ${#colors[@]} )) ]}

        fi

        result+="\033[38;5;${color}m${char}"
        
    done
    result+="\033[0m"  # rset colors after the string
    echo  -e "$result"
}
