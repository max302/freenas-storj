echo #!/bin/sh

config_dir="/etc/storjshare/config/" #The startall command will start *.json files in this directory

#Fetch config files present int config directory
config_enum=`ls $config_dir | grep .json`

if [ -z "$config_enum" ]; then
  echo "No config file found. Make sure config files have a .json extension"
  exit 1
fi

#Makes sure the daemon is started
eval "storjshare daemon"
for config_file in $config_enum
do
  eval "storjshare start --config" "$config_dir$config_file"
done
exit 0
