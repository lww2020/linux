# 看到这里了
# http://www.engr.iupui.edu/~dskim/tutorials/bash-advanced/html/varassignment.html
4.2. Variable Assignment
Example 4-2. Plain Variable Assignment
#!/bin/bash
# Naked variables

echo 

# When is avariable "naked", i.e., lacking the '$' in front?
# When it is being assigned, rather than referenced.

# Assigment
a=879
echo "The value of \"a\" is $a."

# Assignment using 'let'
let a=16+5
echo "The value of \"a\" is now $a."

echo 

# In a 'for' loop (really, a type of disguised assignment):
echo -n "Values of \"a\" in the loop are: "
for a in 7 8 9 11
do
	echo -n "$a "
done

echo 
echo

# In a 'read' statement (also a type of assignment):
echo -n "Enter \"a\" "
read a
echo "The value of \"a\" is now $a."

echo 
exit 0

Example 4-3. Variable Assignment, plain and fancy
#!/bin/bash

a=23		# Simple case
echo $a
b=$a
echo $b

# Now, getting a little bit fanciter (command substitution).
a=`echo Hello`	# Assigns result of 'echo' command to 'a'
echo $a
#  Note that including an exclamation mark (!) within a
#+ command substitution construct #+ will not work from the command line,
#+ since this triggers the Bash "history mechanism."
#  Inside a script, however, the history functions are disabled.

a=`ls -l`		# Assigns result of 'ls -l' command to 'a'
echo $a 		# Unquoted, however, removes tabs and newlines .
echo
echo "$a"		# The quoted variable preserves whitespace .
				# (Sess the chapter on "Quoting.")

exit

Example 4-4. Integer or string?
#!/bin/bash
# int-or-string.sh: Integer or string?
a=2334				# Integer.
let "a +=1"
echo "a= $a "		# a = 2335
echo				# Integer, still.

b=${a/23/BB}		# Substitute "BB" for "23".
					# This transforms $b into a string.
declare -i b 		# Declaring it an integer doesn't help.
echo "b = $b"		# b = BB35

let "b = $b"		# b = 1
echo 

c=BB34
echo "c = $c"		# c =BB34
d=${c/BB/23}		# Substitute "23" for "BB".
					# This makes $d an integer.
echo "d = $d"		# d = 2334
let "d += 1"		# 2334 +1 =
echo "d = $d"		# d = 2335
echo 

# What about null variables?
e=""
echo "e = $e"		# e =
let "e += 1"		# Arithmetic operations allowed on a null variables?
echo "e = $e"		# e = 1
echo 				# Null variable transformed into an integer.

# What about undeclarted variables?
echo "f = $f"		# f = 
let "f += 1"		# Arithmetic operations allowed?
echo "f = $f"		# Undeclared vaiable transformed into an integer.

# Variables in Bash are essentially untyped.

Example 4-5. Positional Parameters
#!/bin/bash

# Call this script with at least 10 parameters, for example
# ./scriptname 1 2 3 4 5 6 7 8 9 10
MINPARAMETER=10

echo 

echo "The name of this script is \"$0\"."
# Adds ./ for current directory
echo "The name of this script is \"`basename $0`\"."
# Strips out path name info (see 'basename')

echo

if [ -n "$1" ]; then 				# Tested variable is quoted.
	echo "Parameter #1 is $1"		# Need quotes to escape #
fi

if [ -n "$2" ]; then
	echo "Parameter #2 is $2"
fi

if [ -n "$3" ]; then
	echo "Parameter #3 is $3"
fi

# ...

if [ -n "${10}" ]; then 			# Parameters > $9 must be eclosed in {brackets}.
	echo "Parameter #10 is ${10}"
fi

echo "----------------------------------"
echo "All the command-line parameters are: "$*""

if [ $# -lt "$MINPARAMETER" ]; then 
	echo
	echo "This script needs at least $MINPARAMETER command-line argument!"
fi

echo

exit 0

Example 4-6. wh, whois domain name lookup
#!/bin/bash
# ex18.sh

# Does a 'whois domain-name' lookup on any of 3 alternate servers:
#				ripe.net, cw.net radb.net

# Place this script --renamed 'wh' -- in /usr/local/bin

# Requires symboloc links:
# ln -s /usr/loca/bin/wh /usr/loca/bin/wh-ripe
# ln -s /usr/local/bin/wh /usr/local/bin/wh-cw
# ln -s /usr/local/bin/wh /usr/loca/bin/wh-radb

E_NOARGS=65

if [ -z "$1" ]; then
	echo "Usage: `basename $0` [domain-name]"
	exit $E_NOARGS
fi

# Check script name and call proper server.
case `basename $0` in 		# Or:	case ${0##*/} in
	"wh" )
	whois $1@whois.ripe.net
	;;
	"wh-ripe" ) 
	whois $1@whois.ripe.net
	;;
	"wh-radb" )
	whois $1@whois.radb.net
	;;
	"wh-cw" )
	whois $1@whois.cw.net
	;;
	* )
	echo "Usage: `basename $0` [domain-name] "
	;;
esac

exit $?

Example 4-7. Using shift
#!/bin/bash
# shift.sh: Using 'shift' to step through all the positional parameters

#  Name this scripts something like shft.sh,
#+ and invoke it with some parameters.
#+ For example:
#  				sh shft.sh a b c def 23 skidoo
until [ -z "$1" ] 	# Until all parameters used up...
do 
	echo -n "$1 "
	shift
done
echo 	#	Extra line feed.

exit 0

#  See also the echo-parameter.sh script for a "shiftless"
#+ alternative medthod of stepping through the positional params.

The shift command can take a  numberical parameter indicating how many 
position to shift.

#!/bin/bash
#  shift-past.sh

shift 3		# shift 3 positions.
#  n=3; shift $n
#  Has the same effect.

echo "$1"
exit 0

#  执行结果如下：
$ sh shift-past.sh 1 2 3 4 5
4

5.1. Quoting Variables
variable1="a variable containing five words"
COMMAND This is $variable1		# Executes COMMAND with 7 arguments:
# "This" "is" "a" "variable" "containg" "five" "words"

COMMAND "This is $variable1" 	# Executes COMMAND with 1 argument:
# "This is a variable containing five words"

variable2=""			# Empty

COMMAND $variable2 $variable2 $variable2
						# Executes COMMAND with no arguments.
COMMAND "$variable2" "$variable2" "$variable2"
						# Executes COMMAND with 3 empty arguments.
COMMAND "$variable2 $variable2 $variable2"
						# Executes COMMAND with 1 argument (2 spaces).

# Thanks, Stephase Chazelas.

Example 5-1. Echoing Weird Variables
#!/bin/bash
# weirdvars.sh: Echoing weird variables.

var="'(]\\{}\$\""
echo $var 			# '(]\{}$"
echo "$var"			# '(]\{}$"	Doesn't make a fifference.

echo 

IFS='\'
echo $var 			# '(]{}$"	\ converted to spavce. Why?
echo "$var"			# '(]\{}$"

# Examples above supplied by Stephazelas.
exit 0

Example 5-2. Escaped Characters
#!/bin/bash
# escaped.sh: escaped characters

echo; echo

# Escaping a newline.
# -------------------

echo ""

echo "This will print
as two lines."
# This will print
# as two lines.

echo "This will print \
as on line."
# This will print as one line.

echo; echo

echo "==============="

echo "\v\v\v\v"		# Prints \v\v\v\v literally.
# Use the -e option with 'echo' to print escaped characters.
echo "==============="
echo "$VERTICAL TABS"
echo -e "\v\v\v\v"	# prints 4 vertical tabs.
echo "==============="

echo "QUOTATION MARK"
echo -e "\042"		# print " (quota,octal ASCII character 42).
echo "==============="

# This $\'x' construct makes the -e option unnecessary.
echo; echo "NEWLINE AND BEEP"
echo $'\n'			# Newline.
echo $'\a'			# Alert (beep)

echo "==============="
echo "QUOTATION MARKS"
# Version 2 and later of Bash permits using the $'\nnn' construct.
# Note that in this case, '\nnn' is an octal values.
echo $'\t \042 \t'	# Quote (") framed by tabs.

# It also works with hexadecimal values, in an $'\xhhh' construct.
echo $'\t \x22 \t'	# Quote (") framed by tabs.
# Thanks you, Grep Keraunen, for pointing this out.
# Earlier Bash versions allowed '\x022'.
echo "================"
echo 

# Assigning ASCII characters to a variable.
# -----------------------------------------
quote=$'\042'		# " assigned to a variable.
echo "$quote This is a quoted string string, $quote and this lines outside the quotes."
echo

# Concatenating ASCII chars in a variable.
triple_underline=$'\137\137\137'	# 137 is octal ASCII code for '_'.
echo "$triple_underline UNDERLINE $triple_underline"

