# 参考资料：http://www.engr.iupui.edu/~dskim/tutorials/bash-advanced/html/sha-bang.html
Example 2-1. cleanup: A script to clean up the log files in /var/log

vi Clearup.sh 
#!/bin/bash
# Clearup
# Run as root, of course.

cd /var/log
cat /dev/null > messages
cat /dev/null > wtmp
echo "Logs cleaned up."

####################################################
Example 2-2. cleanup: An improved clean-up script
vi Clearup.sh 
#!/bin/bash
# Proper header for a Bash script.

# Cleanup, version2

# Run as root, of course.
# Insert code here to print error message and exit if not root.

LOG_DIR=/var/log
# Varibles are better than hard-code values.
cd $LOG_DIR

cat /dev/null > messages
cat /dev/null > wtmp

echo "Logs cleaned up."

exit # The right and proper method of "exiting" from a script.
####################################################
vi Clearup.sh 
#!/bin/bash
# Cleanup, version3

#  Warning:
#  -----
#  This script uses quite a number of features that will be explained
#+ later on.
#  By the time you've finished the first half of the book,
#+ there should be noting mysterious about it.

LOG_DIR=/var/log
ROOT_UID=0    # Only users with $UID 0 have root privileges.
LINES=50      # Default number of lines saved.
E_XCD=66      # Can't change directory?
E_NOTROOT=67  # Non-root exit error.

# Run as root, of course.
if [ "$UID" -ne "$ROOT_UID" ]; then 
    echo "Must be root to run this script."
	exit "$E_NOTROOT"
fi

if [ -n "$1" ]; then 
# Test if command line argument present (non-empty).
	lines=$1
else
	lines=$LINES # Default, if not specified on command line.
fi

#  Step Chazelas suggests the following,
#+ as a better way of checking command line arguments,
#+ but this is still a bit advanced for this stage of tutorial.
#
#	E_WRONGARGS=65	# Non-numberical argument (bad arg format)
#
#	case "$1" in
#		"" ) 
		lines=50;;
#		*[!0-9]*) 
#		echo "Usage: `basename` $0: file-to-cleanup";
#		exit $E_WRONGARGS;;
#		*       )
#		lines=$1;;
#	esac
#
#* Skip ahead to "Loops" chapter to decipher all this.

cd $LOG_DIR

# or if [ "$PWD" != "$LOG_DIR" ]
# Not in /var/log ?
if [ `pwd` != "$LOG_DIR" ]; then									
	echo  "Can't change to $LOG_DIR."
	exit $E_XCD
fi 	# Doublecheck if in right directory, before messing with log file.

# far more efficient is:
#
#  cd /var/log || {
#  	echo "Cannot change to necessary directory." >&2
#  	exit $E_XCD;
#}

tail -n $lines messages > mesg.temp # Saves last section of message log file.
mv mesg.temp messages				# Becomes new log directory.

# cat /dev/null > messages
#* No longer needed, as the above method is safer.

cat /dev/null > wtmp # ': > wtmp' and ' > wtmp' have the same effect.
echo "Logs cleaned up."
exit 0
#  A zero return value from the script upon exit
#+ indicates sucess to the shell.			

# 看到这里了： http://www.engr.iupui.edu/~dskim/tutorials/bash-advanced/html/sha-bang.html

#!/bin/bash
c1=`grep -w 'bkuser' /etc/passwd | wc -l`
if [ "$c1" -eq 1 ]; then 
	echo "bkuser已经存在"
	c2=`grep -w 'bkuser' /etc/sudoers | wc -l`
	if [ "$c2" -ge 1 ]; then 
		echo "bkuser sudo成功."
		exit
	else
		echo "bkuser sudo失败"
		cp /etc/sudoers /etc/sudoers.bak.`date +%Y_%m_%d_%S` >/dev/null
		echo "bkuser   ALL=(ALL)       NOPASSWD: ALL" >>/etc/sudoers
		sleep 1
	    echo "bkuser sudo已成功添加"
	fi
else
	echo "bkuser不存在"
	useradd bkuser
	echo "bkuser@123" | passwd --stdin bkuser >/dev/null
	cp /etc/sudoers /etc/sudoers.bak.`date +%Y_%m_%d_%S`
	echo "bkuser   ALL=(ALL)       NOPASSWD: ALL" >>/etc/sudoers
	echo "bkuser已经成功添加，且加入sudo"
	sleep 2
	c2=`grep -w 'bkuser' /etc/sudoers | wc -l`
	if [ "$c2" -ge 1 ]; then 
		echo "bkuser sudo成功."
		exit
	else
		echo "bkuser sudo失败"
		cp /etc/sudoers /etc/sudoers.bak.`date +%Y_%m_%d_%S` >/dev/null
		echo "bkuser   ALL=(ALL)       NOPASSWD: ALL" >>/etc/sudoers
		sleep 1
	    echo "bkuser sudo已成功添加"
	    exit
	fi

