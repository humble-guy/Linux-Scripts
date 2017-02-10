
echo "This script will automatically extract and run(if applicable) the tar files in given path"

echo "Please provide the full path to the tar file or directory where tar files exist"

echo "Note: The script deletes any existing directory with name ExtractedFiles in current path. Be cautious!"

#Taking the command line arguments(0 or more)
args_list="$*"

#arr is an array storing the command line arguments input by the user
arr=($args_list)

#Removing any existing directory with the name and creating fresh directory
rm -rf ExtractedFiles
mkdir ExtractedFiles

#function to extract the files in the folder ExtractedFiles
ExtractAndExecute(){
#The argument passed is an array of possible tar files in the directory or file path
arr=("$@")
for i in ${arr[@]}
do
echo "Tar file found:"$i
fileName=$(basename "$i")
path="ExtractedFiles/$fileName"
mkdir $path
tar -xzvf $i -C $path
done 
}

#main
for i in ${arr[@]}
do
echo $i
echo "Checking existence for above path"
if [ -e $i ]
then
    if [ -d $i ]
    then
	echo "Processing the directory ..."
        tar_files=($(find $i -type f -name "*.tar.gz"))
	ExtractAndExecute "${tar_files[@]}"
    else
    
    if [ -f $i ]
    then
	echo "Processing the file ..."
        if [ "$i" == "*.tar.gz" ]
	then
	    tar_files=($i)
	    ExtractAndExecute "${tar_files[@]}"
	else
	    echo "Error: The given file path "$i" is not a tar file"
	fi
    fi
   fi
else
    echo "Error: The path "$i" does not exist."
fi
done
echo
echo "Executing Scripts(if any)"
echo "-------------------------"
cd ExtractedFiles
for directory in */
do
      cd $directory
      touch output.txt
      currentDirectory=$PWD
      readmeFiles=($(find . -type f -iname "readme.txt"))
	for i in ${readmeFiles[@]}
	do
	    readmeFileName=$(basename "$i")
            readmeDirectoryName=$(dirname "$i")
	    temp=$PWD
            cd $readmeDirectoryName
	    actualPath="$PWD/$readmeFileName"
	    bash $actualPath |& tee -a $currentDirectory/output.txt
	    cd $temp	
done
        cd ..
done
echo
echo
echo "Please check the Output.txt files in ExtractedFiles directory for results."





















