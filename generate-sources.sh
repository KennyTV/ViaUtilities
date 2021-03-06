#! /bin/bash

platform=$1
v=$2
name=$platform-$v
enigma=enigma-cli.jar

# Generate Enigma mapping folder
if [ ! -d sources/$name-mapping ]
then
	echo "===== Generating Enigma mappings file"
	java -cp $enigma cuchaz.enigma.command.Main convert-mappings proguard sources/$name.txt enigma_file sources/$name-mapping
fi

if [ ! -d sources/$name ]
then mkdir sources/$name
fi

# Export mapped sources
java -cp $enigma cuchaz.enigma.command.Main decompile PROCYON versions/$name.jar sources/$name sources/$name-mapping

# Cleanup
rm sources/$name-mapping
rm sources/$name.txt