fi


echo "davie   ALL=(ALL)       NOPASSWD: ALL" >>/etc/sudoers

# http://www.engr.iupui.edu/~dskim/tutorials/bash-advanced/html/sha-bang.html

E_WRONG_ARGS=65
script_parameters="-a -h -m -z"
#				   -a = all, -h = help, etc.
if [ $# -ne $Nuber_of_expected_args ]; then
	echo "Usage: `basename $0` $script_parameters"
	# basename $0 is the script's filename.
	exit $E_WRONG_ARGS
fi

#!/bin/bash

echo "Part 1 of script. "
a=1

#!/bin/bash
# This does *not* launch a new script.
echo "Part 2 of script. "
echo $a # Value of $a stays at 1.

#!/bin/rm
# Self-deleting script.

# Nothing much seems to happen when you run this... except that the file disappears.

WHATEVER=65

echo "This line will never print (betcha!). "

exit $WHATEVER # Doesn't matter. The script will not exit here.
	           # Try an echo $? after script termination.
	           # You'll get a 0, not a 65.

# This line is a comment.
echo "A comment will follow." # Comment here.
#							  # Note whitespace bebore #

echo "The # here does not begin a comment. "
echo "The # here does not begin a comment. "
echo The \# here dose not begin a comment.
echo The # here begins a comment.

# Thanks, S.C.

echo hello, echo there

if [ -x "$filename" ]; then	# Note that "if" and "then" need separation.
							# Why? 
	echo "File $filename exists."; cp $filename $filename.bak
else
	echo "File $filename not found. "; touch $filename
fi
echo "File test complete. "

Terminator in a case option [double semicolon].
case "$variable" in 
	abc) echo "\$variable = abc";;
	xyz) echo "\$variable = xyz";;
esac


while :
do 
	opertion-1
	opertion-2
	...
	opertion-n
done

# Same as:
#	while true
#	do
#   	...
#	done

if condition; then 
	: # Do nothing and branch ahead
else
	take-some-action
fi

: ${username=`whoami`}
# ${username=`whoami`} Gives an error without the leading :
#					   Unliess "username" is a command or builtin..

:  ${HOSTNAME?} ${USER?} ${MAIL?}
#  Prints error message
#+ if one or more of essential environmental variables not set.

: > data.xxx # File "data.xxx" now empty.
# Same effect as cat /dev/null > data.xxx
# However, this does not forks a new process, since ":" is a builtin.

((var0 = var1<98?9:21))
#

# if [ "$var1" -lt 98 ]
# then
#    var0=9
# else
#    var0=21
# fi

var1=5
var2=23skidoo

echo $var1	# 5
echo $var2	# 23skidoo


cat {file1,file2,file3} > combined_file
# Concatentes the files file1,file2, and file3 into combined_file.

cp file22.{txt,backup}
# Copies "File22.txt" to "file22.backup"

{a..z}
echo {a..z} # a b c d e f g h i j k l m n o p q r s t u v w x y z
# Echoes characters between a and z.

echo {0..3} # 0 1 2 3
# Echoes characters between 0 and 3.

Example 3-1. Code blocks and I/O redirection
#!/bin/bash
#  Reading lines in /etc/fstab.

File=/etc/fstab
{
read line1
read line2
} < $File

echo "First line in $File is:"
echo "$line1"
echo
echo "Second line in $File is:"
echo "$line2"

exit 0

# Now, how do you parse the separate fields of each line?
# Hint: use awk, or...
# ... Hans-Joerg Diers suggest using the "set" Bash builtin.

Example 3-2. Saving the output of a code block to a file
#!/bin/bash
#  rpm-check.sh

#	Queries an rpm file for description, listing,
#+	and whether it can be installed.
#	Saves output to be a file.
#
#	This script illustrates using a code block.
SUCCESS=0
E_NOARGS=65

if [ -z "$1" ]; then
	echo "Usage: `basename $0` rpm-file"
	exit $E_NOARGS
fi 

