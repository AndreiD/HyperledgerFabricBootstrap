### BEFORE 
sudo touch /var/log/your_logfile_name.log 
chown ubnutu:ubuntu your_logfile_name.log

[program:myapp]
command=/home/ubuntu/go/src/github.com/path_to_binary
directory=/home/ubuntu/go/src/github.com/path_to_directory
user=ubuntu
numprocs=1
autostart=true
autorestart=true
redirect_stderr=true
stdout_logfile=/var/log/your_logfile_name.log
stdout_logfile_maxbytes=50MB
stdout_logfile_backups=1
startretries=3


### View logs by calling

sudo supervisorctl tail myapp
