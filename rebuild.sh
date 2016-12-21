#!/bin/bash

dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name "Launch Terminal"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command "gnome-terminal"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "<Primary><Alt>t"
echo "Added Launch Terminal keyboard shortcut (Ctrl+Alt+T)"

python -c 'proxy = raw_input("Enter proxy name (blank if none): "); oF = open("/etc/apt/apt.conf", "a"); out = "Acquire::http::Proxy \"http://" + proxy + ":80\";\n" if proxy != "" else ""; oF.write(out); oF.close()'

pip install requests --upgrade

apt-get update
apt-get -y upgrade
apt-get install linux-headers-$(uname -r)

mv index.php /var/www/html/
mv upload.php /var/www/html/

sed -i 's/.*post_max_size *=.*/post_max_size = 128M/' /etc/php/7.0/apache2/php.ini
sed -i 's/.*upload_max_filesize *=.*/upload_max_filesize = 128M/' /etc/php/7.0/apache2/php.ini
echo "File uploads set up. Run 'service apache2 start' in the terminal and browse to http://ip_address/index.php in a browser"

mv payloads/ ~/
chattr +i ~/payloads/*

echo "Turning on audio"
systemctl --user enable pulseaudio && systemctl --user start pulseaudio

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
 if [ $pick == "y" ] || [ $pick == 'Y" ]; then
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

echo "You should probably reboot now."
echo "Thanks for riding the pwn train. Have a nice day!"
