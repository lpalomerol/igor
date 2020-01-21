function cleanInput() {
    echo $1 | sed "s/'//g"
}

function escapeBackslashes(){
    echo $1 | sed 's/\//\\\//g'
}
