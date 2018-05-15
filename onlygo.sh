#!/bin/bash

# Only installs Go 
# sudo wget -O - https://raw.githubusercontent.com/AndreiD/HyperledgerFabricBootstrap/master/onlygo.sh | bash

 #stops the execution of a script if a command or pipeline has an error
 set -e
 
# let'em have colors
end="\033[0m"
red="\033[0;31m"
green="\033[0;32m"


echo -e "${green}..........Go..........${end}"
cd /tmp
wget -q https://storage.googleapis.com/golang/getgo/installer_linux
chmod +x installer_linux 
./installer_linux 
source $HOME/.bash_profile

echo ""
echo ""
echo -e "${green}...................FINISHED.....................${end}"
echo -n 'Go:'
go version
echo -e "${green}........................................${end}"

cd $HOME
go get github.com/golang/example/hello
cd hello
go run hello.go
