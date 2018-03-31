# Script Utils

A bunch of useful but un-related scripts. 

## 1. Change MAC

Generates and assigns a new random MAC address to OSX's default network interface card (NIC).

```
sudo bash change_mac.sh
```

If needed, a different network interface card can be targeted by providing its name as script input
parameter:

```
sudo bash change_mac.sh <network_interface_card_name>
```
## 2. Install Go Delve

This script automates the intallation of [go-delve](https://github.com/derekparker/delve) in OSX. Go delve is a debugger for the Go programming language.

> **Note**: This script has [Homebrew](https://brew.sh/) as runtime dependency.

To install go-delve on you OSX system, execute the following command:
```
sudo bash osx-install-go-delve.sh
```

To uninstall go-delve from you OSX sytem, execute the following command:
```
sudo bash osx-uninstall-go-delve.sh
```

