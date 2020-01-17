function say(){
    echo -e "\e[92m$1\e[39m"
}

function warn(){
    echo -e "\e[93m$1\e[39m"
}

function err(){
    >&2 echo -e "\e[91m$1\e[39m"
}
