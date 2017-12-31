# Script Utils

A bunch of useful but un-related scripts. 

## Change MAC

Generates and assigns a new random MAC address to OSX's default network interface card (NIC).

```
sudo bash change_mac.sh
```

If needed, a different network interface card can be targeted by providing its name as script input
parameter:

```
sudo bash change_mac.sh <network_interface_card_name>
```
