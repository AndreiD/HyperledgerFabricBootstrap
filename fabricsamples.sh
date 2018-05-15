#!/bin/bash

# This will install the fabric samples. Before you run this, make sure you ran the prereqs first.

# Usage  
# sudo wget -O - https://raw.githubusercontent.com/AndreiD/HyperledgerFabricBootstrap/master/fabricsamples.sh | bash

 #stops the execution of a script if a command or pipeline has an error
 set -e
 
# let'em have colors
end="\033[0m"
red="\033[0;31m"
green="\033[0;32m"


#echo "${red}Error: Ubuntu ${CODENAME} is not supported${end}"
#echo -e "${green}..........Updating Packages..........${end}"

echo -e "${green}..........Downloading fabric-samples..........${end}"
cd $HOME

# if it exists, delete it
if [ -d "fabric-samples" ]; then
  rmdir "fabric-samples"
fi

git clone -b master https://github.com/hyperledger/fabric-samples.git
cd fabric-samples
git checkout v.1.1.0
