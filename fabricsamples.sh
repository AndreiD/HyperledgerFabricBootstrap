#!/bin/bash

# This will install the fabric samples. Before you run this, make sure you ran "required.sh" first.

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

echo -e "${green}..........Cloning Fabric Samples..........${end}"
cd $HOME

# if it exists, delete it
if [ -d "fabric-samples" ]; then
  rm -rf "fabric-samples"
fi

git clone -b master https://github.com/hyperledger/fabric-samples.git
cd fabric-samples/

#make sure that the tag exists locally by doing
git fetch --all --tags --prune

git checkout v1.1.0


# go back to home
cd $HOME

echo -e "${green}..........Downloading & Extracting Platform-specific Binaries..........${end}"

curl -sSL https://goo.gl/6wtTN5 | bash -s 1.1.0

export PATH=$HOME/fabric-samples/bin:$PATH

echo -e "${green}..........Making Sure Everything is Ok..........${end}"

echo -e "${green}..........Listing the docker images available..........${end}"
docker-images

echo -n 'Orderer:'
orderer version

echo -e "${green}..........Sit Back And Relax..........${end}"
echo -e "${green}..........Script will answer Yes automatically to every question..........${end}"
sleep 5
cd $HOME/fabric-samples/first-network
yes | ./byfn.sh -m generate

echo -e "${green}.......... Bringing Up The Network!..........${end}"
yes | ./byfn.sh -m up

echo -e "${green}..........Kill Containers, Remove crypto and artifacts..........${end}"
sleep 5
./byfn.sh -m down
echo -e "${green}.......... Finished! Good luck!..........${end}"
