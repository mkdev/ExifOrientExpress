# ExifOrientExpress

ExifOrientExpress auto-converts the EXIF orientation for all JPG files in a directory using ImageMagick, then outputs changed files into a subdirectory.

Example:

1) Fictitious example files "IMG 001.jpg" and "IMG 0001.JPG" are pictures in portrait orientation with exif:Orientation=8 (or "Rotate 270 CW") and exif:Orientation=6 (or "Rotate 90 CW"), which is how the devices recorded the orientation at the time the photos were taken. Note the spaces in the filenames and a mix of lowercase and uppercase extensions from different sources. 

2) Simply run the bash script in a shell by typing "sh ExifOrientExpress.sh" which executes the "convert -auto-rotate" command for every {jpg,JPG} file in the directory, creating new versions and preserving the originals. 

3) The new files, IMG_001.jpg and IMG_0001.jpg, are created and moved to a subdirectory. All the original EXIF metadata is retained except for a change to orientation. 

These "corrected" or sanitized versions will now display properly in content management systems like Drupal or Wordpress, or in static web pages, because their rotation was altered by ImageMagick and overwritten as exif:Orientation=1 ("Horizontal (normal)"). So even though it might seem confusing that portraits would read as "Horizontal" from a metadata perspective, the files display properly from a human perspective.
