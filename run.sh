#!/bin/bash

set -euo pipefail

declare -r DATADIR=$HOME/geth-myrtle

if [ -d "$DATADIR/geth" ]
then
	echo "There seems to be a preexisting chain. Do you want to start a new one?"
	select yn in "No" "Yes"
	do
		case $yn in
			Yes ) rm -r "$DATADIR/geth" && echo "Deleted existing chain"; break;;
			No ) echo "Keeping existing chain"; break;;
		esac
	done
fi

if ! [ -d "$DATADIR/geth" ]
then
	geth --datadir "$DATADIR" init genesis.json
fi

geth --datadir "$DATADIR" --networkid 7418 --rpc --rpccorsdomain '*' --rpcapi "eth,net,web3,debug" --unlock 0,1,2 --password <(echo;echo;echo;echo) --mine --minerthreads=1