{
#	Begin code block.
	echo 
	echo "Archive description:"
	rpm -qpi $1		# Query listing.
	echo 
	rpm -i --test $1	# Query whether rpm file can be installed.
	if [ "$?" -eq $SUCCESS ]; then
		echo "$1 can be installed."
	else
		echo "$1 cannot be installed."
	fi  
	echo 		# End code block.
} > "$1.test" 	# Redirects output of everything in block to file.

echo "Results of rpm test in file $1.test"

# See rpm man page for explanation of options.
exit 0

ls . | xargs -i -t cp ./ {} $1
#

# From "ex42.sh" (copydir.sh) example.

Array[1]=slot_1
echo ${Array[1]}

veg1=carrots
veg2=tomatoes

if [[ "$veg1" < "$veg2" ]]; then
	echo "Although $veg1 precede $veg2 in the dictionary,"
	echo -n "this does not necessary imply anything "
	echo "about my culinary preferences."
else
	echo "What kind of dictionary are you using, anyhow?"
fi

echo ls -l | sh
#	Passes the output of "echo ls -l" to the shell,
#+	with the same result as a simple "ls -l".

cat *.lst | sort |uniq
#	Merges and sorts all "*.lst" files, then deletes dumplicate lines.

#!/bin/bash
#	uppercase.sh : Change input to uppercase.

tr 'a-z' 'A-Z'
#	Letter ranges must be quoted
#+	to prevent filename generation from single-letter filenames.

exit 0

cat file1 file2 | ls -l | sort
#	The output from "cat file1 file2" disappears.

variable="initial_value"
echo "new_value"|read variable 
echo "variable = $variable"		# variable = initial_value

Example 3-3
#!/bin/bash
#	background-loop.sh
for i in 1 2 3 4 5 6 7 8 9 10	#	First loop.
do
	echo -n "$i "
done

echo #	This 'echo' sometimes will not display.

#	============================================

#	The expected output from the script:
#	1 2 3 4 5 6 7 8 9 10
#	11 12 13 14 15 16 17 18 19 20
#	Sometimes, though, yopu get:
#	11 12 13 14 15 16 17 18 19 20
#	1 2 3 4 5 6 7 8 9 10 bozo $
#	(The second 'echo' doesn't execute. Why?)

#	Occasionally also:
#	1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
#	(The first 'echo' doesn't execute. Why?)

#	Very rarely something like:
#	11 12 13 1 2 3 4 5 6 7 8 9 10 14 15 16 17 18 19 20
#	The foreground loop preempts the background one.
exit 0

#	Nasmuddin Ansari sugests adding sleep 1
#+	after the echo -n "$i" in lines 6 and 14,
#+	for some real fun.

ls -al
sort -dfu $file2
if [ $file1 -ot $file2 ]; then
	echo "File $file1 is older than $file2."
fi

if [ "$a" -eq "$b" ]; then
	echo "$a is equals to $b."
fi

if [ "$c" -eq 24 -a "$d" -eq 47 ]; then 
	echo "$c equals 24 and $d equals 47."
fi

param2=${param1:-$DEFAULTVAL}
#

(cd /source/directory && tar cf - .) | (cd /dest/directory && tar xpvf -)
# Move entire file tree from one directory to another
# [courtesy Alan Cox <a.cox@swansea.ac.uk], with a minor change]
# 1) cd /source/directory
# 	Source directory, where the files to be moved are.
# 2) &&
# 	"And-list": if the 'cd' operation successful,
# 	 then execute the next command.
# 3) tar cf - .
#	 then 'f' (file) option, followed by '-' designates the target file
# 	 as stdout, and do it in current directory tree ('.').
# 4) |
#	  Piped to ...
# 5) (...)
#		a subshell
# 6) cd /dest/directory
# 	 Change to the destination directory.
# 7) &&
# 	 "And-list", as above
# 8) tar xpvf -
#		Unarchive ('x'), preserver ownership and file permissions ('p'),
#		and send verbose messages to stdout ('v'),
#		reading data from stdin ('f' followed by '-').
#
# 	Note that 'x' is a command, and 'p', 'v','f' are options.
#
# Whew!

# More elegant than, but equivalent to:
#	cd source/directory
#	tar cf - . | (cd ../dest/directory; tar xpvf -)
#
#		Also having same effect:
#	cp -a /source/directory/* /dest/directory
#		Or:
#	cp -a /source/directory/* /source/directory/.[^.]* /dest/directory
#		If there are hidden files in /source/directory.
bunzip2 -c linux-2.6.16.tar.bz2 | tar xvf -
#	--uncompress tar file-- | --then pass it to "tar" --
#  If "tar" has not been patched to handle "bunzip2",
#+ this nends to be done in two discrete steps, using a pipe.
#	The purpose of the exercise is to unarchive "bzipped" kernel source.
echo "whatever" | cat -

