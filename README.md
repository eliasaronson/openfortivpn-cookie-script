# Instructions for saml-login with Openfortivpn and connection script
This repo contains instruction on how to connect to a Fortinet VPN with Openfortivpn and cookie-based SSO. It also contains a simple automated shell-script for connecting to a VPN once the initial setup is done.

If you are tired of the official client, there is an open source alternative.
It is a lot more reliable (tested by me on Manjaro and by some other guy on Nixos),
but requires some initial set-up (and might be less secure?).

The main Openfortivpn client supports saml-login. You also need openfortivpn-webview,
which is used to automatically retrieve the saml cookie. The google-authenticator's
code is needed for the openfortivpn-webview, so it can perform its task.

## Openfortivpn
### Instal openfortivpn (preferred)
Use your distro's packet manager to install the openfortivpn package.

### Manual build openfortivpn (alternative)
1. Clone [openfortivpn](https://github.com/adrienverge/openfortivpn) to a suitable
location, build and install.

```
git clone https://github.com/adrienverge/openfortivpn.git
cd openfortivpn
./autogen.sh
./configure --prefix=/usr/local --sysconfdir=/etc
make
sudo make install
```

### Settings openfortivpn
Add a config file for the VPN-connection.

Create  file "/etc/openfortivpn/my-config".
```
sudo vim /etc/openfortivpn/my-config
```
Add the url to your host and the port number.
```
host = <vpn.your-url.com>
port = <port number>
```

## Openfortivpn-webview
### Installation openfortivpn-webview (preferred)
Use your distro's packet manager to install the openfortivpn-webview package.

### Manual build openfortivpn-webview (variant electron)
Clone [openfortivpn-webview](https://github.com/gm-vm/openfortivpn-webview)
to a suitable location, build and install.

```
git clone https://github.com/gm-vm/openfortivpn-webview.git
cd openfortivpn-webview/openfortivpn-webview-electron
npm install
```

### Manual Build openfortivpn-webview (variant qt)
Clone [openfortivpn-webview](https://github.com/gm-vm/openfortivpn-webview)
to a suitable location, build and install.

```
git clone https://github.com/gm-vm/openfortivpn-webview.git
cd openfortivpn-webview/openfortivpn-webview-qt
qmake .
make
make install
```

### Connection script
Fix all necessary pathes according your needs in the vpn\_connect.sh script, then
run the script.
```
./vpn_connect.sh
```

## Possible issues
### Debugging
Connection issues can be debugged by adding the parameter "-vv" to the openfortivpn command.

### Peer refused to agree to his IP address
To solve this, add the parameter "--pppd-accept-remote" to the parameter list of openfortivpn.

