/usr/lib/gnome-session/gnome-session-binary --session=ubuntu &
/usr/lib/x86_64-linux-gnu/unity/unity-panel-service &
/usr/lib/unity-settings-daemon/unity-settings-daemon &


for indicator in /usr/lib/x86_64-linux-gnu/indicator-*; do
  basename=`basename ${indicator}`
  dirname=`dirname ${indicator}`
  service=${dirname}/${basename}/${basename}-service
  ${service} &
done

#gsettings set org.gnome.desktop.background picture-uri file:///home/ubuntu/AUD.png
#gsettings set org.gnome.desktop.background picture-options 'wallpaper'
#gsettings set org.gnome.desktop.background picture-options 'centered'
gsettings set com.canonical.Unity.Launcher favorites "['application://ubiquity.desktop', 'unity://desktop-icon', 'application://org.gnome.Nautilus.desktop', 'application://firefox.desktop', 'application://terminator.desktop', 'application://putty.desktop', 'application://atom.desktop', 'application://unity-control-center.desktop', 'unity://running-apps', 'unity://expo-icon', 'unity://devices']"

unity