echo 
ABC=$'\101\102\103\010'		# 101,102,103 are octal A, B, C.
echo $ABC

echo; echo

escape=$'\033'		# 033 is octal for escape.
echo "\"escape\" echoes as $escape"
#					no visible output.
echo; echo
exit 0

Chapter 6. Exit and Exit Status

#!/bin/bash
COMMAND_1
...

# Will exit with status of last command.
COMMAND_LAST

exit

Th equivalent of a bare exit is exit $? or even just omitting the exit.

#!/bin/bash
COMMAND_1
...
# Will exit with status of last command.
COMMAND_LAST

exit $?

#!/bin/bash
COMMAND1 
...

# Will exit with status of last command.
COMMAND_LAST

Example 6-1. exit/ exit status 

#!/bin/bash

echo hello 
echo $?		# Exit status 0 returned because command executed successfully.

lskdf 		# Unrecognized command.
echo $?		# None-zero exit status returned because command failed to execute.

echo 

exit 113	# Will return 113 to shell.
			# To verify this, type "echo $?" after script terminates.

#  By convention, an 'exit 0' indicates success,
#+ while a non-zero exit value means an error or anomalous condition.

Example 6-2. Nagating a condition using!

true 	# The "true" builtin.
echo "exit status of \"test\" = $?"		# 0

! true 
echo "exit status of \"! true\" = $?"	# 1
# Note that the "!" needs a space between it and the command.
#		!true leads to a "command not found" error
#
# The "!" operator prefixing a command invokes the Bash history mechanism.

true 
!true 
# No error this time, but no negation either.
# It just repeats the previous command (true).

if cmp a b &> /dev/null 	# Suppress output.
	then 
	echo "Files a and b are identical."
else 
	echo "Files a and b differ."
fi 

# The very usefull "if-grep" construct:
# ----------------------------------------
if [ grep -q Bash file ]; then 
	echo "Files contains at least one occurrence of Bash."
fi

word=Linux
letter_sequence=inu 
if [ echo "$word" | grep -q "$letter_sequence" ]; then
# The "-q" option to grep supresses outpu 
	echo "$letter_sequence found in $word"
else 
	echo "$letter_sequence not found in $word"
fi

if [ COMMAND-WHOSE_EXIT_STATUS_IS_0_UNLESS_ERROR_OCCURRED ]; then
	echo "Commanc suceeded."
else 
	echo "Command failed."
fi

#!/bin/bash
if [ echo "Eext *if* is part of the comparision for the first *if*." ] 
	if [ $comparision = integer ]; then 
		(($a < $b))
	else 
		(($a < $b))
	fi
then
	echo "$a is less than $b" 
fi

Example 7-1. What's truth?

#!/bin/bash

#  Tip:
#  If you're unsure of how a certain condition would evaluate,
#+ test it in an if-test.

echo 

echo "Testing \"0\""
if [ 0 ]; then
	echo "0 is true."
else 
	echo "0 is false."
fi 			# 0 is true.

echo 

echo "Testing \"1\""
if [ 1 ]; then	#	one 
	echo "1 is true."
else 
	echo "1 is false."
fi 				# 1 is true.

echo 

echo "Tesing \"-1\""
if [ -1 ]; then		# minus one
	echo "-1 is true."
else 
	echo "-1 is false." 
fi 					# -1 is true.

echo 

echo "Testing \"NULL\""
if [ ]; then 	# NULL (empty condition)
	echo "NULL is true."
else 
	echo "NULL is false."
fi 				# NULL is false.

echo 

echo "Testing \"xyz\""
if [ xyz ]; then	# string
	echo "Random string is true."
else
	echo "Random string is false." 
fi 					# Random string is true.

echo 

echo "Testing \"$xyz\""
if [ $xyz ]; then		# Tests if $xyz is null, but...
						# it's only an uninitialized variable.
	echo "uninitialized variable is true."
else 
	echo "uninitialized variable is false." 
fi 						# Uninitialized variables is false.

echo 

echo "Testing \"-n \$xyz\""
if [ -n zyx ]; then		# More pedantically correct. 
	echo "Uninitialized variable is false."
fi 						# Uninitialized variables is false.

echo 

xyz= 					# Initialized, but set to null value.

echo "Testing \"-n \$xyz\""
if [ -n "xyz" ]; then 
	echo "Null variable is true."
else 
	echo "Null vaiable is false."
fi 						# Null variable is false.

echo 

# When is "false" true?

echo "Testing \"false\""
if [ "false" ]; then			#  It seems that "false" is just a string.
    echo "\"false\" is true."	#+ and is tests true.
else
	echo "\"false\" is false."
fi 								# "false" is true.

echo 

echo "testing \"$false\""		# Again, uninitialized variable.
if [ "$false" ]; then 
	echo "\"$false\" is true."
else 
	echo "\"false\" is true."
fi 								# "$false" is false.
								# Now, we get the expected result.

#  What would happen if we tested the uninitilized variable "$true"?

echo 

exit 0

Exericese. Explain the behavior of Example 7-1, above.

if [ condition-true ]; then 
    command1
    command2
    ...
else 
	# Optional (may be left out if not neede.).
	# Adds default code block executing if original condition tests false.
	command3
	command4
	...
fi

Else if and elif 

if [ condition1 ]; then 
	command1
	command2
	command3
elif [ condition2 ]; then
# Same as else if
    command4
    command5
else 
	default-command
fi

