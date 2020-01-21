function cleanInput() {
    echo $1 | sed "s/'//g"
}
