#!/bin/bash

# EXIF Orient Express - Mass JPG Orientation Fix Before Upload
# by Michael Kovalenko
# June 12, 2016
# Version 0.5

# What this script does:
# Converts all {jpg,JPG} files in the current directory using ImageMagick's "convert -auto-orient file.jpg file_orient.jpg" then outputs to a subdirectory.

# Dependencies: ImageMagick

# --------------------------------------------------------------------- #

# USER INPUT VARIABLES

# Name your output directory: /path/to/images/{DirectoryName}
DIR=_ExifOrientExpress_output

# Name your output format (case sensitive): yourFilename.{jpg,jpeg,JPG,JPEG}
OUTFMT=jpg

# Set input format (type should match)
INFMT=jpg			# Lowercase: jpg, jpeg
INFMTCAPS=JPG		# UPPERCASE: JPG, JPEG

# Add this to converted filenames: FILENAME{_orient}.jpg
TAIL=_orient 		# currently 7 characters for "_orient"

# Match number of characters above for PRTY output below
PRTY=------- 		# currently 7 characters for "-------"

# --------------------------------------------------------------------- #

##############################
### TESTING MODE

# Clean up previous subdirectory with test files
rm -rf $DIR

###
##############################

# --------------------------------------------------------------------- #

# GO TO WORK

# Create some space above the output because I like space
echo " "

# CHECK DEPENDENCIES

# Check that ImageMagick tools are installed
hash convert 2>/dev/null || { echo >&2 "$(tput setaf 1)$(tput setab 7)Sorry, ImageMagick is required. Please install then run again. Aborting.$(tput sgr0)"; echo " "; exit 1; }
hash identify 2>/dev/null || { echo >&2 "$(tput setaf 1)$(tput setab 7)Sorry, ImageMagick is required. Please install then run again. Aborting.$(tput sgr0)"; echo " "; exit 1; }

# Create the output directory
mkdir $DIR

# Process files with extensions in lowercase.
for pic in *"$INFMT"
do
	CHECKFILE=$(ls "$pic" | sed -e s/\.$INFMT//)

# scratch - temp
# $(tput setaf 1)$(tput setab 7)tr -dc '0-9'$(tput sgr0)

		# Call ImageMagic's identify to check exif:Orientation orientation
		echo "$CHECKFILE.$INFMT  --$PRTY[ - ]--------->  "exif:Orientation="$(tput setaf 1)$(tput setab 7) "$(identify -format "%[EXIF:*]" "$CHECKFILE".$INFMT | grep Orient | tr -dc '0-9')" $(tput sgr0)" 

		# Convert spaces in filename to underscores
		CONVERTFILE=$(ls "$pic" | sed 's/\ /_/g' | sed -e s/\.$INFMT//)

		# Convert the file
		convert -auto-orient "$pic" $CONVERTFILE$TAIL.$OUTFMT
		
		# Now call ImageMagic's identify to verify the new exif:Orientation
		echo "$CONVERTFILE$TAIL.$OUTFMT  --[ + ]--------->  "exif:Orientation="$(tput setaf 0)$(tput setab 2) "$(identify -format "%[EXIF:*]" "$CONVERTFILE$TAIL".$OUTFMT | grep Orient | tr -dc '0-9')" $(tput sgr0)" 

		# Create some space below the output
		echo " "
		
		# Move file to the output directory
		mv $CONVERTFILE$TAIL.$OUTFMT $DIR
	done

# Process files with extensions in CAPS.
for pic in *"$INFMTCAPS"
do
	CHECKFILE=$(ls "$pic" | sed -e s/\.$INFMTCAPS//)

		# Call ImageMagic's identify to check exif:Orientation orientation
		echo "$CHECKFILE.$INFMTCAPS  --$PRTY[ - ]--------->  "exif:Orientation="$(tput setaf 1)$(tput setab 7) "$(identify -format "%[EXIF:*]" "$CHECKFILE".$INFMTCAPS | grep Orient | tr -dc '0-9')" $(tput sgr0)" 
			
		# Convert spaces in filename to underscores
		CONVERTFILE=$(ls "$pic" | sed 's/\ /_/g' | sed -e s/\.$INFMTCAPS//)

		# Convert the file
		convert -auto-orient "$pic" $CONVERTFILE$TAIL.$OUTFMT
		
		# Now call ImageMagic's identify to verify the new exif:Orientation
		echo "$CONVERTFILE$TAIL.$OUTFMT  --[ + ]--------->  "exif:Orientation="$(tput setaf 0)$(tput setab 2) "$(identify -format "%[EXIF:*]" $CONVERTFILE$TAIL.$OUTFMT | grep Orient | tr -dc '0-9')" $(tput sgr0)" 

		# Create some space below the output
		echo " "
		
		# Move file to the output directory
		mv $CONVERTFILE$TAIL.$OUTFMT $DIR
	done

# The process is finished	
echo "Done!"

# Add some space below the last output because space is good
echo " "
echo " "

exit $?

# END
