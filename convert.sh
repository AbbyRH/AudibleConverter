#!/bin/bash

shopt -s nullglob

activationCode="AAAAAAAA" #put your activation code here

for f in /app/toConvert/*
do
	base=`basename "$f"`
	echo "Starting decrypting of $base"
	decrypt="/app/decrypted/$base"
	mkdir "$decrypt"
	node node_modules/audible-converter/main.js "$f" -a $activationCode -p "$decrypt"
	mv "$f" /app/finishedaax/
	echo "Decryption done"
done

for f in /app/decrypted/*/*.m4a
do
	base=`basename "$f"`
	echo "Starting chapter extraction of $base"
	complete="/app/completed/$base"
	mkdir "$complete"
	cd "$complete"
	m4acut -c "$f"
	echo "Chapters extracted to $complete"
done
