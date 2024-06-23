#!/bin/bash

##############################################################################################################
# Copyright © 2018 Albert Lloveras Carbonell (@_alloveras)
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
# documentation files (the "Software"), to deal in the Software without restriction, including without
# limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of 
# the Software, and to permit persons to whom the Software is furnished to do so, subject to the following
# conditions:
#
#  - The above copyright notice and this permission notice shall be included in all copies or substantial
#  portions of the Software.
#
#  - THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT 
# LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
# EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER 
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
# USE OR OTHER DEALINGS IN THE SOFTWARE.
##############################################################################################################

DONE=0
DEFAULT_NIC="en0"

print_error() { 
    printf "\e[31m\e[1m\xE2\x9C\x98 [Error]\e[39m\e[0m: $1\n" 
}

print_warning() { 
    printf "\e[33m\e[1m[Warning]\e[39m\e[0m: $1\n" 
}

print_info(){
    printf "\e[34m\e[1m[Info]\e[39m\e[0m: $1\n" 
}

print_success() { 
    printf "\e[32m\e[1m\xE2\x9C\x93 [Success]\e[39m\e[0m: $1\n" 
}

# Check that the user that is running the script is root
if [ "$EUID" -ne 0 ]; then
    print_error "This script must be run as root."
    exit 1
fi

# Use default NIC unless another one is specified.
if [ $# -eq 0 ]; then
    NIC=${DEFAULT_NIC}
else
    # Check that specified network interface exists.
    ifconfig "$1" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        NIC=$1
    else
        print_error "Couldn't find \"$1\" network interface."
        exit 1
    fi
fi

# Brute force until we get a new MAC address.
until [ $DONE -eq 1 ]; do
    NEW_MAC=`openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//'`
    print_info "Generated new fake MAC address (${NEW_MAC})."
    print_info "Trying to assing new fake MAC address to ${NIC}..."
    sudo ifconfig "${NIC}" lladdr "${NEW_MAC}" 
    CURRENT_MAC=`ifconfig "${DEFAULT_NIC}" | grep -i ether | awk '{print $2}'`
    if [ "${CURRENT_MAC}" == "${NEW_MAC}" ]; then
        print_success "The new fake MAC address (${NEW_MAC}) has been assigned to ${NIC}."
        DONE=1
    else
        print_warning "Couldn't assing the new fake MAC address (${NEW_MAC}) to ${NIC}."
        print_info "Retrying..."
    fi
done

