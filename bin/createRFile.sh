function createRFile() {

    FILE_NAME=$1

    SCRIPT_NAME=$(echo "$FILE_NAME" | sed "s/\\.R$//i").R

    echo '
suppressMessages(library(optparse))


option_list= list(
 
  make_option(
    c("-o", "--output_folder"),
    type = "character",
    default = "./",
    help = "The output directory where all new files were generated",
    metavar = "character"
  ),
  
  make_option(
    c("-v", "--verbose"), 
    action="store_true", 
    default=FALSE,
    help="Print extra output"
  )    
)

args = parse_args(OptionParser(option_list=option_list, add_help_option = FALSE)  )

if(args$verbose){
  print("Input args:")  
  print(args)
}



if(args$verbose){
  print("$SCRIPT_NAME FINISHED")  

}



' > $SCRIPT_NAME

echo $SCRIPT_NAME

}