Example 7-2. Equivalence of test, /usr/bin/test, [], and /usr/bin[

#!/bin/bash

echo 

if test -z "$1"; then
	echo "No command-line arguments."
else 
	echo "First comand-line argument is $1."
fi

echo 

if  /usr/bin/test -z "$1"		# Equivalent to "test" builtin.
#  ^^^^^^^^^^^^^^^^^^^^^		# Specifying full pathname.
then
	echo "No command-line arguments. "
else
	echo "First command-line argument is $1." 
fi

echo

if [ -z "$1" ]; then			# Functionally identical to above code blocks.
#    if [ -z "$1"				  should work, but...
#+   Bash responds to a missing close-bracket with an error message.
   echo "No command-line arguments."
else 
	echo "First command-line argument is $1."
fi

echo 

if /usr/bin/[ -z "$1" ]; then 		# Again, functionally identical to above.
# if /usr/bin/[ -z "$1"			# Works, but gives an error message.
#								# Note:
#								  This has been fixed in Bash, version 3.x
	echo "No command-line arguments."
else 
	echo "First command-line argument is $1."
fi

echo 

exit 0

file=/etc/passwd
if [ -e $file ]; then 
	echo "Password file exists."
fi

dir=/home/bozo

if cd "$dir" 2>/dev/null; then 		# "2>/dev/null" hides error message.
    echo "Now in $dir." 
else 
	echo "Can't change to $dir."
fi

Example 7-3. Arithmetic Tests using (())

#!/bin/bash
#  Arithmetic tests.

# The ((...)) construct evaluates and tests numberical expressions.
# Exit status opposite from [ ... ] construct!
(( 0 ))
echo "Exit status of \"(( 0 ))\" is $?."		# 1

(( 1 ))
echo "Exit status of \"(( 1 ))\" is $?"			# 0

(( 5 > 4 ))										# true
echo "Exit status of \"(( 5 > 4 ))\" is $?."	# 0

(( 5 > 9 ))										# false
echo "Exit status of \"(( 5> 9 )) \" is $?"		# 1

(( 5 - 5 ))										# 0
echo "Exit status of \"(( 5 -5 ))\" is $?."		# 1

(( 5 / 4 ))										# Division o.k.
echo "Exit status of \"(( 5 / 4 ))\" is $?."	# 0

(( 1 / 2 ))										# Division result < 1.
echo "Exit status of \"(( 1 / 2 ))\" is $?"		# Rounded off to 0.
                                                #
(( 1 / 0 ))										# Division result < 1.
echo "Exit status of \"(( 1 / 0 ))\" is $?"		# Rounded off to 0.
												# 1

(( 1 / 2 ))										# Division result < 1.
echo "Exit status of \" (( 1 / 2 ))\" is $?"	# Rounded off to 0.
												# 1

(( 1 / 0 )) 2>/dev/null 						# Illegal division by 0.
#			^^^^^^^^^^^
echo "Exit status of \"(( 1 / 0 ))\" is $?"		# 1

# What effect dose the "2>/dev/null" have?
# What would happed if it were removed?
# Try remove it, then rerunning the script.

exit 0

7.2 File test operators
-e : file exists 
-f : file is a regular file (not a directory or device file)
-s : file is not zero size
-d : file is a directory
-b : file is a block device(floppy, cdrom,etc)
-c : file is a character device(keyboard,modem,sound card,etc.)
-p : file is a pipe
-h : file is a symboloc link
-L : file is a symboloc link 
-S : file is a socket
-t : file(descriptor) is associated with a terminal device
	This test option may be used to check whether the stdin ([ -t 0 ]) 
	or stdout ([ -t 1 ])in a given script is a terminal.
-r : file has read permission (for the user running the test)
-w : file has write permission(for the user running the test)
-x : file has execute permission(for the user running the test)
-g : set-group-id(sgid) flag set on file or directory
     If a directory has the sgid flag set, then a file created within that 
     directory belongs to the group that owns the directory, not necessarily
     to the group of the user who created the file. This may be useful for a
     directory shared by a workgroup.
-u : set-user-id(suid) flag set on file
-O : you are owner of file
-G : group-id of file same as yours
-N : file modified since it was last read
f1 -nt f2 : file f1 is newer than f2
 f2 : file f1 is older than f2
f1 -ef f2 : files f1 and f2 are hard links to the same file 
! : "not" -- reverses the sense of the tests above(return true if condition absent).

Example 7-4. Testing for broken links

#!/bin/bash
# broken-link.sh
#  A pure shell script to find dead symlinks and output them quoted
#+ so they can be fed to xargs and dealt with :)
#+ eg. sh broken-link.sh /somedir /someotherdir | xargs rm 
#
#  This, however, is a better method:
#
#  find "somedir" -type l -print0|\
#  xargs -r0 file|\
#  grep "broken symboloc"|
#  sed -e 's/^/\|: *broken symboloc.*$/"/g'
#
#+ but that wouldn't be pure Bash, now would it.
#  Caution: beware the /proc file system and any circular links!
#################################################################


#  If no args are passed to the script set directories-to-search
#+ to current directory. Otherwise set the directories-to-search
#+ to the args passed.
######################
[ $# -eq 0 ] && directorys=`pwd` || directory=$@

#  Setup the function linkchk to check the directory it is passed
#+ for files that are links and don't exists, then print them quoted.
#  If one of the elements in the directory is a subdirectory then
#+ send that subdirectory to the linkcheck function.
######################

linkchk () {
	for element in $1/*; 
	do
	    [ -h "$element" -a ! -e "$element" ] && echo \"$element\"
	    [ -d "$element" ] && linkchk $element
	# Of course, '-h' tests for symboloc link, '-d' for directory.
	done
}

#  Send each arg that was passed to the script to the linkchk() function
#+ if it is a valid directory. If not, then print the error message
#+ and usage info.
#######################
for directory in $directorys
do
    if [ -d $directory ]; then
    	linkchk $directory
    else 
    	echo "$directory is not a directory"
    	echo "Usage: $0 dir1 dir2 ..."
    fi
done

exit $?

7.3. Other Comparison Operators 
integer comparison 

-eq : is equal to 
	  if [ "$a" -eq "$b" ]
-ne : is not equal to
      if [ "$a" -ne "$b" ]
-gt : is greater than 
      if [ "$a" -gt "$b" ]
-ge : is greater than or equal to 
      if [ "$a" -ge "$b" ]
-lt : is less than
      if [ "$a" -lt "$b" ]
-le : is less than or equal to 
      if [ "$a" -le "$b" ]

<   : is less than (within double parentheses)
	  (("$a" < "$b"))
<=  : is less than or equal to (within double parentheses)
	  (("$a" <= "$b"))
>	: is greater than(within double parentheses)
	  (("$a" > "$b"))
>=	is greater than or equal to(within double parentheses)
	  (("$a" >= "$b"))

string comparison 
=	: is equal to 
	  if [ "$a" = "$b" ]
==  : is equal to
	  if [ "$a" == "$b" ]
	  This is a synonym for ==.
!=	: is not equal to 
	  if [ "$a" != "$b" ]
	  This operator uses pattern mathing within a [[...]] construct.
<	: is less than, in ASCII alphabetical order
	  if [[ "$a" < "$b" ]]
	  if [ "$a" \< "$b" ]
	  Note that "<" needs to be escaped within a [] construct.
>	: is greater than, in ASCII alphabetical order
	  if [[ "$a" > "$b" ]]
	  if [ "$a" \> "$b" ]
	  Note that the ">" needs to be escaped within a [] construct.
-n 	: string is not "null."
-z  : string is "null", that is, has zero length

Example 7-5. Arithmetic and string comparisons
#!/bin/bash
a=4
b=5

#  Here "a" and "b" can be treated either as integers or strings.
#  There is some blurring between the arithmetic and string comparisons,
#+ since Bash variables are not strongly typed.

#  Bash permits integer operations and comparisons on variables
#+ whose value consists of all-integer characters.
#  Caution advised, however.

echo 
if [ "$a" -ne "$b" ]; then 
	echo "$a is not equal to $b"
	echo "(arithmetic Comparison)"
fi 

echo 

if [ "$a" != "$b" ]; then 
    ehco "$a is not equal to $b."
    echo "(string comparison)"
    #	"4" != "5"
    #  ASCII 52 != ASCII 53
fi

# In this particular instance, both "-ne" and "!=" work.

echo 

exit 0

Example 7-6. Testing whether a string is null

#!/bin/bash
#  str-test.sh: Testing null strings and unquoted string,
#+ but not strings and sealing wax, not to mention cabbages and kings ...

# Using if [ ... ]

# If a string has not been initialized, it has no defined value.
# This state is called "null" (not the same as zero).

if [ -n $string1 ]; then					# $string1 has not been declared or initialized.
	echo "String \"string1\" is not null."
else
	echo "String \"string1\" is null."
fi
# Wrong result.
# Shows $string1 as not null, although it was not initialized.

echo 

# Lets try it again.
if [ -n "$string1" ]; then		# This time, $string1 is quoted.
	echo "String \"string1\" is not null."
else
	echo "String \"string1\" is null."
fi 								# Quote strings within test brackets!

echo 

if [ $string1 ]; then			# This time, $string1 stands naked.
	echo "String \"string1\" is not null."
else
	echo "String \"string1\" is null." 
fi
# This works fine.
# The [ ] test operator alone detects whether the string is null.
# However it is good practice to quote it ("$string1").
#
# As Stephane Chazelas points out,
#		if [ $string1 ]		has one argument, "]"
#		if [ "$sting1" ]	has two arguments, the empty "$string1" and "]"

echo 

string1=initialized
if [ $string1 ]; then				# Again, $string1 stands naked. 
	echo "String \"$string1\" is not null"
else 
	echo "String \"$string1\" is null."
fi
# Again, gives correct result1.
# Still, it is better to quote it ("$string1"), because ...

string1="a = b"

if [ $string1 ]; then 				# Again, $string1 stands naked.
	echo " String \"$string1\" is not null." 
else 
	echo "String \"$string1\" is null."
fi
# Not quoting "$string1" now gives wrong result!
exit 0
# Thank you, also, Florian Wisser, for the "heads-up".

Example 7-7. zmore

#!/bin/bash
#  zmore

# View gzipped files with 'more'

E_NOARGS=65
NOTFOUND=66
NOTGZIP=67
if [ $# -eq 0 ]; then 				# same effect as: if [ -z "$1" ]
# $1 can exist, but be empty: zmore "" arg2 arg3
	echo "Usage: `baesename $0` filename" >&2
	# Error message to stderr.
	exit $E_NOARGS
	# Returns 65 as exit status of script (error code).
fi

filename=$1

if [ ! -f "$filename" ]; then		# Quoting $filename allows for possible spaces.
	echo "File $filename not found!" >&2
	# Error message to stderr.
	exit $NOTFOUND 
fi

if [ ${filename##*.} != "gz" ]; then
# Using bracket in variable substitution.
	echo "File $1 is not a gzipped file!"
	exit $NOTGZIP 
fi

zcat $1 | more 

# Uses the filter 'more.'
# May substitute 'less', if desired.

exit $?		#	Script returns exit status of pipe.
# Actually "exit $?" is unnecessary, as the script will, in any case,
# return the exit status of the last command executed.

-a : logical and 
	 exp1 -a exp2 return true if both exp1 and exp2 are true.
-o : logical or 
	 exp1 -o exp2 returns true if either exp1 or exp2 are true.

7.4. Nested if/then Condition Tests 
if [ condition1 ]; then
	if [ condition2 ];then
		do-something	# But only if both "conditition1" and "conditition2" valid. 
	fi
fi

8.1. Operators 
assignment 
variable assignment 
	Initialized or changing the value of a variable 

var=27
cateory=minerals 	# No spaces allowed after the "=".

# = as a test operator
if [ "string1" = "$string2" ]; then
	command 
fi

#  if [ "X$string1" = "X$string2" ] is safter,
#+ to prevent an error message should noe of the variables be empty,
#  (The prependde "X" characters cancel out.)

Example 8-1. greatest command divisor

#!/bin/bash
#  gcd.sh: greatest common divisor
#		   Uses Euclid's algorithm

#  The "greatest common divisor" (gcd) of two integers
#+ is the largest integer that will divide both, leaving no remainder.

#  Euclid's algorithm uses successive division.
#  In each pass,
#+ dividend <-- divisor
#+ until remainder = 0.
#+ The gcd = dividend, on the final pass.
#
#  For an excellent discussion of Euclid's algorithm, see
#+ Jim Loy's site, http://www.jimloy.com/number/euclids.htm.

# -----------------------------------------------------------
# Argument check
ARGS=2
E_BADARGS=65

if [ $# -ne "$ARGS" ]; then
	echo "Usage: `basename $0` first-number second-number"
	exit $E_BADARGS
fi
# -----------------------------------------------------------

gcd ()
{
	dividend=$1		#  Arbitrary assignment.
	divisor=$2		#  It doesn't matter which of the two is larger.
					#  Why not?
	remainder=1		#  If uninitialized variable used in loop,
					#+ it results in an error message
					#+ on the first pass through loop.
	until [ "$remainder" -eq 0 ]
	do
		let "remainder = $dividend % $divisor"
		dividend=$divisor	# Now repeat with 2 smallest numbers.
		divisor=$remainder
	do 						# Euclid's algorithm
} 							# Last $dividend is the gcd.

gcd $1 $2

echo; echo "GCD of $1 and $2 = $dividend"; echo 

#  Exercise :
#  ----------
#  Check command-line arguments to make sure they are integers,
#+ and exit the script with an appropriate error message if not.

exit 0

Example 8-2. Using Arithmetic Operations
#!/bin/bash
# Counting to 11 in 10 different ways.

n=1; echo -n "$n "
let "$n + 1"	# let "n = n + 1" also works.
echo -n "$n "

: $((n = $n + 1))
# ":" necessary because otherwise Bash attempts
#+ to interpret "$((n = $n + 1))" as a command.
echo -n "$n "

(( n = n +1 ))
# A simpler alternative to the method above.
# Thanks, David Lombard, for pointing this out.
echo -n "$n "

n=$(($n + 1))
echo -n "$n "

: $[ n = $n + 1 ]
#  ":" necessary because otherwise Bash attemots
#+ to interpret "$[ -n $n + 1 ]" as a  command.
#  Works even if "n" was initialized as a string.
echo -n "$n "

n=$[ $n + 1 ]
#  Works even if "n" was initialized as a string.
#* Avoid this type of construct, since it is obsolete and nonportable.
#  Thanks, Stepane Chazelas.
echo -n "$n "

# Now for C-styple increment operators.
# Thanks, Frank Wang, for pointing tis out.

let "n++"	# let "++n" as works
echo -n "$n "

n=$[ $n + 1 ]
#  Works even if "n" was initialized as a string.
#* Avoid this type of construct, since it is obsolete and nonportable.
#  Thanks, Stephane Chazelas.
echo -n "$n "

# Now for C-style increment operators.
# Thanks, Frank Wang, for poingting this out.

let "n++"	# let "++n" also works.
echo -n "$n "

(( n++ )) 	# (( ++n )) also works.
echo -n "$n "

: $(( n++ )) 	# : $(( ++n )) also works.
echo -n $"n "

: $[ n++ ] 		# : $[ ++n ] also works
echo -n "$n "

echo 

exit 0

Example 8-3. Compound Condition Tests Using && and ||

#!/bin/bash

a=24
b=47

if [ "$a" -eq 24 ] && [ "$b" -eq 47 ]; then  
	echo "Test #1 succeeds. "
else 
	echo "Test #1 fails. "
fi

#  ERROR:	if [ "$a" -eq 24 && "$b" -eq 24 ]
#+ 			attempts to execute '[ "$a" -eq 24 '
#+			and fails to findding matching ']'.
#
#  Note: if [[ $a -eq 24 && $b -eq 24 ]] works.
#  The double-bracket if-test is more flexible
#+ than the single-bracket version.
#  (The "&&" has a different meaning in line 17 than in line 6.)
#   Thanks, Stephane Chazelas, for pointing this out.

if [ "$a" -eq 98 ] || [ "$b" -eq 47 ]; then  
	echo "Test #2 succeeds. "
else
	echo "Test #2 fails. "
fi

#  The -a and -o options provide
#+ an alternative compound condition test.
#  Thanks to Patrick Callahan for pointing this out.

if [ "$a" -eq 24  -a "$b" -eq 47 ]; then  
	echo "Test #3 successds. "
else
	echo "Test #3 fails. "
fi

if [ "$a" -eq 98 -o "$b" -eq 47 ]; then 
	ehco "Test #4 successds. "
else
	echo "Test #4 fails. "
fi

a=rhino
b=crocodile
if  [ "$a" = rhino ] && [ "$b" = crocodile ]; then
	echo "Test #5 successds. "
else
	echo "Test #5 fails. "
fi
exit 0

8.2. Numberical Constants
Example 8-4. Representation of numberical constants 

#!/bin/bash
# numbers.sh: Representation of numbers in different bases.

# Decimal: the default
let "dec = 32"
echo "Decimal number = $dec"	# 32
# Nothing out of the ordinary here.

# Octal: numbers preceded by '0' (zero)
let "oct = 032"
echo "octal number = $oct"		# 26
# Expresses result in decimal.
# ----------------------------------------

# Hexadecimal: numbers preceded by '0x' or '0X'
let "hex = 0x21"
echo "hexadecimal number = $hex"	# 50

echo $((0x9abc))					# 39612
#		^^     ^^					double-parenthesses arithmetic expansion/evaluation
# Expreses result in decimal.

# Other bases: BASE#NUMBER
# BASE between 2 and 64.
# NUMBER must use symbols within the BASE range, see below.

let "bin 2#111100111001101"
echo "base-32 number $bin"			# 31181

let "b32 = 32 #77"
echo "base-64 number = $b32"		# 231

let "b64 = 64#@_"
echo "base-64 number =$b64"			# 4031
# This notation only works for a limited range (2- 64) of ASCII characters.
# 10 digits + 26 lowercase characters + 26 uppercase characters + @ + _

echo 

echo $((36#zz)) $((2#10101010)) $((16#AF16)) $((53#1aA))
									# 1295 170 44822 3375

#  Important note:
#  -------------------------
#  Using a digit out of range of the specified base notation
#+ gives an error message.
let "bad_oct = 081"
# (Partial) error message output:
# bad_oct = 081: value too great for base (error token is "081")
#				Octal numbers use only digits in the range 0 - 7.

exit 0 			# Thanks, Rich Bartell and Stephane Chazelas, for clarification.

#!/bin/bash
for n in 0 1 2 3 4 5 
do
	echo "BASH_VERSINFO[$n] = ${BASH_VERSINFO[$n]}"
done

# BASH_VERSINFO[0] = 3				# Major version no.
# BASH_VERSINFO[1] = 00				# Minor version no.
# BASH_VERSINFO[2] = 14				# Patch level.
# BASH_VERSINFO[3] = 1				# Build version.
# BASH_VERSINFO[4] = release		# Release status.
# BASH_VERSINFO[5] = i386-redhat-linux-gnu	# Architecture
											# (same as $MACHTYPE).

Example 9-1. $IFS and whitespace
#!/bin/bash
# $IFS treats whitespace differently than other characters.

output_args_one_per_line()
{
	for arg 
	do
		echo "[$arg]"
	done
}

echo; echo "IFS=\" \""
echo "-----------------"

IFS=" "
var=" a  b c    "
output_args_one_per_line $var # output_args_one_per_line `echo " a  b c   "`
#
# [a]
# [b]
# [c]

echo; echo "IFS=:"
echo "------------"

IFS=:
var=":a::b:c:::" 			# Same as above, but substitute ":" for " ".
output_args_one_per_line $var
#
# []
# [a]
# []
# [b]
# [c]
# []
# []
# []

# The same thing happens with the "FS" field separator in awk.

# Thank you, Stephane Chazelas.
echo 
exit 0

#!/bin/bash

E_WRONG_DIRECTORY=73

clear 		# Clear screen.

TargetDirectory=/home/bozo/projects/GreatAmericanNovel
cd $TargetDirectory
echo "Deleting stale files in $TargetDirectory."

if [ "$PWD" != "$TargetDirectory" ]
then		# Keep from wiping out wrong directory by accident. 
	echo "Wrong directory!"
	echo "In $PWD, rather than $TargetDirectory!"
	echo "Bailing out!"
	exit $E_WRONG_DIRECTORY
fi

rm -rf *
rm .[A-Za-z0-9]*		# Delete dotfiles.
# rm -f .[^.]* ..?*		to remove filenames beginning with multiple dots.
# (shopt -s dotglob; rm -rf *) will also work.
# Thanks, S.C for pointing this out.

# Filenames may contain characters in the 0 -255 range, except "/".
# Deleting files beginning with weird characters is left as exercise.

# Various other operations here, as necesary.

echo 
echo "Done. "
echo "Old files deleted in $TargetDirectory."
echo 

exit 0

#!/bin/bash
# reply.sh
# REPLY is the default value for a 'read' command.

echo
echo -n "What is your favorite vegetable? "
read

echo "Your favorite vegetable is $REPLY."
#  REPLY holds the value of last "read" if and only if
#+ no varaible supplied.

echo
echo -n "What is your favorite fruit? "
read fruit
echo "Your favorite fruit is $fruit. "
echo "but... "
echo "Value of \$REPLY is still $REPLY."
#  $REPLY is still set to its previous value because
#+ the variable $fruit absorbed the new "read" value.

echo 

exit 0

#!/bin/bash

TIME_LIMIT=10
INTERVAL=1

echo
echo "Hit Control-C to exit before $TIME_LIMIT seconds."
echo 

while [ "$SECONDS" -le "$TIME_LIMIT" ]
do
	if [ "$SECONDS" -eq 1 ]; then
		units=second
	else
		units=seconds
	fi

	echo "This script has been running $SECONDS $units. "
	#  On a slow or overburdened machine, the script may skip a count
	#+ every once in a while.
	sleep $INTERVAL
done

echo -e "\a"	# Beep!

exit 0

#!/bin/bash
# works in scripts for Bash, version 2.05b and laster.

TMOUT=5		# Prompt times out at three seconds.

echo "What is your favorite songs?"
echo "Quickly now, you only have $TMOUT seconds to answer！"
read song

if [ -z "$song" ]; then
	song="(no answer)"
	#  Default response. 
fi

echo "Your favorite song is $song."

Example 9-2. Timed Input

#!/bin/bash
# timed-input.sh

# TMOUT=3 	Also works, as of newer versions of Bash.

TIME_LIMIT=3	# Three seconds in this instance. May be set to different value.

PrintAnswer()
{
	if [ "$answer" = TIMEOUT ]; then
		echo $answer
	else 			# Don't want to mix up the two instances.
		echo "Your favorite vegetable is $answer"
		kill $!		# $! is PID of last job running in backgroup.	 
	fi
}

TimerOn()
{
	sleep $TIME_LIMIT && kill -s 14 $$ &
	# Waits 3 seconds, then sends sigalarm to script.
}

Int14Vector()
{
	answer="TIMEOUT"
	PrintAnswer
	exit 14
}

trap Int14Vector 14		# Timer interrupt (14) subverted for our purposes.

echo "What is your favorite vegetable "
TimerOn
read answer
PrintAnswer

#  Admittedly this is a kludgy implementation of timed input,
#+ however the "-t" option to "read" simplifies this task.
#  See "--out.sh", below.

#  If you need something really elegant...
#+ consider writing the application in C or C++,
#+ using appropriate library functions, such as 'alarm' and 'setitimer'.

exit 0

Example 9-3. Once more, timed input

#!/bin/bash
# timeout.sh

#  Written by Stephane Chazelas,
#+ and modified by the document author.

INTERVAL=5			# timeout interval

timeout_read()
{
	timeout=$1
	varname=$2
	old_tty_settings=`stty -g`
	stty -icanon min 0 time ${timeout} 0
	eval read $varname 	# or just read $varname
	stty "$old_tty_settings"
	# See man page for "stty".
}

echo; echo -n "What's your name? Quickly!"
timeout_read $INTERVAL your_name

#  This may not work on every terminal type.
#  The maximum timeout depends on the terminal.
#+ (it is often 25.5 seconds).
echo 

if [ ! -z "your_name" ]; then # If name input before timeout...
	echo "Your name is ${your_name}."
else
	echo "Timed out." 
fi

echo 

# The behavior of this script differs somewhat from "time-input.sh".
# At each keystroke, the counter resets.

exit 0

Example 9-4. Timed read

#!/bin/bash
# t-out.sh
# Inspired by a suggestion from "syngin seven" (thanks).

TIME_LIMIT=4		# 4 seconds

read -t $TIME_LIMIT variable <&1
#								^^^
#  In this instance, "<&1" is needed for Bash 1.x and 2.x,
#  but unnecessary for Bash 3.x.

echo 

if [ -z "$variable" ]; then		# Is null?
	echo "Timed out, variable still unset."
else
	echo "variable = $variable"
fi

exit 0

Example 9-5. A吗I root?
#!/bin/bash
# am-i-root.sh:	Am I root or not?

ROOT_UID=0		# Root has $UID 0.

if [ "$UID" -eq "$ROOT_UID" ]; then will the real "root" please stand up?
	echo "You are root."
else
	ehco "You are just an ordinary user (but mom loves you just the same)." 
fi

exit 0

# ============================================================== #
# Code below will not execute, because the script already exited.

# An alternate method of getting to the root of matters:

ROOTUSER_NAME=root

username=`id -nu`		# Or... username=`whoami`
if [ "$username" = "$ROOTUSER_NAME" ]; then
	echo "Rooty, toot, toot. you are root."
else
	echo "you are just a regular fella."

fi

Example 9-6. arglist； Listing arguments with $* and $@
#!/bin/bash
# arglist.sh
# Invoke this script with serveral arguments, such as "one two three".
E_BADARGS=65

if [ ! -n "$1" ]; then
    echo "Usage: `basename $0` argumental argument2 etc."
    exit $E_BADARGS 
fi

echo 

index=1 		# Initialize count.

echo "Listing args with \"\$*\":"
for arg in "$*"		# Doesn't work properly if "$*" isn't quoted.
do
	echo "Arg #$index = $arg"
	let "index+=1"
done 				# $* sees all arguments as single word.
echo "Entire arg list seen as single word."

echo 

index=1 		# Reset count.
				# What happens if you forget to do this?

echo "Listing args with \"\$@\":"
for arg in "$@"
do
	echo "ARG #$index = $arg"
	let "index+=1"
done 			# $@ sees arguments as separate words.
echo "Arg list seen as separate words."

echo 

index=1 		# Reset count.

echo "Listing args with \$* (unquoted):"
for arg in $*
do
	echo "Arg #$index = $arg"
	let "index+=1"
done 			# Unquoted $* sees arguments as separate words.
echo "Arg list seen as separate words."
exit 0

#!/bin/bash
# Invoke with ./scriptname 1 2 3 4 5

echo "$@"	#	1 2 3 4 5
shift
echo "$@"	#	2 3 4 5
shift 
echo "$@"	#	3 4 5

# Echo "shift" lsses parameter $1.
# "$@" then contains the remainting parameters.

Example 9-7. Inconsistent $* and $@ behavior
#!/bin/bash

#  Erratic behavior of the "$*" and "$@" internal Bash variables,
#+ depending on whether they are quoted or not.
#  Inconsistent handing of word splitting and linefeeds.

set -- "First one" "second" "third:one" "" "Fifth: :one"
# Setting the script arguments, $1, $2, etc.

echo 

echo 'IFS unchanged, using "$*"'
c=0
for i in "$*" 				#	quoted
do echo "$((c+=1)): [$i]"	#	This line remains the same in every instance.
							#	Echo args.
done
echo ---

echo 'IFS unchanged, using $*'
c=0
for in in $* 		# unquoted
do echo "$((c+=1)): [$i]"
done
echo ---

echo 'IFS unchanged, using "$@"'
c=0
for i in "$@"
do
	echo "$((c+=1)): [$i]"
done
echo ---

echo 'IFS unchanged, using $@'
c=0
for i in $@
do
	echo "$((c+=1)): [$i]"
done
echo ---

IFS=:
echo 'IFS=":", using "$*"'
c=0
for in in "$*"
do
	echo "$((c+=1)): [$i]"
done
echo ---

echo 'IFS=":",using $*'
c=0
for i in $*
do
	echo "$((c+=1)): [$i]"
done
echo ---

var=$*
echo 'IFS=":", using "$var" (var=$*)'
c=0
for i in "$var"
do
	echo "$((c+=1)): [$i]"
done
echo ---

echo 'IFS=":", using $var (var=$*)'
c=0
for i in $var
do
	echo "$((c+=1)): [$i]"
done
echo ---

var="$*"
echo 'IFS=":", using $var (var="$*")'
c=0
for i in $var
do
	echo "$((c+=1)): [$i]"
done
echo ---

echo 'IFS=":", using "$var" (var=$*)'
c=0
for i in "$var"
do
	echo "$((c+=1)): [$i]"
done
echo ---

echo 'IFS=":", using "$@"'
c=0
for i in "$@"
do
	echo "$((c+=1)): [$i]"
done
echo ---

echo 'IFS=":", using $@'
c=0
for i in "$@"
do
	echo "$((c+=1)): [$i]"
done
echo ---

var=$@
echo 'IFS=":", using $var (var=$@)'
c=0
for i in "$var"
do
	echo "$((c+=1)): [$i]"
done
echo ---

echo 'IFS=":", using "$var" (var=$@)'
c=0
for i in "$var"
do
	echo "$((c+=1)): [$i]"
done
echo ---

var="$@"
echo 'IFS=":", using "$var" (var="$@")'
c=0
for i in "$var"
do
	echo "$((c+=1)): [$i]"
done
echo ---

echo 'IFS=":", using $var (var="$@")'
c=0
for i in "$var"
do
	echo "$((c+=1)): [$i]"
done

echo 

# Try this script with ksh or zsh -y

exit 0

# This example script by Stephane Chazelas,
# and slightly modifyed by the document author.

Example 9-8. $* and $a when $IFS is empty
#!/bin/bash

#  If $IFS set, but empty,
#+ then "$*" and "$@" do not echo positional params as expected.

mecho ()	# Echo positional parameters.
{
	echo "$1,$2,$3";
}

IFS="" 		# Set, but empty.
set a b c 	# Positional parameters.

mecho "$*"	# abc,,
mecho $*	# a,b,c

mecho $@ 	# a,b,c
mecho "$@"	# a,b,c

#  The behavior of $* and $@ when $IFS is empty depends
#+ on whatever Bash or sh version being run.
#  It is therefore inadvisable to depend on this "feature" in a script.

#  Thanks, Stephane Chazelas.

exit 0

String length $string 
expr length $string
expr "$string": '.*'

stringZ=abcABC123ABCabc
echo ${#stringZ}				# 15
echo `expr length $stringZ`		# 15
echo `expr "$stringZ" : '.*'`

Example 9-10. Inserting a blank line between paragraphs in a text file
#!/bin/bash
# paragraph-space.sh

# Inserts a blank line between paragraphs of a single-spaced text file.
# Usage：$0 <FILENAME

MINLEN=45			# May need to change this value.
#  Assume lines shorter than $MINLEN characters
#+ terminate a paragraph.

while read line 	# For as many lines as the input file has...
do
	echo "$line"	# Output the line itself.

	len=${#line}
	if [ "$len" -lt "$MINLEN" ]; then
		echo 		# Add a blank line after short line.
	fi
done
exit 0

Example 9-11. Generating an 8-character "random" string 
#!/bin/bash
# rand-string.sh 
# Generating an 8-character "random" string.

if [ "-n $1" ];  then	#  If command line argument present,
	str0="$1"			#+ then set start-string to it. 
else
	str0="$$"			#  Else use PID of script as start-string.
fi

POS=2	# Starting from position 2 in the string.
LEN=8	# Extract eight characters.

str1=$( echo "$str0" | md5sum | md5sum )
# Doubly scramble:     ^^^^^^   ^^^^^^

randstring="${str1:$POS:$LEN}"
# Can parameterize ^^^^ ^^^^

echo "$randstring"

exit $?

# bozo$ ./rand-string.sh my-password
# 1bdd88c4

#  No, this is not recommended
#+ as a method of generating hack-proof passwords.

Example 9-12. Converting graphic file formats, with filename change
#!/bin/bash
#  cvt.sh
#  Converts all the MacPaint image files in a directory to 'pbm' format.

#  Uses the "macptopbm" binary from the "netpbm" package,
#+ which is maintained by Brian Henderson
#  Netpbm is a standard part of most linux distros.

OPERATION=macptopbm
SUFFIX=pbm 		# New filename suffix.

if [ -n "$1" ]; then
	directory=$1	# If directory name given as a script argument...
else
	directory=$PWD 	# Otherwise use current working directory. 
fi

#  Assumes all files in the target directory are MacPaint image files,
#+ with a ".mac" filename suffix.

for file in $directory/* 	 #  Filename globbing.
do
	filename=${file%.*c}	 #  Strip ".mac" suffix off filename
							 #+ ('.*c matches everything'
							 #+ between '.' and 'c', inclusive).
	$OPERATION $file  > "$filename.$SUFFIX"
							 #  Redirect conversion to new filename.
	rm -rf $file			 #  Delete original files after converting.
	echo "$filename.$SUFFIX" #  Log what is happening to stdout. 
done

exit 0

#  Exercise:
#  ---------
#  As it stands, this script converts *all* the files in the current
#+ workding directory.
#  Modify it to work *only* on files with a ".mac" suffix.

Example 9-13. Converting streaming audio files to ogg
#!/bin/bash
#  ra2ogg.sh: Convert streaming audio files (*.ra) to ogg.

# Uses the "mplayer" media player program:
# 		http://www.mplayerhq.hu/homepage
#		Appropriate codes may need to be installed for this script to work.
# Uses the "Ogg" library and "oggenc":
#		http://www.xiph.org/

OFILEPREF=${1%%ra}		# Strip off the "ra" suffix.
OFILESUFF=wav 			# Suffix for wav file.
OUTFILE="$OFILEPREF""$OFILESUFF"
E_NOARGS=65

if [ -z "$1" ]; then 	# Must specify a filename to convert.
	echo "Usage: `basename $0` [filename]"
	exit $E_NOARGS
fi

#############################################################################
mplayer "$1" -ao pcm:file=$OUTFILE
oggenc "$OUTFILE"	# Correct file extension automatically added by pggenc.
#############################################################################
rm "$OUTFILE"	#  Delete intermediate *.wav file.
				#  If you want to keep it, comment out above line.

exit $?

#  Note:
#  -----
#  On a Website, simply clicking on a *.ram streaming audio file
#+ usually only downloads the URL of the actual audio file, the *.ra file.
#+ to download the *.ra file itself.

#  Exercises:
#  ----------
#  As is, this script converts only *.ra filenames.
#  Add flexibility by permitting use of *.ram and other filenames.
#
#  If you're really ambitious, expand the script
#+ to do automatic downloads and conversions of streaming audio files.
#  Given a URL, batch download streaming audio files (using "wget")
#+ and convert them.

Example 9-14. Emulating getopt

#!/bin/bash
# getopt_simple.sh
# Author: Chris Morgan
# Used in the ABS Guide with permission.

getopt_simple()
{
	echo "getopt_simple()"
	echo "Parameters are '$*'"
	until [ -z "$1" ]
	do
		echo "Processing parameter of: '$1'"
		if [ ${1:0:1} = '/' ]; then
		    tmp=${1:1} 				# Strip off leading '/' ...
		    parameter=${tmp%%=*} 	# Extract name.
		    value=${tmp##*=}		# Extract value.
		    echo "Parameter: '$parameter', value: '$value'"
		    eval $parameter=$value
		fi
		shift
	done
}

# Pass all options to getopt_simple().
getopt_simple $*

echo "test is '$test'"
echo "test2 is '$test2'"

exit 0

------------

sh getopt_simple.sh /test=value1  /test2=value2

Parameters are '/test=value1 /test2=value2'
Processing parameter of: '/test=value1'
Parameter: 'test', value: 'value1'
Processing parameter of: '/test2=value2'
Parameter: 'test2', value: 'value2'
test is 'value1'
test2 is 'value2'

#######################################################################
${string/substring/replacement}
	Replace first match of $substring with $replacement.
${string//substring/replacement}
	Replace all matches of $substring with $replacement.

stringsZ=abcABC123ABCabc

echo ${stringsZ/abc/xyz}		# xyzABC123ABCabc
								# Replaces first match of 'abc' with 'xyz'.
echo ${stringZ//abc/xyz}		# xyzABC123ABCxyz
								# Replaces all matches of 'abc' with # 'xyz'.

####################################
${string/#substring/replacement}
	If $substring matches front end of $string, substitute $replacement for $substring.

${string/%substring/replacement}
	If $substring matches back end of $string,substring $replacement for $substring.

stringZ=abcABC123ABCabc

echo ${stringZ/#abc/XYZ}		# XYZABC123ABCabc
								# Replaces front-end match of 'abc' with 'XYZ'.
echo ${stringsZ/%abc/XYZ}		# abcABC123ABCXYZ
								# Replaces back-end match of 'abc' with 'xyz'.

9.2.1. Manipulating string using awk

Example 9-15. Alternate ways of extracting substrings
#!/bin/bash
#  substring-extraction.sh

String=23skidool
#		012345678	Bash
#		123456789	awk
#  Note different string indexing system:
#  Bash numbers first character of string as '0'.
#  Awk numbers first character of string as '1'.

echo ${String:2:4}	# position 3 (0-1-2), 4 characters long
											# skid
# The awk equivalent of ${string:pos:length} is substr(string,pos,length).
echo | awk '
{print substr("'"${String}"'",3,4)			# skid
}			
'
#  Piping an empty "echo" to awk gives it dummy input,
#+ and thus makes it unnecessary to supply a filename.

exit 0

9.3. Parameter Substitute
Manipulating and/or expanding variables
${parameter}
	Same as $parameter,i.e., value of the variable parameter. In certain contexts, only the less
ambiguous ${parameter} form works.
May be used for concatenating variable with strings.

your_id=${USER}-on-${HOSTNAME}
echo "$your_id"
#
echo "Old \$PATH = $PATH"
PATH=${PATH}:/opt/bin 	# Add /opt/bin to $PATH for duration of script.
echo "New \$PATH = $PATH"

${parameter-default},${parameter:-default}
If parameter not set, use default.
echo ${username-`whoami`}
# Echoes the result of `whoami`, if varaible $username is still unset.

${parameter-default} and ${parameter:-default} are almost equivalent. The extra: make a difference only
when parameter has been declared, but is null.

#!/bin/bash
#  Param-sub.sh

#  Whether a variable has been declared
#+ affects triggering of the default option
#+ even if the variable is null.

username0=
echo "username0 has been declared, but is set to null."
echo "username0 =$(username0-`whoami`)"
# Will not echo.

echo 

echo username1 has not been declared.
echo "username1 = ${username1-`whoami`}"
# Will echo.

username2=
echo "username2 has been declared, but is set to null."
echo "username2 =${username2:-`whoami`}"
#
# Will echo because of ：- rather than just - in condition test.
# Compare to first instance, above.

#

# Once again:

variable=
# Variable has been declared , but is set to null.

echo "${variable-0}"	# (no output)
echo "${variable:-1}"	# 1
#

unset variable

echo "${variable-2}"	# 2
echo "${variable:-3}"	# 3

exit 0

###################################################
${parameter+alt_value},${parameter:+alt_value}
	If parameter set, use alt_value,else use null string.
echo "##### \${parameter+alt_value} #####"
echo 

a=${parameter+xyz}
echo "a = $a"		# a = 

param2=
a=${param2+xyz}
echo "a = $a"		# a = xyz

param3=123
a=${param3+xyz}
echo "a = $a"		# a =xyz

echo 
echo "##### \${parameter:+alt_value} #####"
echo

a=${param4:+xyz}
echo "a = $a"		# a =

param5=
a=${param5:+xyz}
echo "a = $a"		# a =
# Different result from a=${param5+xyz}

param6=123
a=${param6:+xyz}
echo "a = $a"		# a = xyz

Example 9-16. Using parameter substring and error messages

#!/bin/bash

#  Check some of the system's environmental variables.
#  This is good preventative maintenance.
#  If, for example, $USER, the name of the person at the console, is not set,
#+ the machine will not recognize you.

: ${HOSTNAME?} ${USER?} ${HOME?} ${MAIL?}
	echo 
	echo "Name of the machine is $HOSTNAME."
	echo "You are $USER."
	echo "Your home directory is $HOME."
	echo "Your mail INBOX is located in $MAIL."
	echo 
	echo "If you are reading this messages,"
	echo "critical environmental variables have been set."
	echo 
	echo 

#  -------------------------------------------------------------

#  The ${variablename?} construction can also check
#+ for variables set within the script.

ThisVariable=Value-of-ThisVariable
#  Note, by the way, that string variables may be set
#+ to characters disallowed in their names.
: ${ThisVariable?}
echo "Value of ThisVariable is $ThisVariable".
echo
echo

: ${ZZXy23AB?"ZZXy23AB has not been set."}
#  If ZZXy23AB has not been set,
#+ then the script terminates with an error message.

#  You can specify the error message.
#  : ${variablename?"ERROR MESSAGE"}

#  Same result with:		dummy_variable=${ZZXy23AB?}
#							dummy_variable=${ZZXy23AB?"ZXy23AB has not been set ."}
#
#							echo ${ZZXy23AB?} > /dev/null

#  Compare these methods of checking whehter a variable has been set
#+ with "set -u" ...

echo "You will not see this message, because script already terminated."

HERE=0
exit $HERE 		# Will NOT exit here.

#  In fact, this script will return an exit status (echo $?) of 1.

Example 9-17. Parameter substitution and "usage" messages

#!/bin/bash
#  Usage-message.sh

： ${1?"Usage: $0 ARGUMENT"}
#  Script exits here if command-line parameter absent,
#+ with following error message.
#    usage-message.sh 1: Usage: usage-message.sh ARGUMENT

echo "These two lines echo only if command-line parameter given."
echo "command line parameter = \"$1\""

exit 0 		# Will exit here only if command-line parameter present.

#  Check the exit status, both with and without command-line parameter.
#  If command-line parameter present, then "$?" is 0.
#  If not, then "$?" is 1.

Example 9-18. Length of a variable
#!/bin/bash
#  length.sh
E_NO_ARGS=65

if [ $# -eq 0 ]; then	# Must have command-line args to demo script.
	echo "Please invoke this scrit with one or more comman-line arguments."
	exit $E_NO_ARGS 
fi

var01=abcdEFGH28ij
echo "var01 = ${var01}"
echo "Length of var01 = ${#var01}"

#  Now, let's try embedding a space.
var02="abcd EFGH28ij"
echo "var02 = ${var02}"
echo "Length of var02 = ${#var02}"

echo "Number of command-line arguments passed to script = ${#@}"
echo "Number of command-line arguments-passed to script = ${#*}"

exit 0

#################################
${var#Parttern},${var##Parttern}

	${var#Parttern} Remove from $var the shortest of $Parttern that matches the front end $var.
	${var##Parttern} Remove from $var the longest part of $Pattern that matches the front end of $var

A usage illustration from Example A-7:
#  Function from "days-between.sh" example. # Strips
leading zero(s) from argument passed.

strip_leading_zero() 	#  Strip possiable leading zero(s)
{						#+ from argument passed.
	return=${1#0}		#  The "1" refers to "$1" -- passed arg.
}						#  The "0" is what to remove from "$1" -- strips zeros.

##################################################
"Manfred Schwarb's more elaborate variation of the above:"
strip_leading_zero2 ()		# Strip possiable leading zero(s), since otherwise
{							# Bash will interpret such numbers as octal values.
	shopt -s extglob		# Turn on extended globbing.
	local val=${1##+0}		# Use local variable. longest matching series of 0's.
	shopt -u extglob		# Turn off extended globbing
	_strip_leading_zero2=${val:-0}
							# If input was 0, return 0 instead of "".
}

Another usage illustration:
echo `basename $PWD`		# Basename of current working directory.
echo "${PWD##*/}"			# Basename of current working directory.
echo
echo `basename $0`			# Name of script.
echo $0						# Name of script.
echo "${0##*/}"				# Name of script.
echo
filename=test.data
echo "${filename##*.}"		# data
							# Extension of filename.

############################################
${var%Pattern},${var%%Pattern}
	${var%Pattern}	Remove from $var the shortest part of $Pattern that matches the back end of $var.
	${var%%Pattern} Remove from $var the longest of $Pattern that matches the back end of $var.

Example 9-19. Pattern matching in parameter substitution
#!/bin/bash
#  patt-matching.sh

#  Pattern macthing using the # ## % %% parameter substition operators.

var1=abcd12345abc6789
pattern1=a*c 					# * (wild card) matches everything between a - c.

echo
echo "var1 = $var1"				# abcd12345abc6789
echo "var1 = ${var1}"			# abcd12345abc6789

echo "Number of characters in ${var1} = ${#var1}"
echo

echo "pattern1 = $pattern1"		# a*c (everything between 'a' and 'c')
echo "---------------------"
echo '$(var1#$pattern1) =' "${var1#$pattern1}"		# d12345abc6789
#  Shorttest possible match, stripts out first 12 characters abcd12345abc6789

echo; echo; echo 
pattern2=b*9					# everything between 'b' and '9'
echo "var1 = $var1"				# Still abcd12345abc6789
echo
echo "pattern2 = $pattern2"
echo "---------------------"
echo '${var1%pattern2} =' "${var1%pattern2}"		# abcd12345a
# Shortest possible match, strips out last 6 characters abcd12345abc6789
#
echo '${var1%%pattern2} =' "${var1%%$pattern2}"		# abcd12345a
# Longest possible match, strips out last 12 characters abcd12345abc6789
#

# Remember, # and ## work from the left end (beginning) of string,
#			% and %% work from the right end.

echo 

exit 0

Example 9-20. Renaming file extensions:

#!/bin/bash
# rfe.sh: Rename file extensions.
#
# 			rfe old_extension new_extension
#
# Example:
# To rename all *.gif files in working directory to *.jpg,
#				rfe gif jpg

E_BADARGS=65

case $# in
	0|1)				# The vertical bar means "or" in this context.
	echo "Usage: `basename $0` old_file_suffix new_file_suffix"
	exit $E_BADARGS		# If 0 or 1 arg, then bail out.
	;;
esac

for filename in *.$1
# Traverse list of files ending with 1st argument.
do
	mv $filename ${filename%$1}$2
	#  Strip off part of filename matching 1st argument,
	#+ then append 2nd argument.
done

exit 0

Example 9-21. Using pattern matching to parse arbitrary strings

#!bin/bash

var1=abcd-1234-defg
echo "var1 = $var1"

t=${var1#*-*}
echo "var1 (with everything, up to and including first - stripped out) = $t"
#  t=${var1#*-} works just the same,
#+ since # matches the shortest string,
#+ and * matches everything preceding, including an empty string.
#  （Thanks, Stephane Chazelas, for poingting this out.）

t=${var1##*-*}
echo "If var1 contains a \"-\", returns empty string... var1 = $t"

t=${var1%*-*}
echo "var1 (with everything from the last - on stripped out) = $t"

echo

# --------------------------------------------
path_name=/home/bozo/ideas/thoughts.for.today
# --------------------------------------------
echo "path_name = $path_name"
t=${path_name##/*/}
echo "path_name, stripped of prefixes = $t"
#  Same effect as t=`basename $path_name` in this particular case.
#  t=${path_name%/}; t=${t##*/} is a more general solution,
#+ but still fails sometimes.
#  If $path_name ends with a newline, then `basename $path_name` will not work,
#+ but the above expression will.
#  (Thanks, S.C.)

t=${path_name%/*.*}
#  Same effect as t=`dirname $path_name`
echo "path_name, stripped of suffixes = $t"
#  These will fail in some cases, such as "../", "/foo////", # "foo/", "/".
#  Removing suffixes, especially when the basename has no suffix,
#+ but the dirname does, also complicates matters.
#  (Thanks, S.C.)

echo 

t=${path_name:11}
echo "$path_name, with first 11 chars stripped off = $t"
t=${path_name:11:5}
echo "$path_name, with first 11 chars stripped off, length 5 = $t"

echo 

t=${path_name/bozo/clown}
echo "$path_name with \"bozo\" replaced by \"clown\" =$t"
t=${path_name/today/}
echo "${path_name with \"today\" deleted = $t}"
t=${path_name//o/O}
echo "path_name with all o's capitalized =$t"
t=${path_name//o/}
echo "$path_name will all o's deleted =$t"

exit 0

${var/#Pattern/Replacement}
	If prefix of var matches Pattern, then substitute Replacement for Pattern.
${var/%Pattern/Replacement}
	If suffix of var matches Pattern, then substitute Replacement for Pattern.
Example 9-22. Matching patterns at prefix or suffix of string

#!/bin/bash
# var-match.sh:
# Demo of pattern replacement at prefix / suffix of string.

v0=abc1234zip1234abc			# Original variable.
echo "v0 = $v0"					# abc1234zip1234abc
echo

# Match at prefix (beginning ) of string.
v1=${v0/#abc/ABCDEF}			# abc1234zip1234abc
								# |-|
echo "v1 =$v1"					# ABCDEF1234zip1234abc
								# |----|

# Match at suffix (end)	of string.
v2=${v0/%abc/ABCDEF}			# abc1234zip1234abc
								#				|-|
echo "v2 = $v2"					# abc1234zip1234ABCDEF
								#				|----|

echo 

#  ------------------------------------------
#  Must match at beginning / end string,
#+ otherwise no replacement results.
#  ------------------------------------------
v3=${v0/#123/000}				# Matches , but not at beginning.
echo "v3 = $v3"					# abc1234zip1234abc
								# NO REPLACEMENT.
v4=${v0/%123/000}				# Mathches, but not at end.
echo "v4 = $v4"					# abc1234zip1234abc
								# NO REPLACEMENT.

exit 0

############################################################################
${!varprefix*},${!varprefix@}
Matches names of all previously declared variables beginning with varprefix.

xyz23=whatever
xyz24=

a=${!xyz}		# Exands to *names* of declared variables beginning with "xyz".
echo "a = $a"	# a =xyz23 xyz24
a=${!xyz@}		# Same as above.
echo "a = $a"	# a = xyz23 xyz24

# Bash, version 2.04, adds this feature.

Example 9-23. Using declare to type variables
#!/bin/bash

func1 ()
{
	echo This is a function.
}

declare -f 			# Lists the function above.

echo 

declare -i var1 	# var1 is an integer.
var1=2367
echo "var1 declared as $var1"
var1=var1+1			# Integer declaration elimiates the need for 'let'.
echo "var1 incremented by 1 is $var1."
# Attempt to change variable declared as integer.
echo "Attempting to change var1 to floating point value, 2367.1."
var1=2367.1			# Results in error message, with no change to variable.
echo "var1 is still $var1"
echo

declare -r var2=13.36			#  'declare' permits setting a variable property
								#+ simultaneously assigning it a value.
echo "var2 declared as $var2"	#  Attempt to change readonly variable.
var2=13.37						#  Generates error message, and exit from script.

echo "$var2 is still $var2"		#  This line will not execute.

exit 0							#  Script will not exit here.

9.5. Indirect References
Example 9-24. Indirect Variable References
#!/bin/bash
# ind-ref.sh: Indirect variable referencing.
# Accessing the contents of the contests of a variable.
a=letter_of_alphabet			# Variable "a" holds the name of another variable.
letter_of_alphabet=z

echo 

# Direct reference.
echo "a = $a"			# a = letter_of_alphabet

# Indirect reference.
eval a=\$$a
echo "Now a = $a"		# Now a = z

echo 

# Now, let's try changing the second-order reference.

t=table_cell_3
table_cell_3=24
echo "\"table_cell_3\" = $table_cell_3"					# "table_cell_3" = 24
echo -n "dereferenced \"t\" =" ="; eval echo \$$t 		# dereferenced "t" = 24

#  In this simple case, the following also works (why?).
#  			eval t=\$$; echo "\"t\" = $t"

echo 

t=table_cell_3
NEW_VAL=387
table_cell_3=$NEW_VAL
echo "Changing value of \"table_cell_3\" to $NEW_VAL."
echo "\"table_cell_3\" now $table_cell_3"
echo -n "dereferenced "\t\" now "; eval echo \$$t
# "eval" takes the two arguments "echo" and "\$$t" (set equal to $table_cell_3)

echo 

# (Thanks, Stephane Chazelas, for clearing up the above behavior.)

# Another method is the ${!t} notation, discussed in "Bash, version 2" section.
# See also ex78.sh.

exit 0

####################################################
#!/bin/bash

# ----------------------------------
# This could be "sourced" from a separate file.
isdnMyproviderRemoteNet=172.16.0.100
isdnYourProviderRemoteNet=10.0.0.10
isdnOnlineService="MyProvider"
# ----------------------------------

remoteNet=$(eval "echo \$$(echo iddn$(isdnOnlineService)remoteNet)")
remoteNet=$(eval "echo \$$(echo isdnMyproviderRemoteNet)")
remoteNet=$(eval "echo \$$(isdnMyproviderRemoteNet)")

echo "$remoteNet"			# 172.16.0.100

# ============================================

#  And, it gets even better.

#  Consider the following snipper given a variable named getSparc,
#+ but no such variable getIa64:
chkMirrorArchs () {
	arch="$1";
	if [ "$(eval "echo \${$echo get$(echo -ne $arch |
		sed 's/^\(.\).*/\1/g' | tr 'a-z' 'A-Z'; echo $arch |
		sed 's/^.\(.\)\/1/g')):-false}")" = true ]; then
		return 0;
	else
		return 1;
	fi
}

