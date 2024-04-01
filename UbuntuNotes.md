# Ubuntu Cheatsheet

This covers a wide assortment of quick references for the terminal/command-line. Additionally, near the bottom are more items for GUI and Troubleshooting.

# Table of Contents
- [Basics](#basics)
- [Apt](#apt)
  - [Apt Install](#apt-install)
  - [Apt Update](#apt-update)
  - [Apt Upgrade](#apt-upgrade)
  - [Apt Remove](#apt-remove)
  - [Apt Lock Error](#apt-lock-error)
- [Listing and Navigating](#listing-and-navigating)
- [Users](#users)
- [Groups](#groups)
- [Permissions](#permissions)
    - [Easy Permissions](#easy-permissions)
    - [Octal Permissions](#octal-permissions)
    - [Octal Examples](#octal-examples)
    - [Preserve Group Permissions](#preserve-group-permissions)
- [OS Details](#os-details)
    - [Operating System](#operating-system)
    - [CPU Info](#cpu-info)
    - [Usage Info](#usage-info)
    - [Disk Space](#disk-space)
    - [System Processes](#system-processes)
    - [IP Address](#ip-address)
    - [GUI Processes](#gui-processes)
    - [CLI Processes](#cli-processes)
- [Kernal](#kernal)
    - [Remove Old Kernals](#remove-old-kernals)
- [List all Keybindings](#list-all-keybindings)
    - [See Keypressed](#see-keypressed)
- [OS Shutdown](#os-shutdown)
- [Crontab](#crontab)
- [Services](#services)
    - [Autostart](#autostart)
    - [Remove Autostart](#remove-autostart)
    - [Autostart Daemons](#autostart-daemons)
    - [SystemD Commands](#systemd-commands)
- [System State](#system-state)
- [Processes](#processes)
- [Bash](#bash)
    - [Bash Paths](#bash-paths)
    - [Add to Path](#add-to-path)
    - [Bash Completions](#bash-completions)
    - [Fix Broken Bash Completions](#fix-broken-bash-completions)
    - [Log Script from Bash](#log-script-from-bash)
- [Finding Files](#finding-files)
- [Find in Files (GREP)](#find-in-files-grep)
    - [Pipe Grep](#pipe-grep)
- [Reading Files](#reading-files)
- [Downloading Files](#downloading-files)
    - [Using Wget](#using-wget)
    - [Using cURL](#using-curl)
- [Compressing and Uncompressing Files](#compressing-and-uncompressing-files)
    - [Compressing Files](#compressing-files)
    - [Decompressing Files](#decompressing-files)
- [SCP](#scp)
    - [Download from server to local](#download-from-server-to-local)
    - [Upload from local to server](#upload-from-local-to-server)
- [SSH](#ssh)
    - [Connecting to a server](#connecting-to-a-server)
    - [SSH Permissions](#ssh-permissions)
    - [Using the Config](#using-the-config)
    - [SSH to PEM](#ssh-to-pem)
- [Firewall](#firewall)
    - [UFW Status](#ufw-status)
    - [UFW Enable/Disable](#ufw-enabledisable)
    - [UFW Example Customization](#ufw-example-customization)
    - [UFW More Options](#ufw-more-options)
    - [UFW Deleting Rules](#ufw-deleting-rules)
    - [UFW Reset Rules](#ufw-reset-rules)
- [Regex](#regex)
    - [Regex Examples](#regex-examples)
- [MySQL](#mysql)
    - [Connecting](#connecting)
    - [Exporting Database to SQL](#exporting-database-to-sql)
    - [Importing SQL Files](#importing-sql-files)
    - [Exporting Compressed Database](#exporting-compressed-database)
    - [Importing Compressed Database](#importing-compressed-database)
    - [Get Database Encoding](#get-database-encoding)
    - [Get Table Encoding](#get-table-encoding)
    - [Get Column Encoding](#get-column-encoding)
    - [Fix Broken Characters](#fix-broken-characters)
- [Git](#git)
    - [Populate a Repository](#populate-a-repository)
    - [Add or Remove Files](#add-or-remove-files)
    - [Ignoring files](#ignoring-files)
    - [Create a Branch](#create-a-branch)
    - [Switch Branches](#switch-branches)
    - [Pull One File From Another Branch](#pull-one-file-from-another-branch)
    - [Create a Tag](#create-a-tag)
    - [Remove a Tag](#remove-a-tag)
    - [Clone a Respository](#clone-a-repository)
    - [Current Status](#current-status)
    - [Commit Log and Show](#commit-log-and-show)
    - [Reset Hard](#reset-hard)
    - [Prune](#prune)
- [Docker](#docker)
    - [Docker Compose](#docker-compose)
    - [Test Box Run](#test-box-run)
    - [See Running Containers](#see-running-containers)
    - [Run Container Interactively](#run-container-interactively)
    - [Remove Container](#remove-container)
    - [Bulk Remove Containers](#bulk-remove-containers)
    - [Webserver Test Run](#webserver-test-run)
    - [Stop Container](#stop-container)
    - [Get New Docker Image](#get-new-docker-image)
    - [Create Docker Image](#create-docker-image)
    - [Remove Docker Image](#remove-docker-image)
    - [Pushing Images](#pushing-images)
- [Installing GUI's](#installing-guis)
  - [Unity](#unity)
  - [XUbuntu](#xubuntu)
  - [Cinnamon - Linux Mint](#cinnamon-linux-mint)
  - [GNOME](#gnome)
  - [KDE](#kde)
  - [LXQT](#lxqt)
  - [Pantheon - ElementaryOS](#pantheon-elementaryos)
  - [XFCE](#xfce)
- [Troubleshooting](#troubleshooting)
    - [Ubuntu Infinite Login](#ubuntu-infinite-login)
- [Linux Facts](#linux-facts)
- [Pythons](#pythons)
    - [pip installing packages](#pip-installing-packages)
    - [vscode python interpreter](#vscode-python-interpreter)
- [deeplearning](#deep-learning) 
    - [cuda](#cuda)
- [tool apps](tool-apps)
    - [remote connection](#remote-connection)
    - [mp4](#mp4)
- [environment](#environment)

# Common Commands
***
[(Back to Top)](#table-of-contents)

| Command        | Description                                                        |
|----------------|--------------------------------------------------------------------|
| :q             | exits: MAN pages, VIM                                              |
| clear          | dlears the terminal                                                |
| date           | current datetime                                                   |
| echo           | output to terminal                                                 |
| echo -e        | output with variables and  escape characters.                      |
| env            | See environment variables                                          |
| hostname       | See your hostname                                                  |
| locate crontab | I like mlocate more                                                |
| man ls         | manual to give you a list of all command arguments for any command |
| whatis ls      | tells you about the command                                        |
| whereis bash   | find absolute location of bash                                     |
| which python   | location of a program                                              |

# Apt
***
[(Back to Top)](#table-of-contents)

Apt (Or Aptitude) is the **package manager** for Ubuntu to manage packages.

> There are some alternatives worth noting such as AppImage files and Snap packages, but that is out of scope here.

> Tip: You can use the `-y` flag in any apt command to skip the `[Y/n]` dialog.

### Apt Install
-----------------------------
参考网址：https://www.cnblogs.com/EasonJim/p/7144017.html 
一、通过apt-get安装指定版本

apt-get install <<package name>>=<<version>>
二、查询指定软件有多少个版本

说明：在Linux用这个查询并不能完全的把所有版本都列举出来，因为每个版本都与系统版本和CPU架构有关，比如一个软件支持Ubuntu系统的16.04的CPU架构为amd64的版本只有1.0和1.2，其余都不支持，所以列举时就只有两款。

列举版本列表：

0、通过网站搜索：

https://packages.ubuntu.com/

1
apt-cache madison <<package name>>
将列出所有来源的版本。如下输出所示：

apt-cache madison vim
   vim | 2:7.3.547-1 | http://debian.mirrors.tds.net/debian/ unstable/main amd64 Packages
   vim | 2:7.3.429-2 | http://debian.mirrors.tds.net/debian/ testing/main amd64 Packages
   vim | 2:7.3.429-2 | http://http.us.debian.org/debian/ testing/main amd64 Packages
   vim | 2:7.3.429-2 | http://debian.mirrors.tds.net/debian/ testing/main Sources
   vim | 2:7.3.547-1 | http://debian.mirrors.tds.net/debian/ unstable/main Sources
复制代码
madison是一个apt-cache子命令，可以通过man apt-cache查询更多用法。

2
* apt-cache policy <<package name>>
将列出所有来源的版本。信息会比上面详细一点，如下输出所示：

* apt-cache policy gdb 
gdb:
  Installed: 7.7.1-0ubuntu5~14.04.2
  Candidate: 7.7.1-0ubuntu5~14.04.2
  Version table:
 *** 7.7.1-0ubuntu5~14.04.2 0
        500 http://fr.archive.ubuntu.com/ubuntu/ trusty-updates/main amd64 Packages
        100 /var/lib/dpkg/status
     7.7-0ubuntu3 0
        500 http://fr.archive.ubuntu.com/ubuntu/ trusty/main amd64 Packages
        500 http://archive.ubuntu.com/ubuntu/ trusty/main amd64 Packages

-----------------------------
You need super user permissions, or `sudo` before the command.

To install packages, let's use an example such as Ruby which should have a list of items.

_@note: <TAB> means press the tab key_

```sh
sudo apt install rub<TAB><TAB>
# You should see a list of ruby installables.
# If it's a long list you can type this is exit:
:q
```

```sh
sudo apt install ruby2.3
```

**TIP**: I like to add to my `~/.bashrc` file an alias for this as follows: `alias apt=sudo apt`

### Apt Update

Update will get the latest versions of all repositories (and custom ones you add in the future) and allow you to install
newer versions.

- This lists are in: `/etc/apt/sources.list.d/`

```sh
apt update
```

### Apt Upgrade

This will upgrade packages that have newer versions.

```sh
apt upgrade
# or, auto accept
apt upgrade -y
```

### Apt Remove

Removing a package is just as simple.

```sh
apt remove someprogram
# or, auto accept
apt remove someprogram -y
```

However, this will **not** remove configuration files, so if you were to re-install it they would be preserved.

You may also run the following:

```sh
apt purge someprogram
```

### Apt Lock Error

If you get an error such as `Unable to lock the administration directory (/var/lib/dpkg/) is another process`, follow
these steps:

- When you haven't booted in a while, be patient as this is one of the first things Ubuntu might do based on schedule.
  _~5 mins_
- Ensure another user is not running apt by typing: `who`
- See if this has many operation running: `ps aux | grep apt` (Should return one line, which has no results and just the
  command you typed)
- If you need to, delete the lock and archive files:
  - `rm /var/lib/apt/lists/lock`
  - `rm /var/cache/apt/archives/lock`
  - `dpkg --configure -a`
- If the above does not work. Reboot the OS.

# File Manager

- The default file manager is `nautilus`.
- Access From terminaal: `nautilus .`
- Otherwise press <kbd>SUPER</kbd> and type `files` to get to it.
  - Set a Hotkey: <kbd>Settings</kbd>, <kbd>CTRL+F</kbd>, search for `keyboard` or `shortcut`.
  - Change `Home Folder` to a hotkey of your choice, I prefer <kbd>SUPER + E</kbd> since I came from Windows.

# Listing and Navigating

***
[(Back to Top)](#table-of-contents)

| Command     | Description                                     |
|-------------|-------------------------------------------------|
| cd ..       | go down a directory                             |
| cd /        | go to lowest level                              |
| cd /var/www | go to absolute path                             |
| cd ~        | go to logged in user's home                     |
| ls          | list files                                      |
| ls -la      | list all files, ~~permissions~~, and hidden too |
| pwd         | print working directory                         |

### Manage Files and Folders

| Command           | Description                                  |
|-------------------|----------------------------------------------|
| cp -R <dir> <loc> | copy directory from location to new location |
| cp <file> <loc>     | copy file from location to new | location |
| mkdir <dir> | create a directory        |
| mv <dir> <loc>      | move directory from location | to new location |
| mv <file> <loc>     | move file from location to new | location |
| rm -rf <dir>        | remove a directory with | contents |
| rmdir <dir> | remove an empty directory |
| touch <file>        | create an empty file |

### Reading Files


| Command           | Description               |
|-------------------|---------------------------|
| cat <file>        | read entire file          |
| head <file>       | read top of a file        |
| head <file> -n 20 | read top of file 20 lines |
| tail <file>       | read bottom of a file     |
| tail <file> -f      | stream file as it's updated, | eg: an error log |
| tail <file> -n 20 | read bottom of file 20 lines |


# Users
***
[(Back to Top)](#table-of-contents)


| Command                                    | Description                     |
|--------------------------------------------|---------------------------------|
| passwd                                     | change logged in users password |
| su - username                              | switch users                    |
| sudo su                                    | switch to root                  |
| useradd -m -s /bin/bash username           | Create User                     |
| usermod -a -G existing_group existing_user | Add User to Group               |
| who                                        | show all logged in users        |
| whoami                                     | show which user you are         |

# Groups
***
[(Back to Top)](#table-of-contents)

Do not delete groups you don't know what they are used for, that's dangerous!


| Command       | Description                             |
|---------------|-----------------------------------------|
| groups        | see what groups current user belongs to |
| groupadd name | create a group                          |
| groupadd -g 900 name        |create a group with | custom GroupID aka gid|
|||
|groupdel name               |delete a group|
|useradd <group>             |add current user to a |group|
|usermod -aG <group> <user>  |append any user to an |additional group|
|||
|cat /etc/group              | list all groups|
|cut -d: -f1 /etc/group      | list all groups, cleaner|

# Permissions
***
[(Back to Top)](#table-of-contents)

There are two ways to manage permissions, one is by text the other is by an octal value.

### Easy Permissions
```
; Change Mode
; Options: (O)wner (U)sers (G)roup or (A)ll
; File:    Owner: rwx, Group: rwx, User: rwx
; Misc:    Besides rwx there is:
;          s = setuid of owner for old/new files

; Single File read/write permissions
chmod g+rw file
chmod og+rw file.txt

; Change Ownership
chown user:group files_or_folder
chgrp group files_or_folder

; Recursively:
chown -R user:group files_or_folder
chgrp -R group files_or_folder
chmod -R og+rw files_or_folder
chmod -R g+s files_or_folder
```

### Preserve Group Permissions
A fantastic way to structure your users is within groups. A common example would be your `www-data` group.
If I have a user `jesse`, I can add him with `sudo usermod -aG www-data jesse`.

After adding any users I would like, I want to have a folder where all the members of the `www-data` group
can read/write a folder. If they are using git, I also want the permissions to stay the same, meaning if they
pull the permissions will not change.

To accomplish this, here is an example:
```
sudo chown -R deploy:www-data /var/www
sudo chmod -R g+rws /var/www
```

The `g+s` sets the file(s)/folder(s) a gid (`setgid`) so that new files will inherit the original group!

### Octal Permissions
You may have seen this a lot, you can use octal or decimal (begins with a 0) to do the same thing.
```
Permissions:
0 = None
1 = Execute (e)
2 = Write (w)
4 = Read (r)
```

- There are 3 Permission types (Read, Write, Execute), or 4 if you count "None".
- There are 3 Sets: Owner/User/Group (In that order)
- So if you did `chmod 700 file.txt` it would allow the user to Read, Write and Execute
  - Because `7` is the total of `4 + 2 + 1`

### Octal Examples
```
chmod 600 file.txt – Owner Read, Write
chmod 660 file.txt – Owner Read, Write; User Read, Write
chmod 770 file.txt – Owner Read, Write, Execute
chmod 770 file.txt – Owner Read, Write, Execute; User Read, Write, Execute
chmod 666 file.txt – All Read, Write
chmod 777 file.txt – All Read, Write, Execute
```

# OS Details
***
[(Back to Top)](#table-of-contents)

Get fundamental information about your OS with the following commands, you may have to run them as `sudo`, eg: `sudo lsb_release -a`.

##  Operating System

```
lsb_release
lsb_release -a
lsb_release -as     # Short Information
lsb_release --help
```

### CPU Info

```
nproc               # How many Processing Units
cpuid               # Must install cpuid from terminal
cat /proc/cpuinfo   # Lots of info
```

### Usage Info

```
free -h             # Human readable, or do --help for options
vmstat -s
cat /proc/meminfo   # Lots of info
```

### Disk Space

```
df
df -B MB    (In Megabtyes, KB for Kilobytes, GB for Gigabytes)
```

### System Processes

```
top
htop  # If you installed it

jtop # jetson-stats is a package for monitoring and control your NVIDIA Jetson [Orin, Xavier, Nano, TX] series.
```

### IP Address
Your IP is after `inet addr`. If you are connect via ethernet it's under `eth0 (Ethernet)` otherwise, wirelessly it is likely under `wlan0 (Wireless LAN)`.

```
ifconfig
ip
ip addr show
ip addr show wlan
ip addr show eth0
```

### GUI Processes

```
gnome-system-monitor
```

### CLI Processes
```
top
htop     (My favorite, sudo apt-get install htop)
nmon
```

# List all Keybindings
***
[(Back to Top)](#table-of-contents)

```
gsettings list-recursively  org.gnome.desktop.wm.keybindings | sort | more
```

### See Keypressed
[(Back to Top)](#table-of-contents)

```
xev

; Or for a lot of details:

xev | grep KeyPress
```

# Kernal
***
[(Back to Top)](#table-of-contents)

The Kernal is the lowest level item that ties everything together from hardware to software.
Without a kernal you cannot do anything on linux.

### Remove Old Kernals

See What version you are currently using
```
sudo uname -a
```

See all the Kernals on the OS
```
sudo dpkg --get-selections | grep linux
```

The BYOBU is quite nice
```
sudo apt install byobu
sudo purge-old-kernels
```

# OS Shutdown
***
[(Back to Top)](#table-of-contents)
```
shutdown
reboot
shutdown -h now
shutdown -h +10     (shutdown 10 mins)
shutdown -r now     (reboot now)
```

# Crontab
***
[(Back to Top)](#table-of-contents)
```
crontab -e              (edit crontab for current user)
crontab -l              (list crontab for other user)
crontab -u jesse -l     (see crontabs for specific user)
```

# Services
***
[(Back to Top)](#table-of-contents)

## Service Commands
Use the service command *(Requires sudo)*
```
service ssh status      (service status)
service --status-all    (all services status)
```


Almost every service has the following commands, some may have more like apache `graceful-restart`:
```
service servicename start
service servicename stop
service servicename restart
service servicename status
service servicename force-reload
```

## Autostart

Add Service links:
```
sudo update-rc.d servicename defaults
```

Whether you get a warning if they already exist or not, enable it now:
```
sudo update-rc.d servicename enable
```

## Remove Autostart
Pass the Force flag
```
sudo update-rc.d -f servicename remove
```


## Autostart Daemons

There is are several startup popular daemons:
- CentOS uses SystemV
- Ubuntu 14 uses Upstart
- Ubuntu 14.10+ uses SystemD (15, 16, 17..)

Focus on **SystemD**.

## SystemD Commands
This would only apply to Ubuntu 14.10+, otherwise you would use Upstart.

```
systemctl     <-- You'll use this more often
journalctl    <-- You'll use this more often
update-rc.d   <-- You'll use this more often
                  --------------------------
                  Installs/Removes System-V style init script links
                  Note: System-V Style, but it's really SystemD. (Confusing huh?)

                  "NNname" is the runlevel, lower means startup sooner
                  ----------------------------------------------------
                  The Location is: /etc/rcrunlevel.d/NNname
                  The Target is:   /etc/init.d/name.
notify
analyze
cgis
cgtop
loginctl
nspawn
```

# System State
***
[(Back to Top)](#table-of-contents)
```
uname -a (get linux info)

top (See running processes/system status, I suggest installing `htop`)
top -u www-data
htop -u www-data

df          (display disk space in bytes, default)
df -h       (display disk space human readable)
df -Th      (display disk space with partitions)

free (see memory used)
free -g (in gigabytes)
```

# Processes
***
[(Back to Top)](#table-of-contents)
```
ps -ef | more       (current running processes)
ps -efH | more      (current running processes in a tree)

ps -ef | grep vim   (find vim process id)
kill -9 <id>        (no brackets)
```

# Bash
***
[(Back to Top)](#table-of-contents)

Bash is my shell of choice, which is why I have a `.bashrc` file.

### Bash Paths

Executables and commands are automatically in the path, see your path with:
```
echo $PATH
```

### Add to Path

```
# I suggest editing your ~/.profile

vim ~/.profile
if [ -d "/path/to/your/bin" ] ; then
  PATH="/path/to/your/bin:$PATH"  这样写的好处是能保留PATH本身的值，从而避免出现一些问题。将$PATH 放在后面的好处是，让你指定的path的优先级更高。因为你指定的路径中的文件可能是PATH默认值中的文件的替代版本。
fi
```

*Note: Order of Linux Reading files: ~/.bash_profile, ~/.bash_login, and ~/.profile, so don't try to use a ~/.profile variable within ~/.bash_profile*

### Bash Completions

The locations for bash completio0ns can be found at:
```
cd /usr/share/bash-completion/completions.d/
cd /etc/bash_completions.d/
```

### Fix Broken Bash Completions

```
sudo apt-get install --reinstall bash-completion
```

### Log Script from Bash
At the top of your file, find the executable you are using one of these, eg:
```
which bash     # /usr/bin/bash
which python   # /usr/bin/python
which php      # /usr/bin/php
```

At the top of your [shebang](https://en.wikipedia.org/wiki/Shebang_(Unix)) for the executable file add:

```
#!/bin/bash
#!/usr/bin/php
#!/usr/bin/python
```

make sure to `+x` it:
```
chmod +x app.sh
chmod +x app.php
chmod +x app.py
```

You can then run the script via Bash:
```
/scripts/app.sh >> /scripts/output.log 2>&1
/scripts/app.php >> /scripts/output.log 2>&1
/scripts/app.py >> /scripts/output.log 2>&1
```

You could even crontab it the same way:
```
*/10 * * * * app.php >> /output.log 2>&1
*/10 * * * * app.py >> /output.log 2>&1
```

# Finding Files
***
[(Back to Top)](#table-of-contents)

Generally the following arguments are as follows:
- `-type f` file
- `-type d` directory
- `-iname` case insensistive (book.txt would the same as BOOK.TXT)
- `*` is a wildcard to find anything, usually you put it at the start or end of a filename.
```
find . -name tecmint.txt
find /home -name tecmint.txt
find /home -iname tecmint.txt                        (case ignore)
find / -type d -name Tecmint                         (directory)
find . -type f -perm 0777 -print (with perms)
find / -type f ! -perm 777 (find without)
find . -type f -name "tecmint.txt" -exec rm -f {} \; (find and remove a file)
find . -type f -name "*.txt" -exec rm -f {} \;       (find and remove multiple)
find /tmp -type f -empty                             (Find empty files)
find /tmp -type d -empty                             (find empty directories)
find / -size +50M -size -100M (findby swize)
```

# Find in Files (GREP)
***
[(Back to Top)](#table-of-contents)

GREP means: Global Regular Expression Pattern (or Parser)

Some common GREP flags:
- `-r` is Recursive
- `-n` is Line Number
- `-w` Match the whole word
- `-l` is lowercase only
- `-c` supresses normal output and counts number of matching lines

```
grep -rn /path - "pattern_or_string"

; Output results to File
grep -rnw /path - "pattern_or_string" > output.txt
```

Look only in certain filetypes
```
; notice I used a regex ^ starts with, you can use a string or regex
grep --include=*.sh '^mysql' ./
```

More Examples:
```
grep "hello" file.txt (if in file)
grep "hello" files*  (if in many files)
grep -i "hello"  file.txt  (case insesitive)
grep -iw "is" file.txt (get full words, case insensitive)
grep "regex" file.txt
```

### Pipe Grep
```
php -i | grep ini
```

# Reading Files
***
[(Back to Top)](#table-of-contents)

Without having to open a file you can simply read a part of it without `nano`, `pico, `vi`, or `vim`:
```
cat file.txt            (view file contents)
tail file.txt           (view end of file contents)
tail -n20 file.txt      (view top 20 lines)
tail -f filetxt         (follow a filename keep updating)
head file.txt           (view top of file contents)
head -n20 file.txt      (view top 20 lines)
```

# Downloading Files
***
[(Back to Top)](#table-of-contents)

### Using Wget
```
wget http://file.com/something.txt                (Download a file locally)
wget -O newname.txt http://file.com/something.txt (Download file locally w/new name)
```

You can also use `SCP`, yet the above are easier for non-SSH connections.

### Using cURL
```
curl -O http://file.com/something.txt               (Download a file locally)
curl -o newname.txt http://file.com/something.txt   (Download file locally w/new name)
curl -O http://url_1 -O http://url_2                (Download multiple files)
```

# Compressing and Uncompressing Files
***
[(Back to Top)](#table-of-contents)

To Compress a file you can use a variety of tools. You can type `man gzip` to see the full manual and line of commands, and use `esc` + `:x` and `ENTER` to exit from the Manual (It usually uses the Vi editor).

Most often in the Linux word you use and create `*.tar.gz` files, it has the most options. Whatever you prefer is up to you.

What the flags often stand for:
- `-c` is create
- `-f` is file
- `-k` is for Keep
    - `gzip` & `bzip2` will remove the original file once compressed
    -  Or they will remove the `.gz` when decompressing is done
- `-r` is recursive (for gzip and zip)
- `-v` is verbose (show details of what's happening)
- `-z` is for tar to gzip as well
- `--exclude='file'` is for tar (+gz if needed) to exclude certain files)

###  Compressing Files
Note: You can compress more than one file at a time eg: `bzip2 file1.txt file2.txt file3.txt`

```
gzip -vk file.txt                   (Creates file.txt.gz)
bzip2 file.txt                      (Creates  file.txt.bz2)
tar -cvf file.tar file.txt          (Creates tar)
tar -czvf file.tar.gz file.txt      (Creates tar.gz)
zip filename.zip file.txt           (Creates filename.zip)
zip -r folder.zip path/to/folder    (Creates  folder.txt.bz2)
```

Include/Exclude a few files:
```
; Exclude certain files
tar -czvf file.tar.gz <directory>/ --exclude='*.jpg' --exclude='bigfile.sql'

; Include one file type
tar -czvf file.tar.gz <directory>/*.sh

; Include multiple files types
tar -czvf file.tar.gz `find <directory> | grep '.sh\|.py'`
```

### Decompressing Files
To Uncompress we use similar commands for most of them
```
gunzip -dvk file.txt.gz
gzip -dvk file.txt.gz       (Same as above)
bzip2 -d file.txt.bz2
tar -xvf file.tar
tar -zxvf file.tar.gz
unzip test.zip
```

# SCP
***
[(Back to Top)](#table-of-contents)

### Download from server to local
```
scp root@server.com:/path/to/file.txt file.txt
```

### Upload from local to server
```
scp file.txt root@server.com:/path/to/file.txt
```

# SSH
***
[(Back to Top)](#table-of-contents)

### Connecting to a server
```
ssh name@server.com  (default port is 22)
ssh name@server.com -p 8000 (connect to specific port)
ssh name@server.com -i ~/.ssh/rsa_key.pub (connect with ssh key)
```

### .SSH Permissions

These are safe permissions to use for SSH
```
chmod 700 ~/.ssh
chmod 644 ~/.ssh/id_rsa.pub
chmod 600 ~/.ssh/id_rsa

# Put your pubkeys (one per line) for SSH login
chmod 600 ~/.ssh/authorized_keys
```


### Using the Config
You can also create a `~/.ssh/config` file and store entries such as:
```
Host aws
Hostname ec2-50-50-130-50.compute-1.amazonaws.com
Port 22
Identityfile ~/.ssh/id_rsa
User myusername

Host my-vps
Hostname 50.50.130.50
Port 22
User root
```

You can then simply type:
```
ssh aws
ssh my-vps
```

### SSH to PEM
Sometimes you may need a `PEM` format SSH Key. You can easily add this alongside your other SSH keys.
```
openssl rsa -in ~/.ssh/keyname_rsa -outform pem > keyname_rsa.pem
chmod 700 keyname_rsa.pem
```

# Firewall
***
[(Back to Top)](#table-of-contents)

A firewall prevents unauthorized access to your machine, you should use `UFW` (Uncomplicated Firewall). You must always run this with `sudo`. If you don't have UFW installed, run:

```
sudo apt-get install ufw
```

### UFW Status
To see the Firewall Status run one of these:
```
sudo ufw status
sudo ufw status verbose
```

### UFW Enable/Disable
```
sudo ufw enable
sudo ufw disable
```

### UFW Example Customization
Please do not do this unless you know what you are doing.

You could start out with blocking all incoming connections.
```
sudo ufw default deny incoming
sudo ufw default allow outgoing
```

Then we allow only what we want
```
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw allow ftp
```

These are the same as:
```
sudo ufw allow 22   # same as ssh
sudo ufw allow 80   # same as http
sudo ufw allow 443  # same as https
```

### UFW More Options

If SSH was on port `3333` rather than the default `22` you would do:
```
sudo ufw allow 3333/tcp
```

Some more options:

```
sudo ufw allow 25 # SMTP
sudo ufw allow 110 # POP3
sudo ufw allow 995 # POP3S
sudo ufw allow 143 # IMAP
sudo ufw allow 993 # IMAPS
sudo ufw allow 3306 # MySQL
sudo ufw allow 5432 # Postgres
sudo ufw allow from 192.168.255.255 # Custom IP Address
```

### UFW Deleting Rules
Easily delete named rules
```
sudo ufw delete allow ssh
```

Delete rules that are numbered
```
sudo ufw status numbered
sudo ufw delete [number]
```

### UFW Reset Rules
```
sudo ufw reset
```

# Regex
***
[(Back to Top)](#table-of-contents)

Regex stands for Regular Expression. It's used for locating or replacing files or
strings of text. It is used all the time. These can be used in Linux itself and programming
languages.

```
; Symbolism
; ------------------
()          (captures groups)
[]          (set)
{}          (quantifier)
?           (optional, matches 0 or 1 character)
*           (matches 0 or more characters)
.           (match any character)
+           (match one or more character)
\           (escape character)
!           (false, is not)
^           (starts with)
$           (ends with)
|           (or statement, eg: (jesse|dan|jenkins) )

; Basic Primer
; ------------------
\w          (word)
\W          (non-word)
\s          (whitespace)
\S          (non-whitespace)
\d          (digit)
\D          (non-digit)
[ab]        (character set)
[^ab]       (negated set)
[a-m]       (range)
(hello)     (group)
(hello)+    (group, more than once)

; Groups
; ------------------
(hi)        (gets all "hi" occurances)
(^hi)       (gets all text starting with "hi")
(es$)       (gets all text ending with "es")
(hi)\1      (gets the first occurance of "hi")

; Flags
; ------------------
/i          (case insensitive)
/g          (global)
/m          (multiline)

; Escaped Characters
; ------------------
; Since characters such as ".", "+", etc are actual Regex pattern makers, if you
; need to check your content for the literal item you must escape them.
\.          (matches . character)
\+          (matches + character)
\?          (matches ? character)
\*          (matches * character)
\^          (matches ^ character)
\$          (matches $ character)
\[          (matches [ character)
\(          (matches ( character)

\t          (matches tab character)
\n          (matches newline)
\r          (matches return carriage)
\0          (matches NULL character)
\\          (matches \ character)
\/          (matches / character)
```

### Regex Examples
```
Put Examples here, like phones, names, etc..

```

# MySQL
***
[(Back to Top)](#table-of-contents)

- `-u` is for User (default: root)
- `-p` is for Password
- `-p password` is for password which skips the prompt (not recommended)
- `-h` is for host (default: localhost)
- `-port or -P` is for a port, default is 3306
- `-f` will force SQL import and skips errors
- `-v` will display verbose output
- In the `mysql>` terminal you can get clean data by doing `\g`:
    - `mysql> SELECT * FROM users LIMIT 10\g";`

### Connecting
```
mysql -u root -p (username, password prompt)
mysql -u root -p -h localhost (username, password prompt, host)
mysql -u root -p password -h localhost -P 3306

; AWS Example (AWS Defaults to 3306 as most MySQL connections do)
mysql -u username -p password -h myinstance.123456789012.us-east-1.rds.amazonaws.com
```

### Exporting Database to SQL
You can dump a single database easily:
```
mysqldump -u root -p DATABASE_NAME > file.sql
```

Or Dump all databases on your MySQL server with the `--all-databases` flag:
```
mysqldump -u root -p --all-databases > file.sql
```

### Importing SQL Files
You can do this through the shell only, or MySQL, first is the shell:
```
mysql -u root DATABASE_NAME < path/to/file.sql
```

To continue when there are MySQL Errors use -f or --force below:
```
mysql -u root DATABASE_NAME < path/to/file.sql --force
```

To use a password, just pass in the -p flag and type it in after running:
```
mysql -u root -p DATABASE_NAME < path/to/file.sql --force
```

Second, you can do it through MySQL once you connect:
```
mysql> use DATABASE_NAME;
mysql> source path/to/file.sql;
```

### Exporting Compressed Database
This will save a lot of space in this one liner:
```
mysqldump -u root -p DATABASE_NAME | tar -cvzf > output.sql.tar.gz
mysqldump -u root -p DATABASE_NAME | gzip -v > output.sql.gz
```

### Importing Compressed Database
Here is how you can import with the one liner:
```
mysql -u root -p DATABASE_NAME | tar -xzOf output.sql.tar.gz
mysql -u root -p DATABASE_NAME | gunzip < output.sql.gz
```

### Get Database Encoding
```
USE DATABASE_NAME;
SELECT @@collation_database;
```
### Get Table Encoding
```
SELECT default_character_set_name FROM information_schema.SCHEMATA
WHERE schema_name = "TABLE_NAME";
```

### Get Column Encoding
Look at the collation table. Numeric fields won't have a collation.
```
SHOW FULL COLUMNS FROM TABLE_NAME
```

### Fix Broken Characters

First, try this query without affecting anything to see:
```
SELECT CONVERT(BINARY CONVERT('Weâ€™re Here!' using latin1) using utf8);
```
That should fix the encoding problem.

To update a column:
```
UPDATE TABLE_NAME SET COLUMN_NAME = CONVERT(BINARY CONVERT(COLUMN_NAME using latin1) USING utf8);
```

# Git
***
[(Back to Top)](#table-of-contents)

### Populate a Repository
You have to first create a repostory, through BitBucket, GitHub, GitLab, etc.
```
git init
touch README.md
git remote add origin git@github.com/username/yourrepo.git
git add .
git commit -m "Starting with one file"
git push origin master
```
### Add or Remove Files
use 'git add file.txt' to add a file into INDEX
use 'git reset file.txt' to move a file out of INDEX

```
git add file.txt 
git rm file.txt
```
将某个文件从暂存区中移除：
```
git reset file.txt
```

将所有文件从暂存区中移除：
```
git reset 
```

### Ignoring files
Create a `.gitignore` file, and place something like this in it:
```
*.tmp       # 
*.py        # 忽略后缀为 py 的文件
*.cache     #
/tmp        # 忽略文件夹
/*/build    # 忽略所有子目录下的build目录
/*/*.pt     # 忽略所有子目录下以.pt为后缀的文件
```
### 忽略已经在仓库中的文件，ignore已经追踪的文件和文件夹
主要解决不能add文件或者目录的问题
解决嵌套git带来的问题
解决无法追踪某些子目录中的文件的问题
https://zhuanlan.zhihu.com/p/139950341 
  git rm --cached hello.txt 
  OR
  git rm -rf --cached vendor/crazyfd/yii2-qiniu 后面这个是目录名

### .gitkeep
gitkeep 的功能类似于占位符
https://www.jianshu.com/p/2507dfdb35d8
### Create a Branch
Branches are used like when you don't want to ruin a main branch with working code.

```
git checkout -b develop
git push origin develop
```

### Switch Branches
```
git checkout master
git checkout develop
```

### Pull One File From Another Branch
If you were on your `master` branch and only wanted to pull a single file from `develop` branch, you can do this:
```
; Make sure you're on the branch you want to pull into
git checkout master

; Pull a single file into master from develop
git checkout develop -- relative/path.txt

; Continue by comitting and pushing to master
```

### Create a Tag
Tags create a snapshots of current code, you may name it as a version such as `1.0.1` and it produces a `tar.gz` and `zip` format for downloads.
```
git tag -a 1.0
git tag -a 1.0 -m "Optional Message"
git push --tags
```

### Remove a Tag
This will remove a tag from the Git host.
```
git tag -d 1.0
git push origin :refs/tags/1.0
```

### Clone a Respository
```
git clone git@github.com/username:your_repo.git
```

Clone into current directory
```
git clone git@github.com/username:your_repo.git .
```
### Current Status
```
git status
```

### Commit Log and Show
To see log data and more details use the short or long commit ID.
```
git log
git show eb7c86a5fbdc6c64df608f4c143c2718a100983b
```

### Reset Hard
This will reset your repository to the last revision and undo everything, use with caution.
```
git reset --hard HEAD
```

### Prune
Removes cached items no longer read by git
```
git prune
```

# Docker
***
[(Back to Top)](#table-of-contents)

To install visit [https://docs.docker.com/engine/installation/linux/ubuntulinux/](https://docs.docker.com/engine/installation/linux/ubuntulinux/)
- **Images**: (Blueprints of an application)
    - **Image BASE**: No parent Image (An OS)
    - **Image CHILD**: Builds on a Base Image (Eg: Webserver, MySQL)
- **Containers**: Created from an IMAGE and run an application.
- **Docker Daemon**: Background service that builds, runs, and does everything.
- **Docker Client**: Allows us to interact with the Docker Daemon.
- **Docker Hub**: A registry of images (Like: npmjs, pip, packagist, bower)

### Docker Compose
This is a great utility that makes managing docker easier from a `docker-compose.yml` file, you should install this after playing around with the below options. See: [https://docs.docker.com/engine/installation/linux/ubuntulinux/](https://docs.docker.com/engine/installation/linux/ubuntulinux/)
```
docker-compose up
open http://localhost:3000
```
基本信息：




### Test Box Run
This is a sample box to test once you installed docker
```
dock pull busybox
docker images
docker run busybox "Hi from the box"
```

### See Running Containers
```
docker ps (running containers)
docker ps -a (see all containers that ran)
```

### Run Container Interactively
This allows you to get inside the container
```
docker run -it busybox sh (interactive)
```


### Remove Container
Removes a CONTAINER, not an IMAGE

```
docker ps -a
docker rm <CONTAINER ID>
```

### Bulk Remove Containers
You can remove containers based on their status in bulk, eg:
```
docker rm $(docker ps -a -q -f status=exited)
docker rm $(docker ps -a -q -f status=created)
```

### Webserver Test Image
This will download the IMAGE and run it if it doesn't exist
```
docker run prakhar1989/static-site
```

This doesn't expose ports for us to use, so we do the following:
```
docker run -d -P --name static-site prakhar1989/static-site
```

- `-d` detaches terminal so we can run commands in our terminal
- `-P` publishes all exposed ports to random ports

By doing the above command we are given random ports, eg:
```
  443/tcp -> 0.0.0.0:32768
  80/tcp -> 0.0.0.0:32769
```

Your ports may be different, you can use specific ports with a lowercase `-p`:
```
docker run -p 8888:80 prakhar1989/static-site
```

### Stop Container
```
docker stop static-site
```

### Get New Docker Image
This would be a docker BASE IMAGE
```
docker pull ubuntu:14.04
```

### Create Docker Image
This is a flask Example using a Python-3 Base IMAGE

- Create `requirements.txt` and just put `flask`
- Create an `app.py`
- Use the following sample code in `app.py`:

```
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World!'
```

- Create a docker file, title it `Dockerfile`
- Enter the following

```
FROM python:3-onbuild
EXPOSE 5000
CMD ["python", "./app.py"]
```

Now build the image

```
docker build -t boyus .
docker images
```

### Remove Docker Image
Get a list of images, then just delete by image id with `rmi` aka `remove image`:
```
docker images
docker rmi <IMAGE ID>
```


### Pushing Images
You need a repository at docker.io to push this, or probably some private hosting.
```
docker push boyus
```


# Installing GUI's
***
[(Back to Top)](#table-of-contents)

Linux has a lot of GUI's and you are not limited to what you get. I'll list a few popular ones with the installation instructions in Ubuntu. You can have as many GUI options as you like, just change the default at the login screen.

> Tip: After you install, logout and in the login menu or the top right you can select what GUI you want to login with. Whenever you install a new GUI you can select a Display Manager, I recommend using `lightdm`.

--

### Unity

[**Unity Website**](https://unity.ubuntu.com/)

```
Installed in Ubuntu 12+ by Default (`ubuntu-desktop`)
```

### XUbuntu

[**XUbuntu Website**](https://xubuntu.org/)

```
; Install:
sudo apt-get install xubuntu-desktop

; Remove:
sudo apt-get remove xubuntu-desktop
```

### Cinnamon (Linux Mint)

[**Linux Mint Website**](https://www.linuxmint.com/)

```
; Install:
sudo add-apt-repository ppa:moorkai/cinnamon
sudo apt-get update && sudo apt-get install cinnamon

; Remove
sudo ppa-purge ppa:moorkai/cinnamon
```


### GNOME

[**GNOME Website**](https://www.gnome.org)

This has been one of the all time most popular GUI's for Linux ever made, in particular the `gnome-classic`.

```
; Install:
sudo apt-get install ubuntu-gnome-desktop    (For legacy gnome use you can use gnome-shell, this install both)

; Remove:
sudo apt-get remove ubuntu-gnome-desktop     (Removes gnome-shell as well)
```

> Gnome3 has been my favorite GUI due to how I can customize it. However, for unknown reasons I have issues running only Gnome3 in VMWare Workstation 11. It works fine as a complete install.

Noteworthy: Visit [Gnome Shell Extensions](https://extensions.gnome.org/) to customize anything you want. Make sure to use Firefox.


### KDE

[**KDE Website**](https://www.kde.org/)

This is a very popular GUI for people that are used to Windows Desktops.

```
; Install:
sudo add-apt-repository ppa:kubuntu-ppa/backports
sudo apt-get update && sudo apt-get dist-upgrade
sudo apt-get install kubuntu-desktop

; Remove:
sudo apt-get remove kubuntu-desktop
```

### LXQT

[**LXQT Website**](http://lxqt.org/)

```
; Install:
sudo apt-get install lxqt
; Remove:
sudo apt-get remove lxqt
```

### Pantheon (ElementaryOS)

[**Elementary OS Website**](https://elementary.io/)

For the best stability I use Elementary OS which is based off of Ubuntu.

```
; Install:
sudo add-apt-repository ppa:elementary-os/stable
sudo apt-get update
sudo apt-get install elementary-desktop

; Remove:
sudo apt-get remove elementary-desktop
```

### XFCE

[**XFCE Website**](http://www.xfce.org/)

```
; Install:
sudo apt-get install xfce4

; Remove:
sudo apt-get remove xfce4
```

# Troubleshooting
***
[(Back to Top)](#table-of-contents)

Sometimes the system has problems, seldmoly but I'll list things that helped me fix rare occasions.

### Ubuntu Infinite Login
When you try to login to Ubuntu and it relogs you back into the login screen, this is an infinite loop. The only way I was able to fix it depsite all the guides was combining a few of these together for Ubuntu 16.04.

If you are using Gnome as I do, I would jump down to the **Apt Auto Remove Problem** in the list.

The first step is to login to a terminal.

```
CTRL + ALT + F1  (Or F3)
```

Next, Login as your user who must be able to run `sudo`.

- **Temp Folder Permissions**
  - `ls -ld /tmp` should have these permission exactly as: `drwxrwxrwt`
  - The user:group must be `root:root` on `/tmp`.
  - To Fix: `sudo chmod a+wt /tmp`
- **Xauthority Ownership**
  - `ls -lta | grep .Xa` should be owned by your user, for example `jesse jesse`
   - If it is `root root` or anything than your user/group it's wrong.
   - To Fix: `sudo chown jesse:jesse .Xauthority`
- **Xsession Errors**
  - This is just to make sure there are no syntax errors for your reference:
    - To Check: `cat ~/.xsession-errors`
    - You don't need to do anything if there are syntax errors, we will move the file.
- **Try Moving XAuthority**
  - Sometimes it's as easy to moving Xauthority so a new is generated at login.
  - To Fix: `sudo ~/.Xauthority ~/.Xauthority.bkup`
- **Try Reconfiguring LightDM**
  - Fix: `dpkg-reconfigure lightdm`, then select lightdm in the menu
  - Lastly restart lightdm: `sudo service lightdm restart`
- **Apt Auto Remove Problem**
  - I read that it's possible `apt-autoremove` may accidentally remove `xubuntu-desktop`, `ubuntu-desktop` and LightDM reports no errors.
    - The `ubuntu-desktop` will load the Unity interface
    - The `xubuntu-desktop` will load a different interface I'm not familiar with.
    - To Fix: `sudo apt-get install xubuntu-desktop ubuntu-desktop`
  - **If you are using Gnome**, try following the post at [OMGUbuntu](http://www.omgubuntu.co.uk/2016/05/install-gnome-3-20-ubuntu-16-04-lts)
    - After the Above Try: `sudo apt-get autoremove gnome-software && sudo apt-get install gnome-software`
    - I was able to get Gnome-Classic working but not Gnome.
- **How to Ensure it Works**
  - You might be able to login after one of the steps above if you don't reboot. However, to be certain, you want to reboot to ensure it is fixed, otherwise you'll be doing this over and over.

# Linux Facts
***
[(Back to Top)](#table-of-contents)

- **Linux Versions** refers to The Kernel which ties the OS together.
- **Linux Distributions** are the named Linux "Flavors" below.
  - **Debian**
    - **Linux Mint** (LMDE) forked from Debian
    - **Ubuntu** forked from Debian
      - **Elementary OS** forked from Ubuntu
      - **Linux Mint** forked from Ubuntu
      - **Kubuntu** forked from Ubuntu
  - **Fedora**
    - **Red Hat Enterprise Linux** (RHEL) forked from Fedora
      - **CentOS** forked from RHEL (Community Edition of RHEL)
  - **Gentoo**
- ..And many others. Debian -> Ubuntu has been the most popular.

# pythons

### pip installing packages
pip 的安装路径可能在下面的几个目录中：
1 /home/seelur/.local/lib/python3.8/site-packages
2 /usr/lib/pythonx

查看pip的安装路径的办法：
1 输入命令pip list，在输出列表的顶部可以看到一个安装路径。
2 在.py文件中import的地方，用ctrl + 鼠标左键的方式打开源文件，在scode的顶部能看到文件所在路径。

pip换源:
1.临时换源：清华源
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple package_name
2.永久还原：
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

查看安装包可选版本的方法，以django包为例子：
pip install django==
安装指定版本的包：
pip install django==1.1.4

卸载 pip 安装的包：
pip uninstall package_name


### vscode python interpreter
修改python解释器，先按组合键：
```
ctrl+shift+p 
```
然后输入：
```
python interpreter
```

# deep learning

### cuda
What is CUDA?
CUDA is a "parallel computing platform and programming model" invented by NVIDIA. 
It enables dramatic increases in computing performance by harnessing 
the power of the graphics processing unit (GPU). 

Install cuda:
'''
https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#verify-you-have-cuda-enabled-system
'''

Check if installed cuda & check the version of cuda:
reference: https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#verify-driver

'''
cat /proc/driver/nvidia/version
'''

OR use command below to see if the NVIDIA Persistence Daemon is active:
'''
systemctl status nvidia-persistenced
'''

多版本cuda/多版本nvcc：
NVCC详解 - https://zhuanlan.zhihu.com/p/91334380
简单来说就是 CUDA Toolkit中包含了显卡驱动和NVCC，但是在安装的时候，最好选择不安装显卡驱动。这样就不会导致Ubuntu‘出问题’了。
安装多个版本的coda toolkit之后，只用修改 /usr/local/cuda 这个软连接（软链接）就好。 可以用 ll 指令查看软连接（软链接）指向的谁。

在安装 cuda toolkit的时候，可移是通过 .run文件安装，并且取消勾选显卡驱动，只安装和nvcc 相关的内容。
还可以通过 .deb 文件进行安装，只是安装完之后不要继续“Driver installer”那部分就行。
安装完之后，记得在环境变量中添加：
```sh
# add nvcc compiler to path
export PATH=$PATH:/usr/local/cuda-10.1/bin
# add cuBLAS, cuSPARSE, cuRAND, cuSOLVER, cuFFT to path
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-10.1/lib64
```
这里有多种选择。但最好不要像上面这样直接指定版本，而是先修改 /usr/local/cuda 这个软连接，然后在环境变量中直接使用 /usr/local/cuda。

# tool apps
## remote connection

  远程连接的工具有很多，其中adb、nomachine、mobaxterm都是可以选择的工具。
  adb用于连接安卓系统。
  nomachine、mobaxterm 则可以用于连接其他linux操作系统。

## mp4

在Ubuntu系统中用Kazam录屏产生的mp4文件在windows中不能播放，需要对文件执行下面的命令才能成功：
ffmpeg -y -i Kazam_screencast_00001.mp4 -c:v libx264 -c:a aac -strict experimental -tune fastdecode -pix_fmt yuv420p -b:a 192k -ar 48000 5_crossrods.mp4

# 软链接 软连接
ln -s source dist
source:文件原始地址
dist：文件想要建立链接的位置/ 软链接的名字

# 终端命令使用技巧
==find命令进阶（二）：对找到的文件执行操作exec
  对find命令的结果进行操作、执行find命令寻找的结果
  find ~ -type f -name 'foo*' -exec ls -l '{}' ';'

==将终端命令的结果存到变量中
  Shell 命令替换是指将命令的输出结果赋值给某个变量。
  Shell 中有两种方式可以完成命令替换，一种是反引号` `，一种是$()，使用方法如下：
  variable=`commands`
  variable=$(commands)

# 记录进程的资源消耗
记录进程占用的额CPU和内存资源

==方法1：
shell脚本：
    #!/bin/bash
    # 进程的名字
    PROCESSES=("n_v_decision/n_v_decision" "n_local_planning/n_local_planning" )
    # 每个进程对应的日志文件的名字，注意和PROCESSES保持一样的长度
    LOG_FILES=("n_v_decision_process_info_log.txt" "n_local_planning_process_info_log.txt")
    #过滤出需要的进程ID
    PIDS=()
    for process in ${PROCESSES[@]}
    do
        echo "The value is: $process"
        PID=$(ps aux| grep $process | grep -v 'grep' | awk '{print $2;}')
        PIDS[${#PIDS[@]}]=$PID
    done
    echo ${PIDS[*]}


    ########## 将所有的日志信息放到多个文件中 ###########
    for log_file in ${LOG_FILES[@]}
    do
        #删除上次的监控文件
        if [ -f "$log_file" ];then
            rm "$log_file"
        fi
        # 重新创建对应的文件
        echo "USER        PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND" >> "$log_file" 
    done
    echo ${LOG_FILES[*]}

    # 记录日志信息到文件
    while :
    do
        for ((i = 0; i<${#PIDS[@]}; i++)) do
            echo $(ps aux| grep ${PIDS[i]}| grep -v 'grep') "">> "${LOG_FILES[i]}"
        done;
        sleep 5
    done
    ########## 将所有的日志信息放到多个文件中 END ###########

==方法2：
用C++代码实现：
    #include <iostream>
    #include <memory> // popen, pclose, unique_ptr
    #include <string>
    #include <array>
    #include <unistd.h> // getpid
    #include <vector>
    #include <string.h> // strtok

    // 通过命令行获取资源占用情况
    std::string GetResourceOccupationInfo() {
        std::string command("ps -aux | grep ");
        command += std::to_string(getpid());
        std::array<char, 1024> buffer;
        std::string result;
        // 执行命令并获取返回值
        std::unique_ptr<FILE, decltype(&pclose)> pipe(popen(command.c_str(), "r"), pclose);
        if (!pipe) {
            throw std::runtime_error("popen() failed!");
        }
        // 读取返回值
        if (fgets(buffer.data(), buffer.size(), pipe.get()) != nullptr) {
            // USER        PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
            std::vector<std::string> tokens;
            // 用 strtok 将返回的字符串进行分割，分隔符是 ' '
            auto item = strtok(buffer.data(), " ");
            while (item != NULL) {
                printf ("%s\n", item);
                tokens.push_back(std::string(item));
                item = strtok (NULL, " ");
            }
            // 添加注释信息
            result += "PID: " + tokens[1] + 
                      "; CPU(%): " + tokens[2] +
                      "; MEM(%): " + tokens[3] + 
                      "; name: " + tokens[10];
        }
        if(!result.empty()) {
            return result;
        } else
            return "GetResourceOccupationInfo: Error";
    }
    
    int main()
    {
        std::string result = GetResourceOccupationInfo();
        std::cout << result;
        return 0;
    }

==方法3：
搜索：知乎 C++获取对应进程的cpu和内存使用情况（支持linux和windows）



# 用shell脚本记录进程的资源使用情况
  处理过程中遇到的问题是 awk '{print $2;}' 是将每行的第二列打印出来。但是打印出来的结果不是用空格作为分隔符。
  这就导致不能直接用于命令。
  解决办法是，当发现用echo输出 awk '{print $2;}' 的结果时，会用空格作为分隔符。
  因此将echo的结果拿回来，对空格进行替换。
  注意区分：ps输出的资源占用是从进程开始运行到现在的的CPU时钟占比。也就是说并不是实时的。
  而top命令输出的CPU占比则是从上一次screen update到现在的CPU占比，换句话说就是实时性更加好。

  使用top命令时，建议使用：
  `top -n 1 -b | grep -E ${PIDS[i]}| grep -v 'grep'  >> ${LOG_FILES[i]}`
  注意加上-b，不然输出的内容包含了格式字符，在log文件中显示为乱码。
```sh
    #!/bin/bash
    # 进程的名字，支持一个名字对应多个PID。
    PROCESSES=("n_v_decision/n_v_decision" 
              "n_local_planning/n_local_planning" 
              "/usr/bin/gnome-shell")
    # 每个进程对应的日志文件的名字，注意和PROCESSES保持一样的长度
    LOG_FILES=("n_v_decision_process_info.log" 
              "n_local_planning_process_info.log"
              "gnome-shell_info.log")
    #过滤出需要的进程ID
    PIDS=()
    for process in ${PROCESSES[@]}
    do
        echo "The value is: $process"
        PID=$(ps aux| grep $process | grep -v 'grep' | awk '{print $2;}')
        PIDS[${#PIDS[@]}]=$PID
    done
    echo ${PIDS[*]}
    echo ${#PIDS[@]}

    # 对于一个name对应多个ID的情况，需要将换行符切换为 "|"，方便grep -E 进行多关键字匹配
    for ((i = 0; i<${#PIDS[@]}; i++)) do
        c=`echo ${PIDS[i]}`
        c=${c/" "/"|"}
        PIDS[i]=${c}
    done;
    echo ${PIDS[*]}
    echo ${#PIDS[@]}

    ########## 将所有的日志信息放到多个文件中 ###########
    for log_file in ${LOG_FILES[@]}
    do
        #删除上次的监控文件
        if [ -f "$log_file" ];then
            rm "$log_file"
        fi
        # 重新创建对应的文件
        echo "   PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND" >> "$log_file" 
    done
    echo ${LOG_FILES[*]}

    # 记录日志信息到文件
    while :
    do
        for ((i = 0; i<${#PIDS[@]}; i++)) do
            # echo "$(ps aux| grep -E ${PIDS[i]}| grep -v 'grep') " >> "${LOG_FILES[i]}"
            `top -n 1 -b | grep -E ${PIDS[i]}| grep -v 'grep'  >> ${LOG_FILES[i]}`
        done;
        sleep 5
    done

    # ########## 将所有的日志信息放到一个文件中 ###########
    # LOG="./process_info_log.txt"
    # #删除上次的监控文件
    # if [ -f "$LOG" ];then
    # rm "$LOG"
    # fi
    # echo "USER        PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND" >> "$LOG" 
    # while :
    # do
    #     for pid in ${PIDS[@]}
    #     do
    #         echo $(ps aux| grep $pid| grep -v 'grep') "">> "$LOG"
    #     done
    #     sleep 5
    # done
    # ########## 将所有的日志信息放到一个文件中 END ###########
```

# linux系统之间传输文件的方法
1 启动python server：
在目录中运行 python -m http.server 
然后终端会输出端口号。
在新的计算机上输出服务器额IP:端口号，就能看到服务器上的目录了

2 使用ssh

3 使用scp：
scp source_file target_server_name@IP:dir

scp source_file ubuntu@10.10.8.10:/home/ubuntu

# 在ubuntu上挂载磁盘
在现在的版本中，默认点击磁盘就能实现挂载。
只是挂在之后可能磁盘是只读文件，不能写。
这时候就需要修复一下：
https://blog.51cto.com/144dotone/2952984
```text
  使用mount查看当前挂载的设备，找到属性为ro的，比如我这里为/dev/sdb2
  使用如下命令修复即可
  sudo ntfsfix /dev/sdb2
  出现successfully之后将/dev/sdb2 unmount掉，然后再重新mount即可
```

# environment
程序环境问题：
在编程的时候，或者在跑凯源代码的时候往往会遇到需要安装以前的版本的包的情况。
这时候就涉及到程序环境问题。
解决的一般思路是：
1 在当前环境中尝试运行程序。
  如果报错，看能否通过简单地修改代码来使程序成功运行。
  如果如法通过简单地修改代码来修复问题。那就进行第二步。
2 检查是否缺少程序包，如果是就进行安装。如果不是缺少，而是版本冲突，那就进行第三步。
3 新建虚拟环境，如anaconda环境，或者docker环境，又或者其他类型的虚拟环境。
  然后切换到虚拟环境中。
4 在虚拟环境中安装所需版本的程序包。如果还是找不到需要安装的版本。那就进行第五步。
5 从源码构建第三方库。搜索包/库的 release记录。或者在开源项目中找到release。或者直接搜索 库 versions/release/github。
  如果有可以之间安装的二进制文件，那就优先选择二进制文件，如果有编译好直接用的程度，那就选直接用的程序。
  如果只有源码，那就git clone 源码，然后git checkout <release>，然后根据README.md 进行编译。
  

切忌不要删除当前的程序包，然后安装某个旧版本的程序包。因为这可能会导致其他的程序无法正常运行。
