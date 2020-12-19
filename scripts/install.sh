#!/bin/bash

helpFunction()
{
   echo ""
   echo "Usage: $0 -p pythonVersion -u upload -l layerName"
   echo -e "\t-p: version of the python ex: 3.8"
   echo -e "\t-u: should zip after installing ex: yes|no"
   echo -e "\t-l: name of the layer ex: StoryLayer"
   echo "Ex: ./scripts/install.sh -p 3.8 -u yes -a StoryLayer"
   exit 1 # Exit script after printing help
}

while getopts "p:u:l:" opt
do
   case "$opt" in
      p ) pythonVersion="$OPTARG" ;;
      u ) upload="$OPTARG" ;;
      l ) layerName="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Begin script in case all parameters are correct
echo "Python version: $pythonVersion"
echo "Upload: $upload"
echo "Layer Name: $layerName"

# Print helpFunction in case parameters are empty
if [ -z "$pythonVersion" ] || [ -z "$upload" ] || [ -z "$layerName" ]
then
   echo "Some or all of the parameters are empty";
   helpFunction
fi

docker run -v "$PWD":/var/task "lambci/lambda:build-python$pythonVersion" /bin/sh -c "pip install -r requirements.txt -t python/lib/python$pythonVersion/site-packages/; exit"

if [[ $upload -eq "yes" ]]
then
    rm "$layerName".zip
    echo "Create or update lambda layer ($layerName): file://$PWD/$layerName.zip"
    zip -r "$layerName".zip python > /dev/null
    aws lambda publish-layer-version --layer-name "$layerName" --description "$layerName" --zip-file "fileb://$PWD/$layerName.zip" --compatible-runtimes "python$pythonVersion"
fi