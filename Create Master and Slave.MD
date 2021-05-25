Text Direction : Create and Configure Jenkins Slave
Install Jenkins Agent on the Slave Node


Running on the master node:

sudo -iu jenkins
ssh root@<slave_ip> mkdir -p .ssh
cat .ssh/id_rsa.pub | ssh root@<slave_ip> 'cat >> .ssh/authorized_keys'


Running on slave node:

mkdir bin
cd bin
wget http://<master_ip>:8080/jnlpJars/slave.jar


Verify and Install Java:

java -version
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt install openjdk-8-jdk


Start Slave Agent Command:

ssh root@<slave_ip> java -jar /root/bin/slave.jar



Trouble Shooting
If you don't see the "Launch agent via execution of command on master" option in the add slave page. This is due to the fact that the latest version of Jenkins has removed that option from the default install and moved it to this plugin: https://plugins.jenkins.io/command-launcher

The solution is to install the command-launcher Jenkins plugin first before you can add a slave.
