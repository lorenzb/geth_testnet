#!/bin/bash

set -euo pipefail

cd "$(dirname "$0")"

if [ -d "geth" ]
then
	echo "There seems to be a preexisting chain. Do you want to start a new one?"
	select yn in "No" "Yes"
	do
		case $yn in
			Yes ) rm -r geth && echo "Deleted existing chain"; break;;
			No ) echo "Keeping existing chain"; break;;
		esac
	done
fi

if ! [ -d "geth" ]
then
	echo "Would you like to activate Byzantium?"
	select yn in "No" "Yes"
	do
		case $yn in
			Yes ) geth --datadir . init <(sed s/999999999/0/ <genesis.json); break;;
			No ) geth --datadir . init genesis.json; break;;
		esac
	done
fi

geth --datadir . --networkid 7418 --rpc --rpccorsdomain '*' --rpcapi "eth,net,web3,debug" --unlock 0,1,2 --password <(echo;echo;echo;echo) --mine --minerthreads=1
