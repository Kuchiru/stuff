#!/bin/bash

INDEX=0
BASENAME=${0##*/}
THISDIR=${0%$BASENAME}
INSTALLERDIR="${THISDIR}installers"
PACKAGEDIR="${THISDIR}packages"
VOLUMENAME="Macintosh HD"

until [[ $(/usr/bin/pmset -g ps) == *"AC Power"* ]]; do
	echo "Please connect a Power Adapter to continue.."
	sleep 5
done

echo ""
echo "###############################################################################"
echo "############################ STARTOSINSTALL SCRIPT ############################"
echo "################################## APFS ONLY ##################################"
echo "###############################################################################"
echo ""
echo "Available Installers:"
for INST in "${INSTALLERDIR}"/* ; do
	let INDEX=${INDEX}+1
	INSTALLERS[${INDEX}]=${INST}
	echo "    ${INDEX}  ${INST}"
done
echo ""
read -p "Select which Installer you would like to use # (1-${INDEX}): " SELECTEDINDEX

SELECTEDINSTALLER=${INSTALLERS[${SELECTEDINDEX}]}

INDEX=0
echo ""
echo "Available package directories:"
for ITEM in "${PACKAGEDIR}"/* ; do
	let INDEX=${INDEX}+1
	PACKAGES[${INDEX}]=${ITEM}
	echo "    ${INDEX}  ${ITEM}"
done
echo ""
read -p "Select which package directory you would like to use # (1-${INDEX}): " SELECTEDINDEX

SELECTEDPACKAGEDIR=${PACKAGES[${SELECTEDINDEX}]}
PKG_ARRAY=($( for PKG in "${SELECTEDPACKAGEDIR}"/* ; do echo $PKG; done ))

mkdir "/Volumes/${VOLUMENAME}/test/"

for each in "${PKG_ARRAY[@]}" ; do 
	cp "${PKGINSTALL}" "/Volumes/${VOLUMENAME}/test/"
done