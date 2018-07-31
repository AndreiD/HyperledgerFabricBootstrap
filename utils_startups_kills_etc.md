### kill_go_app.sh

~~~~
ps -ef | grep 'go' | grep -v grep | awk '{print $2}' | xargs -r kill -9
~~~~


### build and restart go app

~~~~
clear
cd /home/ubuntu/go/src/github.com/path_to_your_application/
if git pull
then
  echo "pulled successfully"
  go get ./...
  go build -o appname
  sudo service supervisor restart
  echo "Supervisor Restarted"
else
  echo "Attention! Pull failed. Check your stuff!"
fi
~~~~


