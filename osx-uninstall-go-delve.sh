#!/bin/bash

brew uninstall go-delve/delve/delve
sudo security delete-certificate -t -c dlv-cert /Library/Keychains/System.keychain