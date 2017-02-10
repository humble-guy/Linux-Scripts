#The script auto_extract.sh can be used to:-
#1. Automatically extract the tar.gz files passed as
#command line arguments
#2. It supports multiple directories to be given as #argument
#3. It creates a directory ExtractedFiles which 
#contains all the extracted tar.gz files.
#4. Even if the readme is within a subdirectory, it will
#be able to execute its commands on the condition that 
#readme contains the path to the script.
#5.A file 141112023testing.tar.gz is also attached(used)
#for testing this script 

#Instructions to execute

#Sample Instruction 1

bash autoextract.sh ~/Downloads

#Sample Instruction 2

bash auto_extract.h ~/Downloads ~/Desktop/abc.tar.gz

Note: The script searches the directory recursively for tar.gz files.
