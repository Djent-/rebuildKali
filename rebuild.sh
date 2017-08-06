#!/bin/bash

dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name "Launch Terminal"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command "gnome-terminal"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "<Primary><Alt>t"
echo "Added Launch Terminal keyboard shortcut (Ctrl+Alt+T)"

python -c 'proxy = raw_input("Enter proxy name (blank if none): "); oF = open("/etc/apt/apt.conf", "a"); out = "Acquire::http::Proxy \"http://" + proxy + ":80\";\n" if proxy != "" else ""; oF.write(out); oF.close()'

pip install requests --upgrade

grep "^deb http://http.kali.org/kali" /etc/apt/sources.list
if [ $? != 0 ]; then
 echo "deb http://http.kali.org/kali kali-rolling main contrib non-free" >> /etc/apt/sources.list
fi
apt update
apt -y upgrade
apt -y install shutter

mv index.php /var/www/html/
mv upload.php /var/www/html/

sed -i 's/.*post_max_size *=.*/post_max_size = 128M/' /etc/php/7.0/apache2/php.ini
sed -i 's/.*upload_max_filesize *=.*/upload_max_filesize = 128M/' /etc/php/7.0/apache2/php.ini
echo "File uploads set up. Run 'service apache2 start' in the terminal and browse to http://ip_address/index.php in a browser"

mv payloads/ ~/
chattr +i ~/payloads/*

printf "\nPulseaudio causes problems with some machines, resulting in an inability to login to the Desktop Interface\n"
gtg=0
until [ $gtg -eq 1 ]; do
 echo "Would you like to continue with enabling pulseaudio? [y/n]: "
 read pick
 if [ $pick == "y" ] || [ $pick == "Y" ]; then
  echo "Enabling and starting pulseaudio"
  echo "If this causes problems with login, switch to a different tty and disable pulseaudio"
  systemctl --user enable pulseaudio && systemctl --user start pulseaudio
 elif [ $pick == "n" ] || [ $pick == "N" ]; then
  echo "Skipping the pulseaudio setup..."
  gtg=1
 else
  echo "Invalid option!"
 fi
done

gtg=0
until [ $gtg -eq 1 ]; do
 echo -n "Would you like to install Virtualbox? [y/n]: "
 read pick
 if [ $pick == "y" ] || [ $pick == "Y" ]; then
  apt-get -y install virtualbox
  gtg=1
 elif [ $pick == "n" ] || [ $pick == "N" ]; then
  echo "Skipping Virtualbox install..."
  gtg=1
 else
  echo "Invalid option!"
 fi
done

gtg=0
until [ $gtg -eq 1 ]; do
 echo -n "Would you like to install VMWare Tools? [y/n]: "
 read pick
 if [ $pick == "y" ] || [ $pick == "Y" ]; then
  apt-get -y install open-vm-tools-desktop fuse
  gtg=1
 elif [ $pick == "n" ] || [ $pick == "N" ]; then
  echo "Skipping VMWare tools install..."
  gtg=1
 else
  echo "Invalid option!"
 fi
done

gtg=0
until [ $gtg -eq 1 ]; do
 echo -n "Would you like to install Empire? [y/n]: "
 read pick
 if [ $pick == "y" ] || [ $pick == "Y"]; then
  wget https://github.com/adaptivethreat/Empire/archive/master.zip
  unzip master.zip
  mv Empire-master ~/Desktop/Empire
  ~/Desktop/Empire/setup/install.sh
  rm master.zip
  gtg=1
 elif [ $pick == "n" ] || [ $pick == "N" ]; then
  echo "Skipping Empire install..."
  gtg=1
 else
  echo "Invalid option!"
 fi
done

gtg=0
until [ $gtg -eq 1 ]; do
 echo -n "Would you like to install Peach Fuzzer? [y/n]: "
 read pick
 if [ $pick == "y" ] || [ $pick == "Y" ]; then
  echo "Great! Do it yourself..."
  gtg=1
 elif [ $pick == "n" ] || [ $pick == "N" ]; then
  echo "Skipping Peach install..."
  gtg=1
 else
  echo "Invalid option!"
 fi
done

gtg=0
until [ $gtg -eq 1 ]; do
 echo -n "Would you like to install MetasploitPro? [y/n]: "
 read pick
 if [ $pick == "y" ] || [ $pick == "Y" ]; then
  wget http://downloads.metasploit.com/data/releases/metasploit-latest-linux-x64-installer.run
  chmod +x metasploit-latest-linux-x64-installer.run
  ./metasploit-latest-linux-x64-installer.run
  gtg=1
 elif [ $pick == "n" ] || [ $pick == "N" ]; then
  echo "Skipping MetasploitPro install..."
  gtg=1
 else
  echo "Invalid option!"
 fi
done

printf "\n\t***You should probably reboot now.***\n"
printf "\tThanks for riding the pwn train. Have a nice day!\n\n"
