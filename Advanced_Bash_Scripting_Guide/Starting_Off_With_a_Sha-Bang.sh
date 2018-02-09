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


