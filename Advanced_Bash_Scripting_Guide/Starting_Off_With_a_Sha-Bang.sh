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
  cd /var/log || {
  	echo "Cannot change to necessary directory." >&2
}



