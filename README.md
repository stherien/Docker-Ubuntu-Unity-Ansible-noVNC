# Docker-Ubuntu-Unity-Ansible-noVNC

Dockfile for Ubuntu with Unity desktop environment providing Ansible and associated tools using noVNC as frontend. 

This **Image/Dockerfile** aims to create a container for **Ubuntu 16.04** with **Unity Desktop** and using **TightVNCServer**, **noVNC**, which allow user to use Devops tools (Ansible-paramiko-netmiko-napalm-Atom) with this container.


## How to use?

You can build this **Dockerfile** yourself:

```
sudo docker build -t "stherien/net-automation-novnc" .
```

Or, just pull my **image**:

```
sudo docker pull stherien/net-automation-novnc
```

The default usage of this image is:

```
sudo docker run -itd -p 80:6080 stherien/net-automation-novnc
```

Wait for a few second, you can access http://localhost/vnc.html and see this screen:

![alt text](https://github.com/stherien/Docker-Ubuntu-Unity-Ansible-noVNC/raw/master/noVNC.png "vnc.html")


### Password

In default, the **password** will create randomly, to find the password, please using the following command:

```
sudo docker exec $CONTAINER_ID cat /home/ubuntu/password.txt
```

And you can use this password to log in into this container.

After log in, you can see this screen:

![alt text](https://github.com/stherien/Docker-Ubuntu-Unity-Ansible-noVNC/raw/master/desktop.png "Unity desktop")


## Arguments

This image contains 2 input argument:

1. Password

   You can set your own user password as you like:
   ```
   sudo docker run -itd -p 80:6080 -e PASSWORD=$YOUR_PASSWORD stherien/net-automation-novnc
   ```
   Now, you can user your own password to log in.

2. Sudo

   In default, the user **ubuntu** will not be the sudoer, but if you need, you can use this command:
   ```
   sudo docker run -itd -p 80:6080 -e SUDO=yes stherien/net-automation-novnc
   ```

   This command will grant the **sudo** to user **ubuntu**.

   And use **SUDO=YES**, **SUDO=Yes**, **SUDO=Y**, **SUDO=y** are also supported.

   To check the sudo is work , when you open **xTerm** it should show following message:
   ```
   To run a command as administrator (user "root"), use "sudo <command>".
   See "man sudo_root" for details.
   ```

   ![alt text](https://github.com/stherien/Docker-Ubuntu-Unity-Ansible-noVNC/raw/master/sudo.png "sudo")

   **Caution!!** allow your user as sudoer may cause security issues, use it carefully.

## Screen size

The default setting of screen siz is 1024x768.

You can change screen by using following command, this will change screen size to 1024x768:

```
sudo docker exec $CONTAINER_ID sed -i "s|-geometry 1600x900|-geometry 1024x768|g" /etc/supervisor/conf.d/supervisor.conf
sudo docker restart $CONTAINER_ID
```


## Issues

Can't work properly with gnome-terminal, use XTerm to place it.

Some components of Unity may not work properly with vncserver.
