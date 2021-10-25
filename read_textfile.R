#Function to read data
read_textfile <- function(y){
  read.delim(y, stringsAsFactors = TRUE, header=FALSE,sep="")
}