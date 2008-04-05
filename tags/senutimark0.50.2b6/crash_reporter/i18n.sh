# This program is free software; you can redistribute it and/or modify it under the terms of the GNU
# General Public License as published by the Free Software Foundation; either version 2 of the License,
# or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even
# the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
# Public License for more details.
# 
# You should have received a copy of the GNU General Public License along with this program; if not,
# write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
#
# This file was originaly created by David Kocher for Cyberduck and released under the GNU GPL.
# It has been modified for use with Senuti. The origianal copyright is below.
#
# Copyright (c) 2003 David Kocher. All rights reserved.
# http://cyberduck.ch/


#!/bin/bash

base_language="en.lproj"

usage() {
	echo ""
	echo "	  Usage: i18n.sh --extractstrings"
	echo "	  Usage: i18n.sh [-l <language>] --status"
	echo "	  Usage: i18n.sh [-l <language>] --init"
	echo "	  Usage: i18n.sh [-l <language>] [-n <nib>] [--force] --update"
	echo "	  Usage: i18n.sh [-l <language>] --run"
	echo ""
	echo "<language> must be Japanese.lproj, French.lproj, Spanish.lproj, ..."
	echo "<nib> must be Preferences.nib, Main.nib, ..."
	echo ""
	echo "Call with no parameters to update all languages and all nib files"
	echo ""
}

