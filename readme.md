# IMPORTANT

There is currently [a bug](https://bugs.freenas.org/issues/22672) in the latest stable version of FreeNAS Corral that borks container creation from non-FreeNAS collections if done in the GUI. [You can build this image via cli](https://wiki.freenas.org/index.php/Docker), and the pre-defined parameters will show up properly.

# Use Case

This image was designed specifically for multi-disk, multi-share Storj farming on FreeNAS Corral machines.

Chances are you're already running your FreeNAS machine 24/7 to serve up your files, run your VMs. Chances are you also over-built your NAS to ensure a long service life. Why not use that dormant compute and disk space to make a few bucks?

# How it works

The image contains a vanilla install  of [storjshare-daemon](https://github.com/Storj/storjshare-daemon), installed as per instructions provided by the Storj team, and an install of supervisord to start the whole ordeal. Upon starting, supervisord is called up and does the following things:

1. Starts the storjshare daemon
2. Runs [startall.sh](../blob/master/startall.sh) to start up all the config files.

# Directory structure & volume mounting

This image over-rides storjshare-daemon defaults in order to make the file structure easier to manage with many disks. All Storj-related files are stored in **/etc/storjshare** with the following subfolders:

+ **/etc/storjshare/config/**: holds all config files, named n.json
+ **/etc/storjshare/logs/**: holds all log files, named n.log
+ **/etc/storjshare/data/**: holds points to all data-bearing volumes in the form of numbered subfolders

# Mounting volumes

My prefer method for mounting volumes looks something like this:

![Volume arrangement](../master/arrayconfig.jpg?raw=true)

Configs live on a redundant array to make sure that a single disk failure does not affect the entire operation, as do logs. A chunk of the redundant volume (in ZFS, you probably want a seperated dataset) is attributed for Storj data use, typically in **/etc/storjshare/data/0/**.

All other disks designed for Storj sharing can then be mounted as single-disk volumes, which maximizes usable space while isolating each disk in a separate node. If a disk fails, remove and replace. Through the FreeNAS GUI, you can mount as many single disk volumes as you want; map them to **/etc/storjshare/data/N/**, create a config for each drive and you're off the the races.

In this scenario, you could easily run a legacy DAS or direct-connected fiber-channel disk shelf with free or next-to-free hard drives and make money off hardware that would otherwise be unusable.

# Improvement ideas

+ Monitoring script that scrapes logs and data provided by *storjshare status* to give an indication of health of nodes. Output in XML to be able to use it easily in a web page.
+ A fully automated way of batch-creating configurations for every volume mounted in the data folder
..+ Payout address configured in FreeNAS parameters.   
+ Some way of auto-exposing ports for the appropriate number of nodes. This is probably the hardest part.
