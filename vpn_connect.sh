#!/bin/zsh

# Path to where you cloned openfortivpn-webview
cd ~/Documents/openfortivpn-webview/openfortivpn-webview-electron

## Here you need to change to your url to the saml login.
npm start myvpnhost -- --url 'https://<your-url>' > cookie.txt
cookie=$(sed -n '/^SVPNCOOKIE/p' cookie.txt)

sudo openfortivpn -c /etc/openfortivpn/my-config --cookie="$cookie"
