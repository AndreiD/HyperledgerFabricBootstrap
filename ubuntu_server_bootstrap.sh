#!/bin/bash

# This will install all the required software to get starting with ubuntu server

# Usage  
# sudo wget -O - https://click_view_raw_copy_url | bash

 #stops the execution of a script if a command or pipeline has an error
 set -e
 
# let'em have colors
end="\033[0m"
red="\033[0;31m"
green="\033[0;32m"


if [ -z "$1" ]; then
    source /etc/lsb-release || \
        (echo -e "${red}Error: Release information not found, run script passing Ubuntu version codename as a parameter${end}"; exit 1)
    CODENAME=${DISTRIB_CODENAME}
else
    CODENAME=${1}
fi


# Need curl before....
sudo apt install -y curl

# Git
sudo apt-add-repository ppa:git-core/ppa

# Add Docker repository key to APT keychain
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Update where APT will search for Docker Packages
echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu ${CODENAME} stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list

echo -e "${green}..........Updating Packages..........${end}"
sudo apt-get update



echo "....................................................Installing build-essential & libssl-dev"
sudo apt install -y  build-essential libssl-dev libncurses5-dev libpcap-dev
sudo apt install -y nethogs htop unzip


echo -e "${green}..........Instaling Git..........${end}"
sudo apt install -y git

# Configure git
git config --global core.autocrlf false
git config --global core.longpaths true

echo -e "${green}..........NVM..........${end}"
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

export NVM_DIR="${HOME}/.nvm"
[ -s "${NVM_DIR}/nvm.sh" ] && . "${NVM_DIR}/nvm.sh"
[ -s "${NVM_DIR}/bash_completion" ] && . "${NVM_DIR}/bash_completion"

echo -e "${green}..........NodeJs..........${end}"
nvm install --lts

# Configure nvm to use version 6.9.5
nvm use --lts
nvm alias default 'lts/*'

echo -e "${green}..........NPM..........${end}"
npm install npm@latest -g

# Ensure that CA certificates are installed
sudo apt-get -y install apt-transport-https ca-certificates snapd



# Verifies APT is pulling from the correct Repository
sudo apt-cache policy docker-ce

echo -e "${green}..........Docker..........${end}"
sudo apt-get -y install docker-ce

# Add user account to the docker group
sudo usermod -aG docker $(whoami)

echo -e "${green}..........Docker Compose..........${end}"
sudo curl -L "https://github.com/docker/compose/releases/download/1.13.0/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

set +e
COUNT="$(python -V 2>&1 | grep -c 2.)"
if [ ${COUNT} -ne 1 ]
then
   sudo apt-get install -y python-minimal
fi
sudo npm install -g yarn
sudo npm install -g ts-node
sudo npm install -g typescript


echo -e "${green}..........Go..........${end}"
cd /tmp
wget -q https://storage.googleapis.com/golang/getgo/installer_linux
chmod +x installer_linux 
./installer_linux 
source $HOME/.bash_profile

echo 'export GOPATH=$HOME/go' >> ~/.bashrc 
echo 'export PATH=${PATH}:${GOPATH}/bin' >> ~/.bashrc 
source ~/.bashrc 

echo ""
echo ""
echo -e "${green}...................FINISHED.....................${end}"
echo -n 'Node:'
node --version
echo -n 'npm:'
npm --version
echo -n 'Docker:'
docker --version
echo -n 'Docker Compose: '
docker-compose --version
echo -n 'Python:'
python -V
echo -n 'Go:'
go version
echo -e "${green}........................................${end}"

echo ""
echo ""
echo -e "${green}...................please relog now.....................${end}"
echo -e "${green}...................please relog now.....................${end}"
echo -e "${green}...................please relog now.....................${end}"
