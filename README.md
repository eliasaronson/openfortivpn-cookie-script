# Instructions for saml-login with Openfortivpn and connection script
This repo contains instruction on how to connect to a Fortinet VPN with Openfortivpn and cookie-based SSO. It also contains a simple automated shell-script for connecting to a VPN once the initial setup is done.

If you are tired of the official client, there is an open source alternative.
It is a lot more reliable (tested by me on Manjaro and by some other guy on Nixos),
but requires some initial set-up.

Openfortivpn client supports saml-login through cookies, but has now way of retreving these. To do this openfortivpn-webview can be used. It opens a browser, lets you login throught your saml-login and retivres the cookie.

## Setup
### Install openfortivpn
Use your distro's packet manager to install the openfortivpn package.

  Arch:
  ```shell
  sudo pacman -S openfortivpn
  ```

  Ubuntu:
  ```shell
  sudo apt install openfortivpn
  ```

### openfortivpn settings
Add a config file for the VPN-connection.

Create a file "/etc/openfortivpn/my-config".
```shell
sudo vim /etc/openfortivpn/my-config
```
Add the url to your host and the port number.
```shell
host = <vpn.your-url.com>
port = <port number>
```

### Openfortivpn-webview
If it exsists you can use your distro's packet manager to install the openfortivpn-webview package, otherwise just clone the repo.

#### Manual build openfortivpn-webview (variant electron)
Clone [openfortivpn-webview](https://github.com/gm-vm/openfortivpn-webview)
to a suitable location, build and install.

```shell
git clone https://github.com/gm-vm/openfortivpn-webview.git
cd openfortivpn-webview/openfortivpn-webview-electron
npm install
```

#### Manual Build openfortivpn-webview (variant qt)
Clone [openfortivpn-webview](https://github.com/gm-vm/openfortivpn-webview)
to a suitable location, build and install.

```shell
git clone https://github.com/gm-vm/openfortivpn-webview.git
cd openfortivpn-webview/openfortivpn-webview-qt
qmake .
make
make install
```

### Connection script
Fix all necessary pathes according to your needs in the vpn\_connect.sh script, then
run the script.
```shell
./vpn_connect.sh
```

## Running
After the setup, the only thing you need to do to connect is to run the script.
```shell
./vpn_connect.sh
```

## Possible issues
### Debugging
Connection issues can be debugged by adding the parameter "-vv" to the openfortivpn command.

### Peer refused to agree to his IP address
To solve this, add the parameter "--pppd-accept-remote" to the parameter list of openfortivpn.