init() {
	mkdir -p Resources/$language
	for nibfile in `ls Resources/$base_language | grep .nib | grep -v ~.nib | grep -v .bak`; do
	{
		echo "Copying $nibfile"
		nib=`basename Resources/$nibfile .nib`
		cp -R Resources/$base_language/$nibfile Resources/$language/$nibfile
		rm -rf Resources/$language/$nibfile/.svn
		nibtool --localizable-strings Resources/$language/$nibfile > Resources/$language/$nib.strings
	}
	done
	cp Resources/$base_language/*.strings Resources/$language/
}

open() {
	nib=`basename $nibfile .nib`
	if [ "$language" = "all" ] ; then
	{
		for lproj in `ls ./Resources | grep lproj`; do
			if [ $lproj != $base_language ]; then
				echo "*** Opening $lproj/$nib.strings"
				/usr/bin/open Resources/$lproj/$nib.strings
			fi;
		done;
	}
	else
	{
		echo "*** Opening $language/$nib.strings"
		/usr/bin/open Resources/$language/$nib.strings
	}
	fi;
}

run() {
	echo "Running app using `basename $language .lproj`...";
	./build/Debug/Senuti.app/Contents/MacOS/Senuti -AppleLanguages "(`basename $language .lproj`)"
}

extractstrings() {
	echo "*** Extracting strings from Obj-C source files (genstrings)..."
	genstrings -a -s FSLocalizedString -o Resources/$base_language Source/*.m
}

status() {
	if [ "$language" = "all" ] ; then
	{
		for lproj in `ls ./Resources | grep lproj`; do
			language=$lproj;
			if [ $language != "$base_language" ]; then
				echo "*** Status of $language Localization...";
				/usr/local/bin/polyglot -b en -l `basename Resources/$language .lproj` .
			fi;
		done;
	}
	else
	{
		echo "*** Status of $language Localization...";
		/usr/local/bin/polyglot -b en -l `basename Resources/$language .lproj` .
	}
	fi;
}

nib() {
	#Changes to the .strings has precedence over the NIBs
	updateNibFromStrings;
	#Update the .strings with new values from NIBs
	udpateStringsFromNib;
}

updateNibFromStrings() {
	rm -rf Resources/$language/$nibfile.bak 
	mv Resources/$language/$nibfile Resources/$language/$nibfile.bak

	if($force == true); then
	{
		# force update
		echo "*** Updating $nib... (force) in $language..."
		nibtool --write Resources/$language/$nibfile --dictionary Resources/$language/$nib.strings Resources/$base_language/$nibfile
	}
	else
	{
		# incremental update
		echo "*** Updating $nib... (incremental) in $language..."
		nibtool --write Resources/$language/$nibfile \
				--incremental Resources/$language/$nibfile.bak \
				--dictionary Resources/$language/$nib.strings Resources/$base_language/$nibfile
	}
	fi;
	cp -R Resources/$language/$nibfile.bak/.svn Resources/$language/$nibfile/.svn
	rm -rf Resources/$language/$nibfile.bak 
}

udpateStringsFromNib() {
	echo "*** Updating $nib.strings in $language..."
	nibtool --previous Resources/$base_language/$nibfile \
			--incremental Resources/$language/$nibfile \
			--localizable-strings Resources/$base_language/$nibfile > Resources/$language/$nib.strings
}

update() {
	if [ "$language" = "all" ] ; then
	{
		echo "*** Updating all localizations...";
		for lproj in `ls ./Resources | grep lproj`; do
			language=$lproj;
			if [ $language != $base_language ]; then
			{
				echo "*** Updating $language Localization...";
				if [ "$nibfile" = "all" ] ; then
					echo "*** Updating all NIBs...";
					for nibfile in `ls Resources/$language | grep .nib | grep -v ~.nib | grep -v .bak`; do
						nib=`basename $nibfile .nib`
						nibtool --localizable-strings Resources/$base_language/$nibfile > Resources/$base_language/$nib.strings
						nib;
					done;
				fi;
				if [ "$nibfile" != "all" ] ; then
						nib=`basename $nibfile .nib`
						nibtool --localizable-strings Resources/$base_language/$nibfile > Resources/$base_language/$nib.strings
						nib;
				fi;
			}
			fi;
		done;
	}
	else
	{
		echo "*** Updating $language Localization...";
		if [ "$nibfile" = "all" ] ; then
			echo "*** Updating all NIBs...";
			for nibfile in `ls Resources/$language | grep .nib | grep -v ~.nib | grep -v .bak`; do
				nib=`basename $nibfile .nib`;
				nibtool --localizable-strings Resources/$base_language/$nibfile > Resources/$base_language/$nib.strings
				nib;
			done;
		fi;
		if [ "$nibfile" != "all" ] ; then
		{
			nib=`basename $nibfile .nib`;
			nibtool --localizable-strings Resources/$base_language/$nibfile > Resources/$base_language/$nib.strings
			nib;
		}
		fi;
	}
	fi;
}

language="all";
nibfile="all";
force=false;

while [ "$1" != "" ] # When there are arguments...
	do case "$1" in 
			-l | --language)
				shift;
				language=$1;
				echo "Using Language:$language";
				shift;
			;;
			-n | --nib) 
				shift;
				nibfile=$1;
				echo "Using Nib:$nibfile";
				shift;
			;;
			-f | --force) 
				force=true;
				shift;
			;;
			-g | --extractstrings)
				extractstrings;
				exit 0;
				echo "*** DONE. ***";
			;;
			-h | --help) 
				usage;
				exit 0;
				echo "*** DONE. ***";
			;; 
			-i | --init)
				echo "Init new localization...";
				init;
				echo "*** DONE. ***";
				exit 0;
			;; 
			-s | --status)
				echo "Status of localization...";
				status;
				echo "*** DONE. ***";
				exit 0;
			;; 
			-u | --update)
				echo "Updating localization...";
				update;
				echo "*** DONE. ***";
				exit 0;
			;;
			-o | --open)
				echo "Opening localization .strings files...";
				open;
				echo "*** DONE. ***";
				exit 0;
			;; 
			-r | --run)
				run;
				echo "*** DONE. ***";
				exit 0;
			;; 
			*)	
				echo "Option [$1] not one of  [--extractstrings, --status, --update, --open, --init]"; # Error (!)
				exit 1
			;; # Abort Script Now
	esac;
done;

usage;