Example 3-4. Backup of all files changed in last day
#!/bin/bash

#  Backs up all files in current directory modified within last hours
#+ in a "tarball" (tarred and gzipped file).

BACKUPFILE=backup-$(date +%m-%d-%Y)
#				  Embeds date in backup filename.
#				  Thanks, Joshua Tschida, for the idea.
archive=${1:-$BACKUPFILE}
#  If no backup-archive filename specified on command line,
#  it will default to "backup-MM-DD-YYYY.tar.gz."

tar cvf `find . -mtime -l -type f -print` > $archive.tar 
gzip $archive.tar 
echo "Directory $PWD backed up archive file \"$arvhice.tar.gz\"."

#  Stephane Chazelas points out that the above code will fail
#+ if there are too many files found
#+ or if any filenames contain blank characters.

# He suggests the following alternatives:
# ---------------------------------------------
#	find . -mtime -l -type f -print0 | xargs -0 tar rvf "$archive.tar"
#		using the GNU version of "find".

#	find . -mtime -l -type f -exec tar rvf "$archive.tar" '{}' \;
#		portable to other UNIX flavors, but much slower.
# ---------------------------------------------

exit 0

Example 4-1. Varible assignment and substitution
#!/bin/bash
# ex9.sh

# Variables: assignment and substitution

a=375
hello=$a

#----------------------------------------------------------------------------
# No space permitted on either side of = sign when initializing variables.
# What happens if there a space?

# "VARIABLE =value"
#
#% Script tries to run "VARIABLE" command with one argument, "=value".

# "VARIABLE= value"
#
#% Script tries to run "value" command with
#+ the environment variable "VARIABLE" set to "".
#----------------------------------------------------------------------------

echo hello  #  hello
# Not a variable reference, just the string "hello" ...

echo $hello		# 375
#				This *is* a variable reference.
echo ${hello}	# 375
# Also a variable reference, as above.
# Quoting ...
echo "$hello"	# 375
echo "${hello}"	# 375
echo 

hello="A B  C     D"
echo $hello		# A B C D
echo "$hello"	# A B  C     D
# As you see, echo $hello and echo "$hello" give different results.
# Why?
# ========================================================
# Quoting a variable preserves whitespace.
# ========================================================
echo

echo '$hello'	# $hello
#
#  Variable referencing disabled (escaped) by single quotes,
#+ which causes the "$" to be interpreted literally.
# Noteice the effect of different types of quoting.

hello=	# Setting it to a null value.
echo "\$shello (null value) = $hello"
# Note that setting a variable to a null value is not be the same as
#+ unsetting it, although the end result is the same (see below).

# ---------------------------------------------------------------

#  It is permissible to set multiple variables on the same line,
#+ if separated by white space.
#  Caution, this may reduce legibility, and may not be portable.

var1=21 var2=22 var3=$V3
echo 
echo "var1=$var1 var2=$var2 var3=$var3"

# May cause problems with older version of "sh" ...

# ---------------------------------------------------------------
echo; echo

numbers="one two three"
#
other_numbers="1 2 3"
#
#  If there is whitespace embedded within a variable,
#+ then quotes are necessary.
#  other_numbers= 1 2 3					# Gives an error message.
echo "numbers = $numbers"
echo "other_numbers = $other_numbers"	# other_numbers = 1 2 3
# Escaping the whitespace also works.
mixed_bag=2\ --\ whatever
#				Space after escape (\).

echo "$mixed_bag"		# 2 -- 	Whatever

echo; echo 
echo "uninitialized_variable = $uninitialized_variable"
# Uninitialized_variable has null value (no value at all!).
uninitialized_variable= 		#  Declaring, but not initializeing it --
								#+ same as setting it to a null value, as above.
echo "uninitialized_variable = $uninitialized_variable"
								# It still has a null value.

uninitialized_variable=23		# Set it.
unset Uninitialized_variable 	# Unset it.
echo "uninitialized_variable = $uninitialized_variable"
								# It still has a null value
uninitialized_variable=23		# Set it.
unset uninitialized_variable 	# Unset it.
echo "uninitialized_variable = $uninitialized_variable"
								# It still has a null value.
echo 
exit 0



# 看到这里了： 
http://www.engr.iupui.edu/~dskim/tutorials/bash-advanced/html/varassignment.html
