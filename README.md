# Instructions for saml-login with Openfortivpn and connection script
This repo contains instruction on how to connect to a Fortinet VPN with Openfortivpn and cookie-based SSO. It also contains a simple automated shell-script for connecting to a VPN once the initial setup is done.

If you are tired of the official client, there is an open source alternative.
It is a lot more reliable (tested by me on Manjaro), but requires some initial set-up
(and might be less secure?).

The main Openfortivpn client doesn't support saml-login as of now, so this
method relies on a forked version along with a tools to login to your
google-account and retrieve the cookie for saml-login.

### Installation
1. Clone [openfortivpn](https://github.com/gm-vm/openfortivpn) to suitable
location.

```git clone https://github.com/gm-vm/openfortivpn.git```

2. Change to cookie_saml branch and build.
```
cd openfortivpn
git checkout cookie_saml
./autogen.sh
./configure --prefix=/usr/local --sysconfdir=/etc
make
sudo make install
```
3. Add a config file for the VPN-connection.

Create  file "/etc/openfortivpn/my-config".
```
sudo vim /etc/openfortivpn/my-config
```
Add the url to your host and the port number.
```
host = <vpn.your-url.com>
port = <port number>
```

4. Clone [openfortivpn-webview](https://github.com/gm-vm/openfortivpn-webview)
to suitable location.

```
git clone https://github.com/gm-vm/openfortivpn-webview.git
```

5. Build openfortivpn-webview.
```
cd openfortivpn-webview/openfortivpn-webview-electron
npm install
```

### Connection script
0. In the connection script check if you cloned openfortivpn-webview to the same
path as in the script, otherwise change the cd in the script to the correct
path. You also need to set the url for the saml-login.

1. Run the script.
```
./vpn_connect.sh
```

### Manual connection
Once the installation has been completed, you only have to perform the following steps.

1. Run openfortivpn-webview and copy the cookie. You need the url to the actual
saml login of you host here. It might be somthing like "https://vpn.your-url.com:1337/remote/saml/start", where 1337 is a port.
```
cd openfortivpn-webview/openfortivpn-webview-electron
npm start myvpnhost -- --url '<your-url>'
```
Log in. The cookie will be printed in the terminal. It should start with "SVPNCOOKIE=" Copy it.

2. Run openfortivpn with the config-file and cookie-on-stdin-flag.
```
sudo openfortivpn -c /etc/openfortivpn/my-config --cookie-on-stdin
```
3. Paste the cookie you copied earlier and press enter.
You should now be connected. If it complains about authentication make sure you copied just the cookie. It should start with "SVPNCOOKIE=" and consist of a number of random characters. If it isn't working some other reason, look at the dependencies of Openfortivpn.

