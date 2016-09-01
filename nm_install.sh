#!/bin/bash
# Basic installation script for Nightmare
# @nuttsmare
# Tested on ubuntu 16.04 LTS

echo "[+] Removing previous directories, if exists"
rm -rf install && mkdir install && cd install
sudo apt-get update
sudo apt-get  install --force-yes --yes git python-mysqldb python-pip sqlite mysql-server build-essential
sudo pip install capstone

echo "[+] Installing beanstalkd"
sudo apt-get install --force-yes --yes beanstalkd
#beanstalkc
git clone https://github.com/earl/beanstalkc.git && cd beanstalkc && sudo python setup.py install
cd ..

echo "[+] Installing Radamsa"
git clone https://github.com/aoh/radamsa.git && cd radamsa && make && sudo make install
cd ..

echo "[+] Installing Optional Stuff"
sudo apt-get install --force-yes --yes libtool pkg-config automake
git clone https://github.com/samhocevar/zzuf.git && cd zzuf && ./bootstrap && ./configure && make &&  sudo make install
cd ..
sudo pip install macholib
sudo pip install OleFileIO_PL

echo "[+] Installing optional radamsa stuff"
sudo apt-get install --force-yes --yes  cmake g++ g++-multilib doxygen transfig imagemagick ghostscript subversion

echo "[+] Installing other fuzzing dependencies"
sudo pip install psutil
sudo pip install pyyaml

#echo "Installing Dynamorio"
#git clone https://github.com/DynamoRIO/dynamorio.git
#cd dynamorio && mkdir build && cd build
#cmake ..
#make -j
#./bin64/drrun echo hello world
#cd ../../

echo "[+] Pulling nightmare from github"
git clone https://github.com/joxeankoret/nightmare.git

echo "[+] Before you start:"

echo "[+] Create a a user and schema using mysql, like so:"
echo "CREATE DATABASE nightmare;"
echo "CREATE USER 'fuzzing'@'localhost' IDENTIFIED BY 'fuzzing';"
echo "GRANT ALL PRIVILEGES ON nightmare.* TO 'fuzzing'@'localhost';"

echo "[+] Edit some paths for the config settings on nightmare.sql. see install.txt"
echo "[+] You can configure ^^ later under configuration"
echo "[+] Import the mysql file"
echo "mysql -u fuzzing -p nightmare < nightmare.sql"

echo "[+] Rename config.py.exampe to config.py"
echo "[+] Rename config.cfg.exampe to config.cfg"
echo "[+] Rename generic.cfg.exampe to generic.cfg"

echo "[+] You should be good to go..."
echo "[+] run python nightmare_frontend.py"
echo "[+] login as admin/nightmare"
echo "[+] happy fuzzing"

#mysql fix for /bugs page
#SET GLOBAL sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
