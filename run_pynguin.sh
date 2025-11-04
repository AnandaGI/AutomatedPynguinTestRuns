#!/bin/bash

#Check if arguments have been passed
if [ "$#" -lt 5 ]; then
	echo "Please input 5 arguments (space delimited) (include final / in filepaths):"
	echo "Usage: $0 <number of runs> <input_path> <output_path> <package_path> <module_name> (optional <path/to/params.txt>)"
	echo ""
	exit 1
fi

num_runs=$1
input_path=$2
output_path=$3
package_path=$4
module_name=$5
param_file=$6

#Get passed parameters
if [ "$#" -eq 6 ]; then
	params=""
	while IFS= read -r line
	do
		params+="$line "
	done < "$param_file"
fi


#Install pynguin and dependencies
sudo apt update
python3 -m pip install virtualenv
python3 -m pip install pynguin

#Create python virtual environment
python3 -m venv .venv
source .venv/bin/activate
export PYNGUIN_DANGER_AWARE="x"

#Run Pynguin via Docker
i=0
while [ $i -lt $num_runs ]; do
	echo "\nIteration $i\n"
	docker run -v $(pwd)/${input_path}:/input:ro -v $(pwd)/${output_path}:/output -v $(pwd)/${package_path}:/package:ro pynguin-docker-exp --project-path /input --output-path /output --module-name ${module_name} ${params}

	wait #until completion of Pynguin

	#Rename file so they are not overwritten
	mv output/test_${module_name}.py output/test_${module_name}${i}.py

	((i++))
done

#Deactivate virtual environment
deactivate