getSparc="true"
unset getIa64
chkMirrorArchs sparc
echo $?			# 0
				# True
chkMirrorArchs Ia64 
echo $?			# 1
				# False

# Notes:
# -------
# Even the to-be-substituted variable name part is built explicitly.
# The parameters to the chkMirrorArchs calls are all lower case.
# The variable name is composed of two parts: "get" and "Sparc" ...

Example 9-25. Passing an Indirect reference to awk
#!/bin/bash

#  Another version of the "column totaler" script
#+ that adds up a specified column (of numbers) in the target file.
#  This one uses indirect refereces.

ARGS=2
E_WRONGARGS=65
if [[ $# -ne "$ARGS" ]]; then	# Check for proper no. of command line args.
	echo "Usage: `basename $0` filename column-number"
	exit $E_WRONGARGS
fi

filename=$1
column_number=$2

# ====== Same as original script, up to this point ======#

# A multi-line awk script is invoked by awk '......'

# Begin awk script.
# -----------------------------
awk "
{ total += \$${column_number}	# indirect reference
}
END {
	print total
}
	" "$filename"
# ----------------------------
# End awk script.

#  Indirect variable reference avoids the hassles
#+ of referencing a shell variable within the embedded awk script.
#  Thanks, Stephane Chazelas.

exit 0



# 看到这里
http://www.engr.iupui.edu/~dskim/tutorials/bash-advanced/html/randomvar.html


http://www.engr.iupui.edu/~dskim/tutorials/bash-advanced/html/index.html
