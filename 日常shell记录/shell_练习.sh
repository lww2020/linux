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

9.6. $RANDOM: generate random integer
Example 9-26. Generating random numbers

#!/bin/bash

# $RANDOM returns a different random integer at each invocation.
# Nominal range: 0-32767 (signed 16-bit integer).

MAXCOUNT=10
count=1

echo
echo "$MAXCOUNT random numbers:"
echo "--------------------------"
while [ "$count" -le $MAXCOUNT ]		# Generate 10 ($MAXCOUNT) random integers.
do
	numbers=$RANDOM
	echo $numbers
	let "count += 1"					# Increment count.
done
echo "--------------------------"

# If you need a random int within a certain range, use the 'modulo' operator.
# This returns the remainder of a division operation.

RANGE=500

echo

numbers=$RANDOM
let "number %= $RANGE"
#
echo "Random number less than $RANGE --- $number"

echo 

#  If you need a random integer greater than a lower bound,
#+ then set up a test to discard all numbers below that.

FLOOR=200
number=0		# initizlize
while [ "$number" -le $ $FLOOR ]
do
	number=$RANDOM
done
echo "Random number greater than $FLOOR --- $number"
echo
	# Let's examine a simple alternative to the above loop, namely
	#		let "number =$RANDOM + $FLOOR"
	# That would eliminate the while the while-loop and run faster.
	# But, there might be a problem with that, What is it?


# Combine above two techniques to retrieve random number between two limits.
number=0	# initialize
while [ "$number" -le "$FLOOR" ]
do
	number=$RANDOM
	let "number %= $RANGE"		# Scales $number down within $RANGE.
done
echo "Random number between $FLOOR and $RANGE --- $number"
echo

# Generate binary choice, that is, "true" or "false" value.
BINARY=2
T=1
number=$RANDOM

let "number %= $BINARY"
#  Note that let "number >>=14"		gives a better random distribution
#+ (right shifts out everything except last binary digit).
if [ "$number" -eq $T ]; then
	echo "TRUE"
else
	echo "FALSE"
fi 

echo


# Generate a toss of the dice.
SPOTS=6			# Modulo 6 gives range 0 -5
				# Incrementing by 1 gives desired range of 1 -6
				# Thanks, Paulo Marcel Coelho Arago, for the simplification.
diel=0
die2=0
# Would it be better to just set SPOTS=7 and not add 1? Why or why not?

# Tosses each die separately, and so gives correct odds.

		let "die1 = $RANDOM % $SPOTS +1"	# Roll first one.
		let "die2 = $RANDOM % $SPOTS +1"	# Roll second one.
		#  Which arithmetic operation, above, has greater precedence --
		#+ modulo (%) or addition (+)?

let "throw = $die1 + $die2"
echo "Throw of the dice = $throw"
echo 

exit 0

Example 9-27. Picking a random card from deck 

#!/bin/bash
# pick-card.sh

# This is an example of choosing random elements of an array.

# Pick a card, any card.

Suites="Clubs
Diamonds
Hearts
Spades
"

Denominations="2
3
4
5
6
7
8
9
10
Jack
Queen
king
Ace
"
# Note variables spread over multiple lines.

suite=($Suites)			# Read into array variable.
denmination=($Denominations)

num_suites=$(#suite[*])	# Count how many elements.
num_denominations=${#denomonation[*]}
echo ${suite[$((RANDOM%num_suites))]}

# $bozo sh pick-cards.sh
# Jack of Clubs

# Thank you, "jipe," for pointing out this use of $RANDOM.
exit 0

Example 9-28. Brownian Motion Simulation

#!/bin/bash
# brownian.sh
# Author: Mendel Cooper
# Reldate: 10/26/07
# License: GPL3

#  ---------------------------------------------------------
#  This script models Brpwnian motion:
#+ the random wanderings of tiny particles in a fluid,
#+ as they are impacted by random currents and collisions.
#+ This is also known as the "Drunkard's Walk."

#  It can also be considered as a highly simplified simulation of a
#+ Galton Board, a slanted board with a pattern of pegs,
#+ down which rolls a succession of marbles, one at a time.
#+ At the bottom is a row of slots or catch basins in which
#+ the marbles finally come to rest.
#  Think of it as a kind of bare-bones Pachinko game.
#  As you see by running the script,
#+ most of the marbles cluster around the center slot.
#+ This mirrors the expected "Normal Distribution."
#  As a Galton Board simulation, this script
#+ disregards such parameters as 
#+ board tilt-angle, rolling friction of the marbles,
#+ angles of impact, and elasticity of the pegs.
#  How much of a difference does that make?
#  ---------------------------------------------------------

PASSES=500				# Number of particle interactions / marbles.
ROWS=10					# Number of "collisions" (or horizontal peg rows).
RANGE=3					# We want 0 - 2 output range from $RANDOM.
POS=0					# Left/right position.

declare -a slots 		# Array holding cumulative results of passes.
NUMSLOTS=21				# How many slots at bootom of board?

Initialize_Slots () 	# Zero out all elements of array.
{
for i in $(seq $NUMSLOTS)
do 
	Slots[$i]=0
done
echo 					# Blank line at beginning of run.
}

Show_Slots () 
{
echo -n " "
for i in $(seq $NUMSLOTS)		# Pretty-print array elements.
do
	printf "%3d" $(Slots[$i])	# Three spaces per result.
done

echo 	# Row of slots:
echo 	"|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|"
echo 
echo 	#  Note that if the count within any particular slot exceeds 99,
		#+ it messes up the display.
		#  Running only(!) 500 passes usually avoids this.
}

Move ()						# Move one unit right / left, or stay put.
{
	Move=$RANDOM 			# How random is $RANDOM? Let's see. ...
	let "Move %= RANGE"		# Normalize into range of 0 -2.
	case "$Move" in 
		0) ;;				# Do nothing, i.e., stay in place.
		1) ((POS--));;		# Left.
		2) ((POS++));;		# Right.
		*) echo -n "Error"	# Should never happen.
	esac
}

Play ()						# Single pass (inner loop).
{
	i=0
	while [ $i -lt  $ROWS ]	#
	do
		Move
		((i++));
	done

	SHIFT=11				# Why 11, and not 10?
	let "POS += $SHIFT"		# Shift "zero position" to center.
	(( Slots[$POS]++ ))		# DEBUG: echo $POS
}

Run ()						# Outer loop.
{
	p=0
	while [ $p -lt $PASSES ]
	do
		Play
		(( p++ ))
		POS=0				# Reset to zero. Why?
	done
}


# ------------------
# main ()
Initialize_Slots
Run
Show_Slots
# ------------------

exit $?

#  Exercises:
#  ------------------------------------------------------------------
#  1) Show the results in a vertial bar graph, or as an alternative,
#+    a scattergram.
#  2) Alter the script to use /dev/urandom instead of $RANDOM.
# 		Does this make the results more random?

#  Generate random number between 6 and 30.
   rnumber=$((RANDOM%25+6))

#  Generate random number in the same 6 -30 range,
#+ but the number must be evenly divisible by 3.
    rnumber=$((RANDOM%30/3+1)*3))

#  Note that this will not work all the time.
#  It fails if $RANDOM%30 return 0.

#  Frank Wang suggests the following alternative:
   rnumber=$((RANDOM%27/3*3+6))

Example 9-29. Random between values
#!/bin/bash
# random-between.sh
# Random number between two specified values.
# Script by Bill Gradwohl, with minor modifications by the document author.
# Used with permission.

randomBetween () {
	#  Generates a positive or negative random number
	#+ between $min and $max
	#+ and divisible by $divisibleBy.
	#  Gives a "reasonably random" distribution of return values.
	#
	#  Bill Gradwohl -Oct 1, 2003

	syntax() {
		# Function embedded within function.
		echo 
		echo 	"Syntax: randomBetween [min] [max] [multiple]"
		echo -n "Expects up to 3 passed parameters, "
		echo 	"but all are completely optional."
		echo 	"min is the minimum value"
		echo 	"max is the maximum value"
		echo -n "multiple specifies that the answer must be "
		echo 	"a multiple of this value. "
		echo 	"  i.e. answer must be evenly divisible by this number."
		echo 
		echo 	"If any value is missing, defaults area supplied as: 0 32767 1"
		echo -n "Successful completion returns"
		echo 	"unsuccessful completion returns"
		echo 	"function syntax and 1."
		echo -n "The answer is returned in the global variable "
		echo 	"randomBetweenAnswer"
		echo -n "Negative values for any passed parameter are "
		echo 	"handled correctly."
	}

	local min=${1:-0}
	local max=${2:-32767}
	local divisibleBy=${3:-1}
	# Default values assigned, in case parameters not passed to function.

	local x
	local spread

	# Let's make sure the divisibleBy value is positive.
	[ ${divisibleBy} -lt 0 ] && divisibleBy=$((0-divisibleBy))

	# Sanity check.
	if [ $# -gt 3 -o ${divisibleBy} -eq 0 -o ${min} -eq ${max}]; then
		syntax
		return 1
	fi

	# See if the min and max are reversed.
	if [[ ${min} -gt ${max} ]]; then
		# Swap them.
		x=${min}
		min=${max}
		max=${x}
	fi

	#  If min is itself not evenly divisible by $divisibleBy,
	#+ then fix the min to be within range.
	if [[ $((min/divisibleBy*divisibleBy)) -ne ${min} ]]; then
		if [[ ${min} -lt 0 ]]; then
			min=$((min/divisibleBy*divisibleBy))
		else
			min=$((((min/divisibleBy)+1)*divisibleBy))
		fi
	fi

	#  If max is itself not evenly divisible by $divisibleBy,
	#+ then fix the max to be within range.
	if [[ $((max/divisibleBy*divisibleBy)) -ne ${max} ]]; then
		if [[ ${max} -lt 0 ]]; then
			max=$((((max/divisibleBy)-1)*divisibleBy))
		else
			max=$((max/divisibleBy*divisibleBy))
		fi
	fi

	#  -----------------------------------------------------
	#  Now, to do the real work.

	#  Note that yto get a proper distribution for the end points,
	#+ the range of random values has to be allowed to go between
	#+ 0 and abs(max-min)+divisibleBy, not just abs(max-min)+1.

	#  The slight increase will produce the proper distribution for the
	#+ end points.

	#  Changing the formula to use abs(max-min)+1 will still produce
	#+ correct answers, but the randomness of those answers if faulty in
	#+ that the number of times the end points ($min and $max) are returned
	#+ is considerably lower than when the correct formula is used.
	# -----------------------------------------------------------------

	spread=$((max-min))
	#  Omair Eshkenazi points out that this test is unnecessary,
	#+ since max and min have already been switched around.
	[ $[spread] -lt 0 ] && spread=$((0-spread))
	let spread+=divisibleBy
	randomBetweenAnswer=$(((RANDOM%spread)/divisibleBy*divisibleBy+min))

	return 0

	#  However, Paulo Marcel Coelho Aragao points out that
	#+ when $max and $min are not divisible by $divisibleBy,
	#+ the formula fails.
	#
	#  He suggests instead the following formula:
	#     rnumber = $(((RANDOM%(max-min+1)+min)/divisibleBy*divisibleBy))
}

# Let's test the function.
min=-14
max=20
divisibleBy=3

#  Generate an arrary of expected answers and check to make sure get
#+ at least one of each answer if we loop enough.

declare -a answer
minimum=${min}
maximum=${max}
	if [[ $((minimum/divisibleBy*divisibleBy)) -ne ${minimum} ]]; then
		if [[ ${minimum} -lt 0 ]]; then
			minimum=$((minimum/divisibleBy*divisibleBy))
		fi
	fi

#  We need to generate only positive array subscripts,
#+ so we need a displacement that that will gurantee
#+ positive results.

disp=$((0-minimum))
for ((i=${minimum}; i<=${maximum}; i+divisibleBy)); do
	answer[i+disp]=0
done

# Now loop a large number of times to see what we get.
loopIt=1000		#  The script author suggests 100000,
				#+ but that tabkes a good long while.

for ((i=0; i<${loopIt}; ++i)); do

	#  Note that we are specifying min and max in reversed order here to
	#+ make the function correct for this case.

	randomBetween ${max} ${min} ${divisibleBy}

	# Report an error if an answer is unexpected.
	[ ${randomBetweenAnswer} -lt ${min} -o ${randomBetweenAnswer} -gt ${max} ] \
	&& echo MIN or MAX error - ${randomBetweenAnswer}!
	[ $((randomBetweenAnswer%${divisibleBy})) -ne 0 ] \
	&& echo DIVISIBLE BY error - ${randomBetweenAnswer}!

	# Store the answer away statistically.
	answer[randomBetweenAnswer+disp]=$((answer[randomBetweenAnswer+disp]+1))
done

# Let's check the results

for (( i=${minimum}; i<=${maximum}; i+=divisibleBy )); do
	[ ${answer[i+displacement]} -eq 0 ] \
	&& echo "We never got an anserr of $i." \
	|| echo "${i} occurred ${answer[i+displacement]} times."
done

exit 0

Example 9-30. Rolling a single die with RANDOM
#!/bin/bash
# How random is RANDOM?

RANDOM=$$		# Reseed the random number generator using script process ID.

PIDS=6			# A die has 6 pips.
MAXTHROWS		# Increase this if you have nothing better to do with your time.
throw=0			# Throw count.

ones=0			#  Must initialize counts to zero,
twos=0			#+ since an uninitialized variable is null, not zero.
threes=0
fours=0
fives=0
sixes=0

print_result ()
{
	echo
	echo "ones 		= $ones"
	echo "twos		= $twos"
	echo "threes	= $threes"
	echo "fours		= $fours"
	echo "fives		= $fives"
	echo "sixes 	= $sixes"
	echo
}

update_count ()
{
	case "$1" in
		0) let "ones 	+= 1";;		# Since die has no "zero", this corresponds to 1.
		1) let "twos 	+= 1";;		# And this to 2, etc.
		2) let "three 	+= 1";;
		3) let "fours	+= 1";;
		4) let "fives	+= 1";;
		5) let "sixes 	+= 1";;
	esac		
}

echo 

while [ "$throw" -lt "$MAXTHROWS" ]
do
	let "die1 = RANDOM % $PIPS"
	update_count $diel
	let "throw += 1"
done

print_result

exit 0

#  The scores should distribute fairly evenly, assuming RANDOM is fairly random.
#  With $MAXTHROWS at 600, all shold cluster around 100, plus-or-minus 20 or so.
#
#  Keep in mind that RANDOM is a pseudorandom generator,
#+ and not a spectacularyly good one at that.

#  Randomness is a deep and complex subject.
#  Sufficiently long "random" sequences may exhibit
#+ chaotic and other "non-random" behavior.

# Exercise (easy):
# ----------------
# Rewrite this script to flip a coin 1000 times.
# Choices are "HEADS" and "TAILS".

Example 9-31. Reseeding RANDOM
#!/bin/bash
# seeding-random.sh Seeding the RANDOM variable.

MAXCOUNT=25 	# How many numbers to generate.

random_numbers ()
{
	count=0
	while [[ "$count" -lt "$MAXCOUNT" ]]; do
		numbers=$RANDOM
		echo -n "$number"
		let "count += 1"
	done
}

echo; echo

RANDOM=1 	# Setting RANDOM seeds the random number generateor.
random_numbers

echo; echo

RANDOM=1			# Same seed for RANDOM
random_numbers		# ...reproduces the exact same number series.
					#
					# When is it useful to duplicate a "random" number series?
echo; echo

RANDOM=2			# Trying again, but with a different seed...
random_numbers		# gives a different number series.

echo; echo

#  RANDOM=$$ seeds RANDOM from process id of script.
#  It is also possible to seed RANDOM from 'time' or 'date' commands.

#  Getting fancy...
SEED=$(head -1 /dev/urandom| od -N 1| awk '{print $2}')
#  Pseudo-random output fetched
#+ from /dev/urandom (system pseudo-random device-file),
#+ finally "awk" retrives just one number for SEED.
RANDOM=$SEED
random_numbers

echo; echo

exit 0

Example 9-32. Pseudorandom numbers, using awk
#!/bin/bash
# random2.sh: Returns a pseudorandom number in the range 0 -1.
#  Uses the awk rand() function.

AWKSCRIPT="{srand(); print rand()}"
#			Command(s) / parameters passed to awk
#  Note that srand() reseeds awk's random number generator.

echo -n "Random number between 0 and 1 = "

echo | awk "$AWKSCRIPT"
# What happens if you leave out the 'echo'?

exit 0

#  Exercises:
#  ----------------

#  1）Using a loop construct, print out 10 different random numbers.
#		(Hint: you must reseed the "srand()" function with a different seed
#+		in each pass through the loop. What happens if you fail to do this?)

#  2) Using an integer multiplier as a scaling factor, generate random numbers
#+	  in the range between 10 and 100.

#  3) Same as exercise #2, above, but generate random integers this time.

9.7. The Double Parentheses construct
Example 9-33. C-style manipulation of variables
#!/bin/bash
# Manipulating a variable, C-styple, using the ((...)) construct.

echo

(( a = 23 ))	# Setting a value, C-style,
				#+ with spaces on both sides of the "=".
echo "a (initial value) $a"

(( a++ ))		# Post-increment 'a', C-style.
echo "a (after a++) = $a"

(( a-- ))		# Pre-increment 'a', C-styple.
echo "a (after ++a) = $a"

(( -- a))		# Pre-decrement 'a', C-style.
echo "a (after --a) = $a"

echo 

###########################################################
#  Note that, as in C, pre- and post-decrement operators
#+ have slightly different side-effects.

n=1; let --n && echo "True" || echo "False"	# False
n=1; let n-- && echo "True" || echo "False" # True

#  Thanks, Jeroen Domdurg.						
###########################################################

echo

(( t = a<45?7:11))	# C-style trinary operator.
#		^  ^ ^
echo "If a < 45, then t = 7, else t = 11."
echo "t = $t"		# Yes!

echo

#  ----------------------------
#  Easter Egg alert!
#+ constructs into Bash (actually adapted from ksh, pretty much).
#  In the Bash docs, Ramey calls ((...)) shell arithmetic,
#+ but it goes far beyond that.
#  Sorry, Chet, the secret is now out.

#  See also "for" and "while" loops using the ((...)) construct.

# These work only with Bash, version 2.04 or later.

exit 0

10.1. Loops
A loop is a block of code that iterates a list of commands as long as the loopcontrol condition is true.
for loops
for arg in [list]
	This is the basic looping construct. It differs significantly from its C counterpart.
	for arg in [list]
	do
		command(s)...
	done
for arg in "$var1" "$var2" "$var3" ... "$varN"
# In pass 1 of the loop, arg = $var1
# In pass 2 of the loop, arg = $var2
# In pass 3 of the loop, arg = $var3
# ...
# In pass N of the loop, arg = $varN

# Arguments in [list] quoted to prevent possible word splitting.

The argument list may contain wild cards.

If do is in same line as for, there needs to be a semicolon after list.
for arg in [list]; do

Example 10-1. Simple for loops
#!/bin/bash
# Listing the planets.

for planet in Mercury Venus Earth Mars Jupiter Saturn Uranus Neptune Pluto
do
	echo $planet # Each plant on a separate line.
done

echo

for planet in "Mercury Venus Earth Mars Jupiter Saturn Uranus Neptune Pluto"
	# All planets on same line.
	# Entire 'list' enclosed in quotes creates a single variable.
	# Why? Whitespace incorporated into the variable.
do
	echo $
done

exit 0

Example 10-2. for loop with two parameters in each [list] element
#!/bin/bash
# Planets revisited.

# Associate the name of each plant with its distance from the sun.

for plant in "Mercury 36" "Venus 67" "Earth 93" "Mars 142" "Jupiter 483"
do
	set -- $planet 	#  Parses variable "planet"
					#+ and sets positional parameters.
	#  The "--" prevents nastr surprises if $planet is null or
	#+ begins with a dash.

	#  May need to save original positional parameters,
	#+ since they get overwritten.
	#  One way of doing this is to use an array,
	#			original_params=("$@")

	echo "$1 		$2,000,000 miles from the sun"
	#------two tabs-----concatenate zeroes onto parameter $2
done

# (Thanks, S.C., for additional clarification.)

exit 0

Example 10-3. Fileinfo:operating on a file list contained in a variable
#!/bin/bash
# fileinfo.sh

FILES="/usr/sbin/accept
/usr/sbin/pwck
/usr/sbin/chroot
/usr/bin/fakefile
/sbin/badblocks
/sbin/ypbind
"
# List of files you are curious about.
# Threw in a dummy file, /usr/bin/fakefile.

echo

for file in $FILES
do
	if [[ ! -e "$file" ]]; then
		echo "$file does not exists."; echo 
		continue 						# On to next.
	fi
	ls -l $file |awk '{print $9 "  file size: " $5}'	# Print 2 fields.
	whatis `basename $file` # File info.
	# Note that the whatis database needs to have been set up for this to work.
	# To do this, as root run /usr/bin/makewhatis.
	echo 
done

exit 0

Example 10-4. Operating on files with a for loop
#!/bin/bash
# list-glob.sh: Generating [list] in a for-loop, using "globbing"

echo

for file in *
#			^	Bash performs filename expansion
#+				on expressions that globbing recongizes.
do
	ls -l "$file"	# Lists all files in $PWD (current directory).
	# Recal that the wild card character "*" matches every filename,
	#+	(shop -s nullglob).
	#  Thanks, S.C.
done

echo; echo

for file in [jx]*
do
	rm -f $file 	# Removes only files begining with "j" or "x" in $PWD.
	echo "Removed file \"$file\"".
done

echo

exit 0
Example 10-5. missing in [list] in a for loop
#!/bin/bash
#  Invoke this script both with and without arguments,
#+ and see what happens.

for a
do
	echo -n "$a "
done

#  The 'in list' missing, therefore the loop operates on '$@'
#+ (command-line argument list, including whitespace).

echo

exit 0

Example 10-6. Generating the [list] in a for loop with command substitution
#!/bin/bash
#  for-loopcmd.sh: for-loop with [list]
#+ generated by command substitution.

NUMBERS="9 7 3 8 37.53"
for number in `echo $NUMBERS`	# for number in 9 7 3 8 37.53
do
	echo -n "$number "
done

echo
exit 0

Example 10-7. A grep replacement for binary files
#!/bin/bash
# bin-grep.sh: Lpcates matching strings in a binary file.
# A "grep" replacement for binary files.
# Similar effect to "grep -a"

E_BADARGS=65
E_NOFILE=66

if [[ $# -ne 2 ]]; then
	echo "Usage: `baesename $0` search_string filename"
	exit $E_BADARGS
fi

if [[ ! -f "$2" ]]; then
	echo "File \"$2\" does not exists."
	exit $E_NOFILE
fi

IFS=$'\012'		# Per suggestion of Anton Filippov.
				# was: IFS="\n"
for word in $(string "$2" | grep "$1")
# The "strings" command lists strings in binary files.
# Output then piped to "grep", which tests for desired string.
do
	echo $word 
done

# As S.C points out, lines 23-30 could be replaced with the simpler
#    strings "$2" | grep "$1" | tr -s "$IFS" '[\n*]'

#  Try something like "./bin-grep.sh mem /bin/ls"
#+ to exercise this script.

exit 0

Example 10-8. Listing all users on the system
#!/bin/bash
# userlist.sh

PASSWORD_FILE=/etc/passwd
n=1		# User number

for name in $(awk 'BEGIN{FS=":"}{print $1}' <"$PASSWORD_FILE")
# Field separator = :	 ^^^^^^
# Print first field              ^^^^^^^^^
# Get input from password file                ^^^^^^^^^^^^^^^^
do
	echo "USER #$n = $name"
	let "n +=1"
done

# USER #1 = root
# USER #2 = bint
# USER #3 = daemon
# ...
# USER #30 = bozo

exit 0

#  Exercise:
#  ---------
#  How is it that an ordinary user (or a script run by same)
#+ can read /etc/passwd?
#  Isn't this a security hole? Why or why not?

Example 10-9. Checking all the binaries in a directory for authorship

#!/bin/bash
# findstring.sh:
# Find a particular string in the binaries in a specified directory.

directory=/usr/bin/
fstring="Free Software Foundation" # See which files come from the FSF.

for file in $( find $directory -type f -name '*' | sort )
do
	string -f $file | grep "$string" | sed -e "s%$directory%%"
	#  In the "sed" expression,
	#+ it is necessary to substitute for the normal "/" delimiter
	#+ because "/" happens to be one of the characters filtered out.
	#  Failure to do so gives an error message (try it).
done

exit 0

#  Exercise (easy):
#  -----------------
#  Convert this script to tabke command-line paramters
#+ For $directory and $fstring.

Example 10-10. Listing the symboloc links in a directory 
#!/bin/bash
#  symlinks.sh: Lists symboloc links in a directory.

directory=${1-`pwd`}
#  Defaults to current working directory,
#+ if not otherwise specified.
#  Equivalent to code block below.
# -------------------------------------------
# ARGS=1				# Expect one command-line argument.
#
# if [ $# -ne "$ARGS" ]	# If not 1 arg ...
# then
#     directory=`pwd`	# current working directory
# else
#     directory=$1
# fi
# --------------------------------------------

echo "symbolic links in directory \"$directory\""
for file in "$(find $directory -type l)"	# -type l = symboloc links
do
	echo "$file"

done | sort 								# Otherwise file list is unsorted.
#  Strictly speaking, a loop isn't really necessary here,
#+ since the output of the "find" command is expanded into a single word.
#  However, it's easy to understand and illustrative way.

#  As Dominik 'Aeneas' Schnitzer points out,
#+ failing to quote $(find $directory -type l)
#+ will choke on filenames with embedded whitespace.
#  Even this will only pick up the first field of each argument.

exit 0

# -------------------------------------------------------
# Jean Helou proposes the following alternative:

echo "symboloc links in directory \"$directory\""
# Backup of the current IFS. One can never be too cautious.
OLDIFS=$IFS
IFS=:

for file in $(find $directory -type l -printf "%p$IFS")
do 			#						  ^^^^^^^^^^^^^^^^^		
	echo "$file"
	done | sort 
done  

# And, James "Mike" Conley suggests modifying Helou's code thusly:

OLDIFS=$IFS
IFS='' # Null IFS means no word breaks
for file is $(find $ directory -type l)
do
	echo $file
done  | sort

#  This works in the "pathological" case of a directory name having
#+ an embedded colon.
#  "This also fixes the pathological case of the directory name having
#+ a colon (or space in earlier example) as well."

Example 10-11. Symbolic links in a directory, saved to a file
#!/bin/bash
#  symlinks.sh: Lists symboloc links in a directory.

OUTFILE=symlinks.list 						# save file

directory=${1-`pwd`}
#  Defaults to current workding directory,
#+ if not otherwise specified.

echo "symbolic links in directory \"$directory\"" > "$OUTFILE"
echo "-----------------------------------------" >> "$OUTFILE"

for file in "$(find $directory -type l)" 		# -type l = symbolic links
do
	echo "$file"
done | sort >> "$OUTFILE"						# stdout of loop
#				^^^^^^^^^						redirected to save file.

exit 0

Example 10-12. A C-style for loop
#!/bin/bash
# Two ways to count up to 10.

echo 
# Stand syntax.
for a in 1 2 3 4 5 6 7 8 9 10
do
	echo -n "$a "
done

echo; echo 

# +=============================================+

#  Now, let's do the same, using C-like syntax.

LIMIT=10
for ((a=1; a <= LIMIT ; a++))	# Double parentheses, and "LIMIT" with no "$".
do
	echo -n "$a "
done 							# A construct borrowed from "ksh93".

echo; echo 

# +=============================================+

# Let's use the C "comma operator" to increment two variables simultaneously.
for ((a=1, b=1; a<= LIMIT; a++, b++))	# The comma chains together operations.
do
	echo -n "$a-$b"
done

echo; echo

exit 0

Example 10-13. Using efax in batch mode
#!/bin/bash
#  Faxing (must have 'efax' package installed).

EXPECTED_ARGS=2
E_BADARGS=65
MODEM_PORT="/dev/ttyS2"			# May be different on your machine.
#				^^^^^^^			 PCMCIA modem card default port.
if [[ $# -ne $EXPECTED_ARGS ]]; then
	# Check for proper number of command line args.
	 echo "Usage: `basename $0` phone# test-file"
	 exit $E_BADARGS
fi

if [[ ! -f "$2" ]]; then
	echo "File $2 is not a text file."
	#	File is not a regular file, or does not exists.
	exit $E_BADARGS
fi

fax make $2					#  Create fax-formatted files from text files.

for file in ${ls $2.0*}		#  Concatenate the converted files.
							#  Uese wild card (filename "globing")
							#+ in Variable list.
do
	fi1="$fil $file"
done

efax -d "$MODEM_PORT" -t "$T$1 $fil"	# Finally, do the work.
# Tring adding -o1 if above line fails.

#  As S.C. points out, the for-loop can be eliminated with
#     efax -d /dev/ttyS2 -ol -t "T$1" $2.0*
#+ but it's not quite as instructive [grin].

exit $?			# Also, efax sends diagnostic messages to stdout.

###############################################################
###############################################################
Example 10-14. Simple while loop
#!/bin/bash

var0=0
LIMIT=10

while [ "$var0" -lt "$LIMIT" ]
#	   ^                  	^
# Spaces, because these are "test-brackets" ...
do
	echo -n "$var0 "		# -n suppresses newline.
	#			  ^			  Space, to separate printed out numbers.

	var0=`expr $var0 + 1`	# var0=$(($var0+1)) also works.
							# var0=$((var0 + 1)) also works.
							# let "var0 += 1" also works.
done						# Various other methods also work.

echo 

exit 0

Example 10-15. Another while loop
#!/bin/bash

echo
									# Equivalent to:
while [ "$var1" != "end" ]			# while test "$var1" != "end"
do
	echo "Input variable #1 (end to exit) "
	read var1 						# Not 'read $var1' (why?).
	echo "variable #1 = $var1"		# Need quotes because of "#"...
	# If input is 'end', echoes it here.
	# Does not test for termination condition until top of loop.
	echo 
done

exit 0

Example 10-17. C-style syntax in a while loop
#!/bin/bash
# wh-loopc.sh: Count to 10 in a "while loop".

LIMIT=10
a=1

while [ "$a" -le  $LIMIT ]
do
	echo -n "$a "
	let "a+=1"
done 			# No surprises, so far.

echo; echo

# +===========================================+

# Now, repeat with C-like syntax.

((a = 1))	# a=1
# Double parentheses permit space when setting a variable as in C.

while ((a<=LIMIT))			# Double parentheses, and no "$" preceding variables.
do
	echo -n "$a "
	((a +=1 )) # let "a+=1"
	# yes, indeed.
	# Double parentheses permit incrementing a variable with C-like synta.
done

echo 

# C programmers can feel right at home in Bash

exit 0

Example 10-18. until loop
#!/bin/bash
END_CONDITION=end
# Tests condiftion here, at top of loop.
do
	echo "Input variable #1 "
	echo "($END_CONDITION to exit)"
	read var1
	echo "Various #1 = $var1"
	echo 
done

exit 0

10.2. Nested Loops
Example 10-19. Nested Loops
#!/bin/bash
# nested-loop.sh: Nested "for" loops.
outer=1					# Set outer loop counter.

# Beginning of outer loop.
for a in 1 2 3 4 5
do
	echo "Pass $outer in outer loop."
	echo "-------------------------"
	inner=1					# Reset inner loop counter.

	# =======================================
	# Beginning of inner loop.
	for b in 1 2 3 4 5 
	do
		echo "Pass $inner in inner loop."
		let "inner+=1"		# Increment inner loop counter.
	done
	# End of inner loop.
	# ============================================
	let "outer+=1"	# Space between output blocks in pass of outer loop.
done
# End of outer loop.

exit 0

10.3. Loop Control
Example 10-20. Effects of break and continue in a loop
#!/bin/bash
LIMIT=19 	# Upper limit

echo
echo "Printing Number 1 through 20 (but not 3 and 11)."

a=0

while [ $a -le "$LIMIT" ]
do
	a=$(($a+1))

	if [[ "$a" -eq 3 ]] || [ "$a" -eq 11 ]; then
        # Exclides 3 and 11.
        continue 		# Skip rest of this particular loop iteration.
	fi

	echo -n "$a "		# This will not execute for 3 and 11.
done

# Exercise:
# Why does loop print up to 20?

echo; echo

echo Print Number 1 through 20, but something happens after 2.

################################################################

# Same loop, but substituting 'break' for 'continue'.

a=0

while [ "$a" -le "$LIMIT" ]
do
	a=$(($a+1))

	if [[ "$a" -gt 2 ]]; then
		break 	# Skip entire rest of loop. 
	fi
	echo -n "$a "
done
echo; echo; echo
exit 0

Example 10-21. Breaking out of multiple loop levels
#!/bin/bash
# break-levels.sh: Breaking out of loops.

# "break N" breaks out of N level loops.

for outerloop in 1 2 3 4 5
do
	echo -n "Group $outerloop: "
	# -----------------------------------
	for innerloop in 1 2 3 4 5
	do
		echo -n "$innerloop "
		if [[ "$innerloop" -eq 3 ]]; then
			break 		# Try break 2 to see what happens.
						# ("Breaks" out of both inner and outer loops.)
		fi
	done
	# -------------------------------------------------------

	echo
done

echo

exit 0

Example 10-22. Continuing at a higher loop level
#!/bin/bash
# The "continue N" command, continuing at the Nth level loop.

for outer in I II III IV V 		# outer loop
do
	echo; echo -n "Group $outer: "

	# --------------------------------------------------
	for inner in 1 2 3 4 5 6 7 8 9 10 # inner loop
	do
		if [[ "$inner" -eq 7 ]]; then
			continue 2 		# Continue at loop on 2dn level, that is "outer loop".
							# Replace above line with a simple "continue"
							# to see normal loop behavior.
		fi

		echo -n "$inner " 	# 7 8 9 10 will never echo.
	done
	# --------------------------------------------------
done

echo; echo

# Exercise:
# Come up with a meaningful use for "continue N" in a script.

exit 0

Example 10-23. Using continue N in an actual task
#!/bin/bash
#  Albert Reiner gives an example of how to use "continue N":
#  -----------------------------------------------------------

#  Suppose I have a large number of jobs that need to be run, with
#+ any data that is to be treated in files of a given name pattern in a
#+ directory. There are several machines that access this directory, and
#+ I wang to distribute the work over these different boxen. Then I 
#+ usually nohup someting like the following on every box:

while true
do
	for n in .iso.*
	do
		[ "$n" = ".iso.opts" ] && continue
		beta=${n#.iso.}
		[ -r .Iso.$beta ] && continue
		[ -r .lock.$beta ] && sleep 10 && continue
		lockfile -r0 .lock.$beta || continue
		echo -n "$beta: " `date`
		run-isotherm $beta
		date
		ls -alF .Iso.$beta
		[ -r .Iso.$beta ] && rm -rf .lock.$beta
		continue 2
	done
	break
done

#  The details, in particular the sleep N, are particular to my
#+ application, but the general pattern is:

while true
do
	for job in {pattern}
	do
		{job already done or running} && continue
		{mark job as running, do job, mark job as done}
		continue 2
	done
	break 		# Or something like 'sleep 600' to avoid termination.
done

#  This way the script will stop only when there are no more jobs to do
#+ (including jobs that were added during runtime). Through the use
#+ of appropriate lockfiles it can be run on serveral machines
#+ concurrently without duplication of calculations [which run a couple
#+ of hours in my case, so I really want to avoid this]. Also, as search
#+ always starts again from the beginning, one can encode priorities in
#+ the file names. of course, one could also do this without 'continue 2',
#+ but then on would have to actually check whether or not some job
#+ was done (so that we should immediately look for the next job) or not 
#+ (in which case we terminate or sleep for a long time before check
#+ for a new job).

10.4. Testing and Branching
Example 10-24. Using case
#!/bin/bash
# Testing ranges of characters.

echo; echo "Hit a key, then hit return."
read Keypress

case "$Keypress" in
	[[:lower:]] )	echo "Lowercase letter"
					;;
	[[:upper:]] )	echo "Uppercase letter"
					;;
	[0-9]		)	echo "Digit"
					;;
	*			)	echo "Punctuation, whitespace, or other"
					;;
esac 	#  Allows ranges of characters in [sguare brackets],
		#+ or POSIX ranges in [[double sqare brackets.

#  In the first version of this example,
#+ the tests for lowercase and uppercase characters were
#+ [a-z] and [A-Z].
#  This no longer works in certain locales and/or Linux distros.
#  POSIX is more portable.
#  Thanks ot Frank Wang for pointing this out.

#  Exercise:
#  ----------
#  As the script stands, it accepts a single keystroke, then terminates.
#  Change the script so it accepts repeated input,
#+ reports on each keystroke, and terminates only when "X" is hit.
#  Hint: enclose everything in a "while" loop.

exit 0
##################################################################
Example 10-25. Creating menus using "case" 
#!/bin/bash

# Crude address database

clear 	# Clear the screen.

echo "			Contact List"
echo "			-------------"
echo :"Choose one of the following persons:"
echo
echo "[E]vans, Roland"
echo "[J]ones, Mildred"
echo "[S]mith, Julie"
echo "[Z]ane, Morris"
echo

read person

case "$person" in
# Note variable is quoted.
	"E" | "e" )
	# Accept upper or lowercase input.
	echo 
	echo "Roland Evans"
	echo "4321 Floppy Dr."
	echo "Hardscrabble, CO 80753"
	echo "(303) 734-9874"
	echo "(303) 734-9892 fax"
	echo "revans@zzy.net"
	echo "Business partner & old friend"	
	;;

# Note double semicolon to terminate each option.
	"J" | "j" )
	echo
	echo "Mildred Jones"
	echo "249 E. 7th St., Apt. 19"
	echo "New York, NY 10009"
	echo "(212) 533-2814"
	echo "(212) 533-9972 fax"
	echo "Milliej@loisaida.com"
	echo "Ex-girlfriend"
	echo "Birthday: Feb. 11"
	;;

# Add info for Smith & Zane later.
	* )
	# Default option.
	# Empty input (hitting RETURN) fits here, too.
	echo 
	echo "Not yet in database."
	;;
esac

echo 

#  Exercise:
#  -----------
#  Change the script so it accepts multiple inputs,
#+ instead of terminating after displaying just one address.

exit 0
###################################################################



#!/bin/bash
E_PARAM=66
case "$1" in
	"" ) echo "Usage: ${0##*/} <filename>"; exit $E_PARAM;;
	# No command-line parameters,
	# or first parameter empty.
	# Note that ${0##*/} is ${var##pattern} param substitution.
	# Net result is $0.
	-*) FILENAME=./$1;;	
	#  If filename passed as argument （$1）
	#+ STARTS WITH A DASH,
	#+ replace it with ./$1
	#+ so further commands don't interpret it
	#+ as an option.
	
	* ）	FILENAME=$1;;	# Otherwise,$1.
esac




Here is an more straightforward example of command-line parameter handing:

#!/bin/bash

while [$# -gt 0]; do 		# Until you run nout parameters...
case "$1" in
	-d | --debug )
		# "-d" or "--debug" parameter?
		DEBUG=1
		;;
	-c|--conf)
		CONFFILE="$2"
		shift
		if [[ ! -f $CONFFILE ]]; then
			 echo "Error: Supplied file does't exists!"
			 exit $E_CONFFILE	# File not found error.
		fi
		;;
esac
shift 	# Check next set of parameters.
done


#  From Stefan Falsetto's "Log2Rot" script,
#+ part of his "rottlog" package.
#  Used with permission.

Example 10-26. Using command substitution to generate the case variable
#!/bin/bash
# case-cmd.sh: Using command substitution to generate a "case" variable.

case $( arch ) in 	# "arch" return machine architecture.
					# "Equivalent to 'uname -m"...
	i386 )	echo "80386-based machine"
		;;
	i486 )	echo "80486-based matches"
		;;
	i586 )	echo "Pentium-based machines"
		;;
	i686 )	echo "Pentium2+-based machines"
		;;
	* )		echo "Other type of machines"
		;;
esac

exit 0

##############################################################
Example 10-27. Simple string machines
#!/bin/bash
# match-string.sh: simple string matching

match_string ()
{
	MATCH=0
	NOMATCH=90
	PARAMS=2	# Function requires 2 arguments.
	BAD_PARAMS=91

	[ $# -eq $PARAMS ] || return $BAD_PARAMS

	case "$1" in
		"$2" )	return $MATCH 
			;;
		*  ) return $NOMATCH
			;;
	esac
}

a=one
b=two
c=three
d=two

match_string $a 		# wrong number of parameters
echo $?					# 91

match_string $a $b 		# no match
echo $?					# 90

match_string $b $a 		# match
echo $?					# 0

exit 0

Example 10-28. Checking for alphabetic input
#!/bin/bash
#  isalpha.sh: Using a "case" structure to filter a string.

SUCCESS=0
FAILURE=-1

isalpha () 	# Tests whther *first character* of input string is alphabetic.
{
	if [[ -z "$1" ]]; then # No argument passed?
		return $FAILURE
	fi

case "$1" in
	[a-zA-Z] ) return $SUCCESS;;	# Begins with a letter?
		;;
	* )	return $FAILURE
		;;
esac
}									# Compare this with "isalpha ()" function in C.

isalpha2 ()	# Tests whether *entire string* is alphabetic.
{
	[ $# -eq 1 ] || return $FAILURE

	case $1 in
		*[!a-zA-Z]*|"" )	return $FAILURE
			;;
		*              )	return $SUCCESS
			;;
	esac
}

isdigit ()	# Tests whether *entire string* is numberical.*
{			# In other words, tests for integer variable.
	[ $# -eq 1 ] || return $FAILURE;;
	case $1 in
		*[!0-9]*|"") return $FAILURE;;
		*          ) return $SUCCESS;;
	esac	
}

check_var ()	# Front-end to isalpha ().
{
	if isslpha "$@"; then
		echo "\"$*\" begins with an alpha character."
		if isalpha2 "$@"; then # No point in testing if first char is non-alpha.
			echo "\"$*\" contains only alpha characters."
		else
			echo "\"$*\" contains at least one non-alpha characher."
		fi
	else
		echo "\"$*\" begin with a non-alpha character."
								# Also "non-alpha" if no argument passed.
	fi
	echo 
}

digit_chech ()	# Front-end to isdigit ().
{
	if isdigit "$@"; then
		echo "\"$*\" contains only digits [0-9]."
	else
		echo "\"$*\" has at least one non-digit character."
	fi

	echo 
}

a=23skidool
b=H3llo
c=-What?
d=What?
e=`echo $b`		# Command substitution.
f=AbcDef 
g=27234
h=27a34
i=27.34

check_var $a 
check_var $b
check_var $c  
check_var $d 
check_var $e  
check_var $f  
check_var 		# No argument passed, so what happens?
#
digit_chech $g 
digit_chech $h 
digit_chech $i

exit 0 			# Script impreoved by S.C.

#  Exercise:
# ------------
#  Write an 'isfloat ()' function that tests for floating point numbers.
#  Hint: The function duplicates 'isdigit ()',
#+ but adds a test for a mandatory decimal point.

Example 10-29. Creating menus using select
#!/bin/bash

PS3='Choose your favorite vegatable:'	# Sets the prompt string.

echo

select vegetable in "beans" "carots" "potatoes" "onions" "rutabgas"
do
	echo
	echo "Your favorite veggie is v$vegetable."
	echo "Yuck!"
	echo
	break 	# What happens if there is no 'break here?'
done

exit 0

Example 10-30. Creating menus using select in function
#!/bin/bash
PS3='Choose your favorite vegetable: '

echo 

choice_of()
{
	select vegetable
	# [in list] omitted, so 'select' uses arguments passed to function.
	do
		echo "Your favorite vegetable is $vegetable."
		echo "Yuck!"
		echo
		break
	done
}

choice_of beans rice carrots radishes tomatoes spinach
#			$1	$2		$3		$4		$5		$6
#			passed to choice_of() function

exit 0

#!/bin/bash
rm `cat filename`	# "filename" contains a list of files to delete.
#
# S.C. points out that "arg list too long" error might result.
# Better is 		xargs rm -- < filename
# ( -- convers those cases where "filename" begins with a "-")

textfile_listing=`ls *.txt`
# Variable contains names of all *.txt files in current working directory.
echo $textfile_listing

textfile_listing2=$(ls *.txt)	# The alterinative form of command substitution.
echo $textfile_listing2
# Same result.

# A possible problem with putting a list of files into a single string
# is that a newline may creep in.
#
# A safer way to assign a list of files to a parmeter is with an array.
#		shopt -s nullglob 	# If no match, filename expands to nothing.
#		textfile_listing=( *.txt )
#
# Thanks, S.C.

dir_listing=`ls -l`
echo $dir_listing	# unquoted

# Expecting a nincely ordered directory lsiting.

# However, what you get is:
# total 3 -rw-rw-r-- 1 bozo bozo 30 May 13 17:15 1.txt -rw-rw-r-- 1 bozo
# bozo 51 May 15 20:57 t2.sh -rwxr-xr-x 1 bozo bozo 217 Mar 5 21:13 wi.sh

# The newlines disappeared.

echo "$dir_listing"	#	quoted
# -rw-rw-r--    1 bozo       30 May 13 17:15 1.txt
# -rw-rw-r--    1 bozo       51 May 15 20:57 t2.sh
# -rwxr-xr-x    1 bozo      217 Mar  5 21:13 wi.sh

##############################################################
#!/bin/bash
variable1=`<file1`		#  Set "variable1" to contetns of "file1".
variable2=`cat file2`	#  Set "variable2" to contents of "file2".
						#  This, however, forks a new process,
						#+ so the line of code executes slower than the above version
#  Note:
#  The variables may contain embedded whitespace,
#+ or even (horrors), control characters.
#  Excerpts from system file, /etc/rc.d/rc.sysinit
#+ (on a Red Hat Linux installation
if [[ -f /fsckoptions ]]; then
	fsckoptions=`cat /fsckoptions`
...
fi
#
#
if [[ -e "/proc/ide/${disk[$device]}/media" ]]; then
	hdmedia=`cat /proc/ide/${disk[$disk[$device]]}`
...
fi
#
#
if [[ ! -n "`uname -r | grep -- "-"`" ]]; then
	ktag="`cat /proc/version`"
...
fi
#
#
if [[ $usb = "1" ]]; then
	sleep 5
	mouseoutput=`cat /proc/bus/usb/devices 2>/dev/null | grep -E "^I.*Cls=03.*Prot=02"`
	kbdoutput=`cat /proc/bus/usb/devices 2>/dev/null | grep -E "^I.*Cls=03.*Prot=01"`
...
fi

Example 11-2. Generating a variable from a loop
#!/bin/bash
# csubloop.sh: Setting a variable to the output of a loop.
variable1=`for i in 1 2 3 4 5
do
	echo -n "$i "	#  The 'echo' command is critical	
done`				#+ to command substitution here.	

i=0
variable2=`while [ "$i" -lt 10 ]
do
	echo -n "$i "		# Again, the necessary 'echo'.
	let "i +=1"			# Increment.
done`

echo "variable2 = $variable2"	# variable2 = 0123456789

#  Demonstrates that it's possible to embed a loop
#+ within a variable declaration.

exit 0

Example 11-3. Finding anagrams
#!/bin/bash
#  agram2.sh
#  Example of nested command substutution.

#  Uses "anagram" utility
#+ that is part of the author's "yaw1" word list package.
#  http://ibiblio.org/pub/Linux/libs/yawl-0.3.2.tar.gz
#  http：//personal.riverusers.com/~thegrendel/yawl-0.3.2.tar.gz

E_NOARGS=66
E_BADARGS=67
MINLEN=7

if [[ -z "$1" ]]; then
	echo "Usage: $0 LETTERSET"
	exit $E_NOARGS 		# Script needs a command-line argument.
elif [[ ${#1} -lt $MINLEN ]]; then
	echo "Argument must have at least $MINLEN letters."
	exit $E_BADARGS
fi

FILTER='......'		# Must have at least 7 letters.
#	1234567
Anagrams=($(echo $(anagram $1 | grep $FILTER)))
#		  $(	 $(   nested command sub.   ))
#		 (				array assignment      )
echo
echo "${#Anagrams[*]}	7+ letter anagrams found"
echo
echo ${Anagrams[*]}		# First anagram.
echo ${Anagrams[1]}		# Second anagram.
						# Etc.

#  echo "${Anagrams[*]}"	# To list all the anagrams in a single line...

#  Look ahead to the "Arrays" chapter for enlightenment on
#+ what's going on here.
#  See also the agram.sh script for an example of anagram finding.

exit $?

Example 14-1. A script that forks off multiple instances of itself
#!/bin/bash
# spawn.sh

PIDS=$(pidof sh $0)		# Process IDs of the various instances of this script.
P_array=( $PIDS )		# Put them in an array (why?).
echo $PIDS 				# Show process IDs of parent and child processes.
let "instances = ${#P_array[*]} - 1"	# Count elements, less 1.
										# Why subtract 1?
echo "$instances instance(s) of this script running."
echo "[Hit Ctl-C to exit.]"; echo 

sleep 1			# Wait.
sh $0			# Play it again, Sam.

exit 0 			# Not necessary; script will never get to here.
				# Why not?

#  After exiting with a Ctl-C,
#+ do all the spawned instances of the script die?
#  If so, why?

#  Note:
#  -----
#  Be careful not to run this script too long.
#  It will eventully eat up too many system resources.

#  Is having a script spawn multiple instances of itself
#+ an advisable scripting thecnique.
#  Why or why not?

Example 14-3. Variable assignment, using read
#!/bin/bash
#  "Reading" variables.

echo -n "Enter the value of variable 'var1': "
# The -n option to echo suppresses newline.

read var1
# Note no '$' in front of var1, since it is being set.

echo "var1 = $var1"

echo 

#  A single 'read' statement can set multiple variables.
echo -n "Enter the values of variables 'var2' and 'var3'"
echo -n "(separated by a space or tab): "
read var2 var3
echo "var2 = $var2 var3 = $var3"
#  If you input only one value,
#+ the other variable(s) will remain unset (null).

exit 0

Example 14-4. What happens when read has no variable
#!/bin/bash
# read-novar.sh

echo 

# ----------------------- #
echo -n "Enter a value: "
read var 
echo "\"var\" = "$var""
# Everything as expected here.
# ----------------------- #

echo

# ---------------------------------------------- #
echo -n "Enter another value: "
read 			#  No variable supplied for 'read', therefore...
				#+ Input to 'read' assigned to default variable, $REPLY.
var="$REPLY"
echo "\"var\" = "$var""
# This is equivalent to the first code block.
# ---------------------------------------------- #

echo
echo "==================================================="
echo 


#  This example is similar to the "replay.sh" script.
#  However, this one shows that $REPLAY is available
#+ even after a 'read' to a variable in the conventional way.

echo "==================================================="

# In some instance, you might wish to discard the first value read.
# In such cases, simple ignore the $REPLY variable.

{ # Code block.
read 		# Line 1, to be discarded.
read line2 	# Line 2, saved in variable.
} < $0
echo "Line 2 of this script is:"
echo "$Line2"	# 	# read-novar.sh
echo 			#	#!/bin/bash line discarded.

# See also the soundcard-on.sh script.

exit 0

Example 14-5. Multi-line input to read
#!/bin/bash

echo 

echo "Enter a string terminated by a \\, then press <ENTER>."
echo "Then, enter a second string (no \\ this time), and again press <ENTER>."

read var1 		#  The "\" suppresses the newline, when reading $var1
				#  		first line \
				# 		second line

echo "var1 = $var1"
#	  var1 = first line second line

#  For each line terminated by a "\"
#+ you get a prompt on the next line to continue feeding characters into var1.

echo; echo

echo "Enter another string terminated by a \\, then press <ENTER>."
read -r var2 	# The -r option causes the "\" to be read literally.
				#	first line \
echo "var2 = $var2"
#	  var2 = first line \

# Data entry terminates with the first <ENTER>.
echo

exit 0

Example 14-6. Detecting the arrow keys
#!/bin/bash
# arrow-detech.sh: Detects the arrow keys, and a few more.
# Thank you, Sandro Magi, for showing me how.

# ---------------------------------------
# Character codes generated by the keypresses.
arrowup='\[A'
arrowdown='\[B'
arrowrt='\[C'
arrowleft='\D'
insert='\[2'
delete='\[3'
# ---------------------------------------

SUCCESS=0
OTHER=65

echo -n "Press a key..."
# May need to also press ENTER if a key not listed above pressed.
read -n3 key 				# read 3 characters.

echo -n "$key" | grep "$arrowup"	# Check if character code detected.
if [[ "$?" -eq $SUCCESS ]]; then
	echo "Up-arrow key pressed."
	exit $SUCCESS
fi

echo -n "$key" | grep "$arrowdown"
if [[ "$?" -eq $SUCCESS ]]; then
	echo "Down-arrow key pressed."
	exit $SUCCESS
fi

echo -n "$key" | grep "$arrowrt"
if [[ "$?" -eq $SUCCESS ]]; then
	echo "Right-arrow key pressed."
	exit $SUCCESS
fi

echo -n "$key" | grep "$arrowleft"
if [[ "$?" -eq $SUCCESS ]]; then
	echo "Left-arrow key pressed."
	exit $SUCCESS
fi

echo -n "$key" | grep "$insert"
if [[ "$?" -eq $SUCCESS ]]; then
	echo "\"Insert\" key pressed."
	exit $SUCCESS
fi

echo "$key" | grep "delete"
if [[ "$?" -eq $SUCCESS ]]; then
	echo "\"Delete\" key pressed."
	exit $SUCCESS
fi

echo " Some other key pressed."

exit $OTHER

# ========================================= #

#  Mark Apexander came up with a simplified
#+ version of the above script (Thank you!).
#  It eliminates the need for grep.


#!/bin/bash
	uparrow=$'\x1b[A'
	downarrow=$'\x1b[B'
	leftarrow=$'\x1b[D'
	rightarrow=$'\x1b[C'

	read -s -n3 -p "Hit an arrow key: " x

	case "$x" in
		$uparrow )
			echo "You pressed Up-arrow"
			;;
		$downarrow )
			echo "You pressed Down-arrow"
			;;
		$leftarrow )
			echo "You pressed Leftarrow"
			;;
		$rightarrow )
			echo "You pressed Right-arrow"
			;;
	esac

# ================================================== #

# Exercise:
# -------------------
# 1）Add detection of the "Home," "End,", "Pgup," and "PgDn" keys.

Example 14-7. Using read with file redirection

#!/bin/bash

read var1 <data-file
echo "var1 = $var1"
# var1 set to the entire first line of the input file "data-file"

read var2 var3 <data-file
echo "var2 = $var2  var3 = $var3"
# Note non-intuitive behavior of "read" here.
# 1) Rewinds back to the beginning of input file.
# 2) Each variable is now set to a corresponding sting,
#    separated by whitespace, rather than to an entire line of text.
# 3) The final variable gets the reainder of the line.
# 4) If there are more variables to be set than whitespace-terminated stings
#    on the first line of the file, then the excess variables remain empty.

echo "--------------------------------------------------"
# How to resolve the above problem with a loop:
while read line
do
	echo "$line"
done < data-file
# Thanks, Heiner Steven for poingting this out.

echo "--------------------------------------------------"

# Use $IFS (Internal Field Separator variable) to split a line of input to 
# "read", if you do not want the default to be whitespace.

echo "List of all users:"
OIFS=$IFS; IFS=: 	# /etc/passwd uses: ":" for field separator.
while read name passwd uid git fullname ignore
do
	echo "$name ($fullname)"
done </etc/passwd 	# I/O redirection.
IFS=$OIFS 				# Restore original $IFS.
# This code snippet also by Heiner Steven.


#  Setting the $IFS variable within the loop itsel
#+ eliminates the need for storing the original $IFS
#+ in a temporary variable.
#  Thanks, Dim Segebart, for poingting this out.
echo "-----------------------------------------------------"
echo "List of all users:"

while IFS: read name passwd uid gid fullname ignore
do
	echo "$name ($fullname)"
done < /etc/passwd 	# I/O redirection.

echo 
echo "\$IFS still $IFS"

exit 0

Example 14-9. Changing the current workding directory
#!/bin/bash

dir1=/usr/local
dir2=/var/spool

pushd $dir1
# Will do an automatic 'dirs' (list directory stack to stdout).
echo "Now in directory `pwd`."	# Uses back-quoted 'pwd'.

# Now, do some stuff in directory 'dir1'.
pushd $dir2
echo "Now in directory `pwd`."

# Now, do some stuff in directory 'dir2'.
echo "The top entry in the DIRSTACK array is $DIRSTACK."
popd
echo "Now back in directory `pwd`."

# Now, do some more stuff in directory 'dir1'.
popd
echo "Now back in original workding directory `pwd`."

exit 0

# What happens if you don't 'popd' -- then exit the script?
# Which directory do you end up in? Why?

Example 14-10. Letting let do arithmetic.

#!/bin/bash

echo 

let a=11				# Same as 'a=11'
let a=a+5				# Equivalent to let "a = a + 5"
						# (Double quotes and spaces make it more readable.)
echo "11 + 5 = $a"		# 16

let "a <<=3"			# Equivalent to let "a = a <<3"
echo "\"\$a\" (=16)		left-shifted 3 places =$a"

let "a /= 4"			# Equivalent to let "a = a / 4"
echo "128 / 4 = $a"		# 32

let "a -= 5"			# Equivalent to let "a = a -5"
echo "32 - 5 =$a"		# 27

let "a *= 10"			# Equivalent to let "a = a * 10"
echo "27 8 10 =$a"		# 270

let "a %= 8"			# Equivalent to let "a = a % 8"
echo "270 modulo 8 $a (270 / 8 = 33, remainder $a)"
						# 6
echo

exit 0

Example 14-11. Showing the effect of eval
#!/bin/bash
y=`eval ls -l`		#  Similar to y=`ls -l`
echo $y 			#+ but linefeeds removed because "echoed" variable is unquoted.
echo
echo "$y"			#  Linefeeds preserved when variable is quoted.

echo; echo 

y=`eval df`			#  Similar to y=`df`
echo $y 			#+ but linefeeds removed.

#  When LF's not preserved, it may make it easier to parse output.
#+ using utilities such as "awk".

echo 
echo "======================================================="
echo

# Now, showing how to "expand" a variable using "eval" ...

for i in 1 2 3 4 5
do
	eval value=$i
	#  value=$i has same effect. The "eval" is not necessary here.
	#  A variable lacking a meta-meaning evaluates to itseif --
	#+ it can't expand to anything other than its literal self.
	echo $value
done

echo 
echo "---"
echo 

for i in ls df
do
	value=eval $i
	#  value=$i has an entirely different effect here.
	#  The "eval" evaluates the commands "ls" and "df"...
	#  The terms "ls" and "df" have a meta-meaning,
	#+ since they are interpreted as commands,
	#+ rather than just character strings.
	echo $value
done

exit 0

Example 14-12. Echoing the Command-line parameters
#!/bin/bash
# echo-params.sh

# Call this script with a few command line parameters.
# For example:
#		sh echo-parameters.sh first second third fourth fifth

params=$#			# Number of command-line parameters.
param=1 			# Start at first command-line param.

while [ "$param" -le "$params" ]
do
	echo -n "Command line parameter "
	echo -n \$$param 		#  Gives only the *name* of variable.
#			^^^				#  #1, $2, $3, etc.
							#  Why?
							#  \$ escapes the first "$"
							#+ so it echoes literally,
							#+ and $param dereferences "$param" ...
							#+ ... as expected.
	echo -n " = "
	eval echo \$$param 		#  Gives the *value* of variable.
#   ^^^^       ^^^ 			#  The "eval" forces the *evaluation*
							#+ of \$$
							#+ as an indirect variable reference.

(( param ++ ))				# on to the next.
done

exit $?

# =========================================

$ sh echo-params.sh first second third fourth fifth
Command line parameter $1 = first
Command line parameter $2 = second
Command line parameter $3 = third
Command line parameter $4 = fourth
Command line parameter $5 = fifth

Example 14-13. Forcing a log-off

#!/bin/bash
# Killing ppp to force a log-off.
#  Scrit should be run as root user.
killppp="eval kill -9 `ps ax | awk '/ppp/ { print $1 }'`"
#						------- process ID of ppp --------
$killppp 				#  This variable is now a command.

# The following operations must be done as root user.

chmod 666 /dev/ttyS3	# Restore read+write permissions, or else what?
#  Since doing a SIGKILL on ppp changed the permissions on the serial port,
#+ we restore permissions to previous state.

rm /var/lock/LCK..ttyS3	# Remove the serial port lock file. Why?

#  Note:
#  Depending on the hardware and even the kernel version,
#+ the modem port on your machine may be different --
#+ /dev/ttyS1 or /dev/ttyS2.

exit 0

#  Exercises:
#  ---------
# 1）Have script check whether root user is invoking it.
# 2) Do a check on whether the process to be killed
#+   is actually running before attempting to kill it.
# 3）Write an alternate version of this script based on 'fuser':
#+         if [ fuser -s /dev/modem ]; then ...

Exampel 14-14. A version of rot13
#!/bin/bash
# A version of "rot13" using 'eval'.
# Compare to 'rot13.sh' example.

setvar_rot_13()					# "rot13" scrambling
{
	local varname=$1 varvalue=$2
	eval $varname='$(echo $varvalue) | tr a-z n-za-m'
}

setvar_rot_13 var "foobar"		# Run "foobar" through rot13.
echo $var 						# sbbone

setvar_rot_13 var "$var"		# Run "sbbone" through rot13.
								# Back to original variable.
								# foobar

# This example by Setphane Chazelas.
# Modified by document author.

exit 0

Example 14-16. Using set with positional parameters 
#!/bin/bash

# script "set-test"

# Invoke this script with three command line parameters,
# for example, "./set-test one two thres".

echo 
echo "Positional parameters before set \`uname -a\` :"
echo "Command-line argument #1 = $1"
echo "Command-line argument #2 = $2"
echo "Command-line argument #3 = $3"

set `uname -a`	# Sets the positional parameters to the output
				# of the command `uname -a`

echo $_ 		# unknown
# Flags set in script.

echo "Positional parameters after set \`uname -a\` :"
# $1, $2, $3, ect. reinitialized to result of `uname -a`
echo "Field #1 of 'uname -a' = $1"
echo "Field #2 of 'uname -a' = $2"
echo "Field #3 of 'uname -a' = $3"
echo -----
echo $_ 			#  -----
echo 

exit 0

Example 14-17. Reversing the positional parameters
#!/bin/bash
# revposparams.sh: Reverse positional paramerers.
# Script by Dan Jacobson, with stylistic revisions by document author.

set a\ b c d\ e;
#    ^      ^    Spaces escaped
#      ^ ^ 		 Spaces not escaped
OIFS=$IFS; IFS=:;
#              ^ Saving old IFS and setting new one.

echo 

until [ $# -eq 0 ]
do 						# Step through positional parameters.
	echo "### k0 = "$k""	# Before
	k=$1:$k; 				# Append each pos param to loop variable.
#       ^
	echo "### k = "$k""		# After
	echo
	shift;
done

set $k 		# Set new positional parameters.
echo -
echo $#		# Count of positional parameters.
do
	echo $i 	# Display new positional parameters.
done

IFS=$OIFS 		# Restore IFS.

#  Question:
#  Is it necessary to set an new IFS, internale field separator,
#+ in order for this script to work properly?
#  What happens if you don't? Try it.
#  And, why use the new IFS -- a colon -- in line 17,
#+ to append to the loop variables?
#  What is the purpose of this?

exit 0

Example 14-18. Reassigning the positional parameters
#!/bin/bash
variable ="one two three four five"
set -- $variable
# Sets positional parameters to the contents of "$variable".

first_param=$1
second_param=$2
shift; shift 		# Shift past first two positional params.
# shift 2 			# also works.
remaining_params="$*"

echo 
echo "first parameter = $first_param"				# one
echo "second_parameter = $second_param"				# two
echo "remainting paramerers = $remaining_params"	# three four five

echo; echo

# Again.
set -- $variable
first param=$1
second_param=$2
echo "first parameter = $first_param"		# one
echo "second parameter = $second_param"		# two

# ===============================================

set --
# Unsets positional parameters if no variable sepecified.

first_param=$1
second_param=$2
echo "first parameter = $first_param"		# (null value)
echo "second paramerer = $second_param"		# (null value)

exit 0

Example 14-19. "Unsetting" a variable
#!/bin/bash
# unset.sh: Unsetting a variable.

variable=hello 							# Initialized.
echo "variable = $variable"
unset variable 							# Unset.
										# Same effect as: variable=
echo "(unset) variable = $variable"		# $variable is null.
if [[ -z "$variable" ]]; then 			# Try a string-lenght test.
	echo "\$variable has zero lenght."	
fi

exit 0

Example 14-20. Using export to pass a variable to an embedded awk script
#!/bin/bash

#  Yet another version of the "column totaler" script (col-totaler.sh)
#+ that adds up a specified column(of numbers) in the target file.
#  This uses the environment to pass a script variable to 'awk'...
#+ and places the awk script in a variable.

ARGS=2
E_WRONGARGS=65

if [[ $# -ne "ARGS" ]]; then 		# Check for proper no. of command line args.
	echo "Usage: `basename $0` filename column_number"
	exit $E_WRONGARGS
fi

filename=$1
column_number=$2

# ================ Same as original script, up to this point ============== #

export column_number
# Export column number to environment, so it's available for retrieval.

# -----------------------------------------
awkscript='{ total += $ENVIRON["column-number"]}
END {print total}'

# Yes, a variable can hold an awk script.
# -----------------------------------------

# Now, run the awk script.
awk "$awkscript" "$filename"

# Thanks, Stephane Chazelas.

exit 0

######################################################################
#!/bin/bash
while getopts ":abcde:fg" Option 
# Initial declaration.
# a, b, c, d, e, f, and g are the options (flags) expected.
# The : after option 'e' shows it will have an argument passed with it.
do
	case $Option in
		a )	# Do something with variable 'a'.
		b )	# Do something with variable 'b'.
		...
		e )	# Do something with 'e', and also with $OPTARG,
			# which is the associated argument passed with option 'e'.
		...
		g )	# Do something with variable 'g'.
	esac
done
shift $(($OPTIND - 1))
# Move argument pointer to next.

# All this is not nearly as complicated as it looks <grin>.

Example 14-21. Using getopts to read the options/arguments passed to a script
#!/bin/bash
# Exercising getopts and OPTIND
# Script modified 10/09/03 at the suggestion of Bill Gradwoh1.

#  Here we observe how 'getopts' processes command line arguments to script.
#  The arguments are parsed as "options" (flags) and assocoated arguments.

#  Try invoking this script with
#  'scriptname -mn'
#  'scriptname -oq qOption'	(qOption can be some arbitrary string.)
#  'scriptname -qxxx -r'
#
#  'Scriptname -qr'  		- Unexpected result, takes "r" as the argument to option "q"
#  'Scriptname -q -r'       - Unexpected result, same as above
#  'scriptname -mnop -mnop'	- Unexpected result
#  (OPTIND is unreliable at stating where an option came from).
#
#  If an option expects an argument ("flag:"), then it will grab
#+ whatever is next on the command line.

E_NO_ARGS=0
E_OPTERROR=65

if [[ $# -eq "$NO_ARGS" ]]; then 		# Script invoked with no command-line args? 
	echo "Usage: `basename $0` options (-mnopqrs)"
	exit $E_OPTERROR					# Exit and explain usage, if no argument(s) given.
fi

# Usage: scriptname -options
# Note: dash (-) necessary

while getopts ":mnopq:rs" Option; do
	case $Option in
		m   ) echo "Scenario #1: option -m- [OPTIND=${OPTIND}]";;
		n|o ) echo "Scebario #2: option -$Option- [OPTIND=${OPTIND}]" ;;
		p   ) echo "Scebario #3: option -p- [OPTIND=${OPTIND}]";;
		q   ) echo "Scebario #4: option -q-\
		whit argument \"$OPTARG\" [OPTIND=${OPTIND}]";;
		#  Note that option 'q' must have an associated argument,
		#+ otherwise it falls through to the default.
		r|s ) echo "Scenario #5: option -$Option-";;
		*  ) echo "Unimplemented option chosen.";; 		# DEFAULT  
	esac
done

shift $(($optind - 1))
#  Decrements the argument pointer so it to next argument.
#  $1 now referneces the first non option item supplied on the command line
#+ if one exists.

exit 0

#  As Bill Gradwohl states,
#  "The getopts mechanism allows one to specify: scriptname -mnop -mnop
#+  but there is no reliable way to differentiate what came from where
#+  by using OPTIND."

Example 14-22. "Including" a data file 
#!/bin/bash
./ data-file 	# Load a data file.
#  Same effect as "Source data-file", but more portable.

#  The file "data-file" must be present in current workding directory,
#+ since it is referred to by its 'basename'.

#  Now, reference some data from that file.

echo "variable1 (from data-file) = $variable1"
echo "variable3 (from data-file) = $variable3"

let "sum = $variable2 + $variable4"
echo "Sum of variable2 + variable4 (from data-file = $sum)"
echo "message1 (from data-file) is \"$message1\""
#  Note:							escaped quotes

print_message This is the message-print function in the data-file.

exit 0

File data-file for Example 14-22, above. Must be present in same directory.
# This is a data file loaded by a script.
# Files of this type may contain variables, functions, etc.
# It may be loaded with a 'source' or '.' command by a shell script.

# Let's iniyialize some variables.

variable1=22
variable2=473
variable3=5
variable4=97

message1="Hello, how are you?"
message2="Enough for now. Goodbye."

print_message()
{
	# Echoes any message passed to it.
	if [[ -z "$1" ]]; then
		return 1
		# Error, if argument missing.
	fi

	echo

	until [[ -z "$1" ]]; do
		# Step through argument passed to function.
		echo -n "$1"
		# Echo args one at a time, suppressing line feeds.
		echo -n " "
		# Insert space between words.
		shift
		# Next one.
	done

	echo 

	return 0
}

Example 14-23. A (useless) scripts that source itself
#!/bin/bash
# self-source.sh: a script sourcing itself "recursively."
# From "Stupid Script Tricks, " Volume II.

MAXPASSCNT=100	# Maximum number of execution passes.

echo -n "$pass_count "
#  At first execution pass, this just echoes two blank spaces,
#+ since $pass_count still uninitialized.

let "pass_count +=1"
#  Assumes the uninitialized variable $pass_count
#+ can be incremented the first time around.
#  This works with Bash and pdksh, but
#+ it relies on non-portable (and possibly dangerous) behavior.
#  Better would be to initialize $pass_count to 0 before incrementing.

while [[ "$pass_count"  -le $MAXPASSCNT ]]; do
	. $0 	# Script "sources" itself, rather than calling itself.
			# ./$0 （which would be true recursion） doesn't work here. Why?
done

#  What occurs here is not actually recursion,
#+ since the script effectively "expands" itself, i.e.,
#+ generates a new section of code
#+ with each pass through the 'while' 'loop',
#  with each 'source' in line 20.
#
#  Of cource, the script interprets each newly 'sourced' "#!" line
#+ as a comment, and not as the start of a new script.

echo 

exit 0	# The net effect is counting from 1 to 100.
		# Very impressive.
# Exercise:
# -----------
# Write a script that users this trick to actually do something useful.

Example 14-24. Effects of exec
#!/bin/bash

exec echo "Exiting \"$0\"."		# Exit from script here.

# ------------------------------
# The following will never echo.

echo "This echo will never echo."
exit 99			#  This script will not exit here.
				#  Check exit value after script terminates
				#+ with an 'echo $?'
				#  It will *not* be 99

Example 14-25. A script that exec's itself

#!/bin/bash
# self-exec.sh 

echo 

echo "This line appears ONCE in the script, yet it keeps echoing."
echo "The PID of this instance of the script is still $$."
#    Demonstrates that a subshell is not forked off.

echo "============== Hit Ctl-C to exit ===================="

sleep 1

exec $0		#  Spawns anothers instance of this name script 
			#+ that replaces the previous one.

echo "This line will never echo!"	# Why not?

exit 99			# Will not exit here!
				# Exit code will not be 99!

Example 14-26. Waiting for a process to finish before processding
#!/bin/bash
ROOT_UID=0	# Only users with $UID 0 have root privileges.
E_NOTROOT=56
E_NOPARAMS=66

if [[ "$UID" -ne "$ROOT_UID" ]]; then
	echo "Usage: `basename $0` find-string"
	exit $E_NOPARAMS
fi

echo "Updating 'locate' database..."
echo "This may take a while."
updatedb /usr &		# Must be run as root.

wait
# Don't run the rest of the script until 'updatedb' finished.
# You want the database updated before up the file name.

locate $1

#  Without the 'wait' command, in the worse case scenario,
#+ the script would exit while 'updatedb' was still running,
#+ leaving it as an orphan process.

exit 0

Example 14-27. A script that kills itself
#!/bin/bash
#  self-destruct.sh

kill $$	# Script kills its own process here.
		# Recall that "$$" is the script's PID.

echo "This line will not echo."
# Instead, the shell sends a "Terminated" message to stdout.

exit 0	# Normal exit? No!

#  After this script terminates prematurely,
#+ what exit status does it return?
#
#  sh self-destruct.sh
#  echo $?
#  143
#
#  143 = 128 + 15
#  				TERM signal

Example 15-1. Using ls to create a table of contents for burning a CDR disk
#!/bin/bash
# ex40.sh (burn-cd.sh)
# Script to automate burning a CDR.

SPEED=2						# May use higer speed if your hardware supports it.
IMAGEFILE=cdimage.iso
CONTENSFILE=contents
DEVICE=cdrom
# DEVICE="0.0"		For older versions of cdrecord
DEFAULTDIR=/opt 			# This is the versions of cdrecord
							# Make sure it exists.
							# Exercise: Add a test for this.

#  Uses Joerg Schilling's "cdrecord" package:
#  http://www.fokus.fhg.de/usr/schilling/cdrecord.html

#  If this script invoked as an ordinary user, may need suid cdrecord
#+ chmod u+s /usr/bin/cdrecord, as root.
#  Of course, this creates a security hole, though a relative minor one.
if [[ -z "$1" ]]; then
	IMAGE_DIRECTORY=$DEFAULTDIR
	# default directory, if not specified on command line.
else
	IMAGE_DIRECTORY=$1
fi

# Create a "table of contents" file.
ls -lRF $IMAGE_DIRECTORY >$IMAGE_DIRECTORY/$CONTENSFILE
# The "l" option gives a "long" file listing.
# The "R" option makes the listing recursive.
# The "F" option marks the file types (directorys get a trailing /).
echo "Creating table of contents."

# Create an image file preparatory to burning it onto the CDR.
mkisofs -r -o $IMAGEFILE $IMAGE_DIRECTORY
echo "Creating ISO9660 file system image ($IMAGEFILE)."

# Burn the CDR.
echo "Burning the disk."
echo "Please be patient, this will take a while."
cdrecord -v -isosize speed=$SPEED dev=$DEVICE $IMAGEFILE

exit $?

Example 15-2. Hello or Good-bye
#!/bin/bash
#  hello.sh: Saying "hello" or "goodbye"
#+ 					depending on how script is invoked.

#  Make a link in current working directory ($PWD) to this script:
#		ln -s hello.sh goodbye
# Now, try invoking this script both ways:
# ./hello.sh
# ./goodbye

HELLO_CALL=65
Goodbye_CALL=66

if [[ $0 = "./goodbye" ]]; then
	echo "Good-bye"
	# Some other goodbye-type commands, as appropriate.
	exit $GOODBYE_CALL 
fi

echo "Hello!"
# Some other hello-type commands, as appropriate.
exit $HELLO_CALL

find /home/bozo/projects -mtime 1
#  Lists all files in /home/bozo/projects directory tree
#+ that were modified within the last day.
#
# mtime = last modification time of the target file
# ctime = last status change time (via 'chmod' or otherwise)
# atime = last access time

DIR=/home/bozo/junk_files
find "$DIR" -type f -atime +5 -exec ls {} \;
#
#  Curly brackets are placeholder for the path name output by "find."
#
#  Deletes all files in "/home/bozo/junk_files"
#+ that have not been accessed in at lease 5 days.
#
#  "-type filetype", where
#  f = regular file
#  d = directory
#  l = symblic link, etc.
#  (The 'find' manpage and info page hvae complete listings.)

find /etc -exec grep '[0-9][0-9]*[.][0-9][0-9]*[.][0-9][0-9]*[.][0-9][0-9]*' {} \;

# Finds all IP addresses (xxx.xxx.xxx.xxx) in /etc/ directory files.
# There a few extraneous hits. Can they be filtered out?

# Possible by:


find /etc -type f -exec cat '{}' \; | tr -c '.[:digit:]' '\n' \
| grep '^[^.][^.]*\.[^.][^.]*\.[^.][^.]*\.[^.][^.]*$'
#
#  [:digit:] is one of the character classes
#+ introduced with the posix 1003.2 standard.

#  Thanks, Stephane Chazelas.

Example 15-3. Badname, eliminate file names in current directory containing bad characters and whitespace
#!/bin/bash
# badname.sh
# Delete filenames in current directory containing bad characters.
for filename in *
do
	  badname=`echo "$filename" | sed -n /[\+\{\;\"\\\=\?~\(\)\<\>\&\*\|\$]/p`
# badname=`echo "$filename" | sed -n '/[+{;"\=?~()<>&*|$]/p'`  also works.
# Deletes files containing these nasties:     + { ; " \ = ? ~ ( ) < > & * | $
#
  rm $badname 2>/dev/null 
#			  ^^^^^^^^^^^^ Error messages deep-sixed.
done

# Now, take care of files containing all manner of whitespace.
find . -name "* *" -exec rm -r {} \;
# The path name of the file that _find finds replaces th "{}".
# The '\' ensures that the ';' is interpreted literally, as end of command.

exit 0

# -----------------------------------------------
# commands below this line will not execute because of _exit_ command.

# An alternative to the above script；
find . -name '*[+{;"\\=?~()<>&*|$ ]*' -maxdepth 0 \
-exec rm -f '{}' \;
#  The "-maxdepth 0" option ensure that _find_ will not search
#+ subdirectories below $PWD.

# (Thanks, S.C.)

Example 15-4. Deleting a file by its inode number 
#!/bin/bash
# idelete.sh: Deleting a file by its inode number.

#  This is useful when a filename starts with an illegal character,
#+ such as ? or -.

ARGCOUNT=1	 			# Filename arg must be passed to script.
E_WRONGARGS=70
E_FILE_NOT_EXISTS=71
E_CHANGED_MIND=72

if [[ $# -ne "$ARGCOUNT" ]]; then
	exit $E_WRONGARGS
fi

if [[ ! -e "$1" ]]; then
	echo "File \""$1"\" does not exist."
	exit $E_FILE_NOT_EXISTS
fi
inum=`ls -i` | grep "$1" | awk '{print $1}'
# inum = inode (index node) number of file
# -----------------------------------------
# Every file has an inode, a record that holds its physical address info.
# -----------------------------------------

echo; echo -n "Are you absolutely sure want to delete \"$1\" (y/n)?"
# The '-v' option to 'rm' also asks this.
read answer
case "$answer" in
	[nN] ) echo "Changed your mind, huh?"
		   exit $E_CHANGE_MIND
		;;
	*    ) echo "Deleting file \"$1\"."
;;
esac

find . inum $inum -exec rm {} \;
#
#		Curly brackets are placeholder
#+		for text output by "find."
echo "File "\$1"\" deleted!"

exit 0

#!/bin/bash
#  Find suid root files.
#  A strange suid file might indicate a security hole,
#+ or even a system intrusion.

directory="/usr/sbin"
# Might also try /sbin, /bin, /usr/bin, /usr/local/bin, etc.
permissions="+4000" 	# suid root (dangerous!)

for file in $(find "$directory" -perm "$permissions")
do
	ls -ltF --author "$file"
done

find ~/mail -type f | xargs grep "Linux"

Example 15-5. Logfile:Using exargs to monitor system log 
#!/bin/bash

# Generates a log file in current directory
# from the tail end of /var/log/messages.

# Note: /var/log/message must be world readable
# if this script invoked by an ordinary user.
#			# root chmod 644 /var/log/messages

LINES=5

( date; uname -a ) >> logfile
# Time and machine name
echo --------------------------------->>logfile 
tail -n $LINES /var/log/messages |xargs |fmt -s >>logfile
echo >>logfile 
echo >>logfile

exit 0

# Note:
# ------
#  As Frank Wang points out,
#+ unmatched quotes (either single or double quotes) in the source file
#+ may give xrags indigestion.
#
#  He suggests the following substitution for line 15:
#  tail -n $LINES /var/log/messages | tr -d "\"'" | xargs |fmt -s >>logfile



#  Exercise:
#  ------
#  Modify this script to track changes in /var/log/messages at intervals
#+ of 20 minutes.
#  Hint: Use the "watch" command.

Example 15-6. Copying files in current directory to another
#!/bin/bash
# copydir.sh

#  Copy (verbose) all files in current directory ($PWD)
#+ to directory specified on command line.

E_NOARGS=65
if [[ -z "$1" ]]; then
	echo "Usage: `basename $0` diectory-to-cpoy-to"
	exit $E_NOARGS
fi

ls . | xargs -i -t cp ./ {} $1
#
#  -t is "verbose" (output command line to stderr) option.
#  -i is "replace strings" option.
#  {} is a placeholder for output text.
#  This is similar to the use of a curly bracket pair in "find."
#
#  List the files in current directory (ls .),
#+ pass the output of "ls" as arguments to "xargs" (-i -t options).
#+ then copy (cp) these arguments ({}) to new directory ($1).
#
#  The net result is the exact equivalent of
#+     cp * $1
#+ unless any of the filename has embedded "whitespace" charachters.

exit 0

Example 15-7. Killing process by name
#!/bin/bash
# kill-byname.sh: Killing processes by name.
# Compare this script with kill-process.sh

#  For instance,
#+ try "./kill-byname.sh xterm" --
#+ and watch all the xterms on your desktop disappear.

#  Warning:
#  ---------
#  This is a fairly dangerous script.
#  Running it carelessly (especially as root)
#+ can cause data loss and other undesirable effects.

E_BADARGS=66

if [[ -z "$1" ]]; then
	echo "Usage: `basename $0` Process(es)_to_kill"
	exit $E_BADARGS
fi

PROCESS_NAME="$1"
ps ax | grep "$PROCESS_NAME" | awk '{print $1}' | xargs -i kill {} 2&>/dev/null
#

#  Note:
#  -i is the "replace strings" option to xargs.
#  The curly brackets are the placeholder for the replacement.
#  2& >/dev/null supresses unwanted error messages.
#
#  can grep "$PROCESS_NAME" be replaced by pidof "$PROCESS_NAME"?
#  ---------------------------------------------------------------

exit $?

#  The "killall" command has the same effect as this script,
#+ but using it is not quite as educational.

Example 15-8. Word frequency analysis using xargs
#!/bin/bash
#  waf2.sh: Crude word frequency analysis on a text file.

# Uses 'xargs' to decompose lines of text into single words.
# Compare this example to the "wf.sh" script later on.

#  Check for input file on command line.
ARGS=1
E_BADARGS=65
E_NOFILE=66

if [[ $# -ne "$ARGS" ]]; then
	# Correct number of arguments passed to script?
	echo "Usage: `basename $0` filename"
	exit $E_BADARGS
fi

if [[ ! -f "$1" ]]; then 	# Check if file exists.
	echo "File \"$1\""
	exit $E_NOFILE
fi


###########################################################
cat "$1" | xargs -n1 | \
# List the file, one word per line.
tr A-Z a-z | \
#  Shift characters to lowercase.
sed -e 's/\.//g' -e 's/\,//g' -e 's/ /\g' | \
#  Filter out periods and commands, and
#+ change space between words to linefeed,
sort | uniq -c | sort -nr 
#  Finally prefix occurrence count and sort numberically.
#############################################################

#  This does the same job as the "wf.sh" example,
#+ but a bit more ponderously, and it runs more slowly (why?).

exit 0

Example 15-9. Using expr 
#!/bin/bash

#  Demonstrating some of the uses 'expr'
#  ======================================

echo 

# Arithmetic Operators
# ----------------------

# echo "Arithmetic Opertors"
echo 
a=`expr 5 + 3`
echo "5 + 3 = $a"
a=`expr 5 + 3 = $a`

a =`expr $a + 1`
echo 
echo "a + 1 = $a"
echo "(incrementing a variable)"

a=`expr 5 % 3`
# modulo
echo
echo "5 mod 3 = $a"

echo 
echo 

#  Logical Operators
#  -------------------

#  Returns 1 if true, 0 if false,
#+ opposite of normal Bash convention.

echo "Logical Operators"
echo

x=24
y=25
b=`expr $x =$y`		# Test equality.
echo "b = $b"		# 0 ($x - ne $y)
echo 

a=3
b= `expr $a \> 10`
echo 'b=`expr $a \>10`, therefore... '
echo "If a > 10, b = 0 (false)"
echo "b = $b" 		# 0 ( 3 ! -gt 10)
echo 

b=`expr $a \< 10`
echo "$If a < 10, b = 1 (True)"
echo "b = $b"			# 1 ( 3 - lt 10)
echo 
# Note escaping of operators.

b=`expr $a \< =3`
echo "If a <=3, b = 1 (True)"
echo "b = $b" 		# 1 ( 3 -le 3)
# There is also a "\>=" operator (geater than or equal to).

echo
echo 


# String Operators
# ----------------

echo "String Operators"
echo 

a=1234zipper43231
echo "The string being operatorted upon is \"$a\"."

# lenght: lenght of string
b=`expr length $a`
echo "Length of "\$a\" is $b."

# length: length of string
b=`expr length $a`
echo "Length of \"$a\" is $b."

# index: position of first character in substring
#        that matches a character in string
b=`expr substr $a 2 6`
echo "Substring of \"$a\", staring at position 2, \
and 6 chars long is \"$b"\."


#  The default behavior of the 'match' operations is to 
#+ search for the specified match at the ***begining*** of the string.
#
#	users Regular Expressions
b=`expr match "$a" '[0-9]*'` 					# Numerical count.
echo Number of digits at the begining of \"$a\" is $b.
b=`expr match "$a" '\([0-9]*\)'`				# Note that escaped parentheses
#					 ==      == 				+ trigger substring match.
echo "The digits at the beginning of  \"$a\" are \"$b\"."

echo 

exit 0

#!/bin/bash

echo 
echo "String operating using \"expr \$string : \" construct"
echo "======================================================"
echo

a=1234zipper5FLIPPER4321

echo "The string being operated upon is \"`expr "$a"  '\(.*\)'` \"."
#	  Escaped parentheses grouping operator.           ==   ==

#  *********************************
#+ 			Escaped parentheses
#+			  match a substring
#  *********************************


#  If no escaped parentheses...
#+ then 'expr' converts the string operand to an integer.

echo "Length of \"$a\" is `expr "$a" : '.*'`." 		#  Length of string

echo "Number of digits at the begining of \"$a\" is `expr "$a" : '[0-9]*'`." 

# -------------------------------------------------------- #

echo 

echo "The digits at the begining of  \"$a\" are `expr "$a" : '\([0-9]\)'`."
#
echo "The first 7 characters of \"$a\" are `expr "$a" : '\([0-9]*\)'`."
#		  =======
# "Again, escaped parentheses force a substring match."
#
echo "The last 7 characters of \"$a\" are `expr "$a" :'.*\(......\)'`."
#
#         ====                  end of string operator ^^
#    （actually means skip over one or more of any characters until specified
#+  substring)

echo 

exit 0

15.3. Time / Date Commands 
Time/date and timing 

Example 15-10. Using date
#!/bin/bash
# Exercising the 'date' command
echo "The number of days since the year's `date +%j`."
# Needs a leading '+' to invoke formating.
# %j gives day of year.

echo "The number of seconds elapsed since 01/01/1970 is `date +%s`."
#  %s yields number of seconds since "UNIX epoch" began,
#+ but how is this useful?

prefix=temp 
suffix=$(date +%s)	# The "+%s" option to 'date' is GNU-specific.
filename=$prefix.$suffix
echo $filename
#  It's great for creating "unique" temp filenames,
#+ even between than using $$.

# Read the 'date' man page for more formating options.

exit 0

cat list-1 list-2 list-3 |sort | uniq >final.list 
# Concatenates the list files,
# sorts them,
# removes duplicate lines,
# and finally writes the result to an output file.

Example 15-11. Word Frequency Analysis 
#!/bin/bash
#  wf.sh: Crude wod frequenency analysis on a text file.
#  This is a more efficient version of the "wf2.sh" script.


# Check for input file on command line.
ARGS=1
E_BADARGS=65
E_NOFILE=66

if [[ $# -ne "$ARGS" ]]; then # Corrent number of arguments passed to script?
	echo "Usage: `basename $0` filename"
	exit $E_BADARGS
fi

if [[ ! -f "$1" ]]; then 	# Check if file exists.
	echo "File \"$1\" does not exists."
	exit $E_NOFILE
fi

############################################################
# main()
sed -e 's/\.//g' -e 's/\,//g' -e 's/ /\//g' "$1" | tr 'A-Z' 'a-z' | sort |uniq -c |sort -nr

#			               ========================
#							Frenquency of occurrence

#  Filter out periods and commas, and
#+ change space between words to linefeed,
#+ then shift characters to lowercase, and
#+ finally prefix occurrence count and sort numberically.

#  Arun Giridhar suggests modifying the above to:
#  ... | sort | uniq -c | sort +1 [-f] sort +0 -nr
#  This adds secondary sort key, so instances of 
#+ equal occurrence are sorted alphabetically,
#  As he explains it:
#  "This is effectively a radix sort, first on the
#+ least significant column
#+ (word os string, optionally case-insensitive
#+ and last on the most significan column (frequency)."
#
#  As Frank Wang expalins , the above is equivalent to 
#+ 		... | sort |unqi -c | sort +0 -nr
#+ and the following also works:
#+         ... | sort | uniq -c | sort -klnr -k
###########################################################

exit 0

#  Exercises:
# -------------
# 1) Add 'sed' commands to filter out other punctuation,
#+ such as semicolons.
# 2) Modify the script to also filter out multiple spaces and
#+ other whitespace.

# List all the users in /etc/passwd.

FILENAME=/etc/passwd
fot user in $(cut -d: -f1 $FILENAME)
do
	echo $user 
done

# Thanks, Oleg Philon for suggesting this.

Example 15-12. Which files are scripts?
#!/bin/bash
# script-detector.sh: Detects scripts within a directory.

TESTCHARS=2		#  Test first 2 characters.
SHABANG='#'!	#  Scripts begin with a "sha-bang."

for file in * 	# Traverse all the files in current directory.
do
	if [[ `head -c$TESTCHARS "$file"` = "$SHABANG" ]]; then
		#	head -2 		#!
		#  The '-c' option to 'head' outputs a specified
		#+ number of characters, rather than lines (the default).
		echo "File \"$file\" is a script."
	else
		echo "File \"$file\" is *not* a script."
	fi
done

exit 0

#  Exercises:
#  --------
#  1) Modify this script to take as an optional argument
#+    the directory to scan for scripts
#+    (rather than just the current working directory).
#
#  2) As it stands, this script gives "false positives" for
#+     Perl, awk and others script language scripts.
#      Correct this.

Example 15-13. Generating 10-digit random numbers

#!/bin/bash
# rnd.sh: Outputs a 10-digit random number

# Script by Stephane Chazelas.

head -c4 /dev/urandom | od -N4 -tu4 | sed -ne 'ls/.* //p'

# ====================================================== #

# Analysis
# ---------

# head:
# -c4 option takes first 4 bytes.

# od:
# -N4 option limits output to 4 bytes.
# -tu4 option selects unsigned decimal format for output.

# sed:
# -n option, in combination with "p" flag to the "s" command,
# outputs only matched lines.


# The author of this script explains the action of 'sed', as follows.

# head -c4 /dev/urandom | od -N4 -tu4 | sed -ne 'ls/.* //p'

# ----------------------------------> |

# Assume output up to "sed" ---------> |
# is 00000000 1198195154 \n

#  sed begins reading characters: 00000000 1198195154\n.
#  Here it finds a newline character,
#+ so it is ready to process the first line (00000000 1198195154).
#  It looks at its <range><action>s. The first and only one is 

#  range action
#  1     s/.* //p

#  The line number is in the range, so it executes the action:
#+ tries to substitute the longest string ending with a space in the line
#  ("00000000 ") with nothing (//), and if it succeeds, prints the result
#  ("p" is a flag to the "s" command here, this is different
#+ from the "p" command).

#  sed is now ready to continue reading its input. (Note that before
#+ continuing, if -n option had not been passed, sed would have printed
#+ the line once again).

# Now, sed reads the remiander of the characters, and finds the
#+ end of the file.
#  It is now ready to process its 2nd line (which is also numbered '$' as
#+ it's the last one).

#  It sees it is not matched by any <range>, so its job is done.

#  In few word this sed command means:
#  "On the first line only, remove any character up  to the right-most space,
#+ then print it."

#  A better way to do this would have been:
#			sed -e 's/.* //q'

# Here, two <range><action>s (could have been written
#		sed -e 's/.* // -e q'):

#  range 					action
#  nothing (matches line) 	s/.* //
#  nothing (mathees line)	q (quit)

#  Here, sed only reads its first line of input.
#  It performs both actions, and prints the line (substituted) before
#+ quitting (because of the "q" action) since the "-n" option is not passed.

# =========================================================== #

#  An even simpler altenative to the above one-line script would be:
#				head -c4 /dev/urandom | od -An -tu4

exit 0

Example 15-14. Using tail to monitor the system log
#!/bin/bash

filename=sys.log 

cat /dev/null > $filename; echo "Creating / cleaning out file."
#  Creates file if it does not already exists,
#+ and truncates it to zero length if it does.
#  : > filename and > filename also work.

tail /var/log/messages > $filename
# /var/log/messages must have world read permission for this to work.

echo "$filename contains tail end of system log."

exit 0

Example 15-15. Printing out the From lines in stored e-mail messages
#!/bin/bash
# from.sh

#  Emulates the useful "from utility in Solaris, BSD, etc.
#  Echoes the "From" header line in all messages
#+ in your e-mail directory.

MAILDIR=~/mail/* 				#  No quoting of variable. Why?
GREP_OPTS="-H -A 5 --color"		#  Show file, plus extra context lines
								#+ and display "From" in color.
TARGETSTR="^From"				#  "From" at begining of line.

for file in $MAILDIR			#  No quoting of variable.
do
	grep $GREP_OPTS "$TARGETSTR" "$file"
	#    ^^^^^^^^^^ 			# Again, do not quote this variable.
	echo 
done

exit $?

#  Might wish to pipe the output of this script to 'more' or
#+ redirectory it to a file...

SUCCESS=0 		#  if grep lookup successds
word=Linux
filename=data.file 

grep -q "$word" "$filename"		#  The "-q" option
								#+ causes nothing to each to stdout.
if [[ $? -eq "$SUCCESS" ]]; then
	#
	echo "$word found in $filename"
else
	echo "$word not found in $filename"
fi

Example 15-16. Emulating grep in a script 
#!/bin/bash
# grp.sh: Very crude reimplementation of 'grep'.

E_BADARGS=65

if [[ -z "$1" ]]; then 			# Check for argument to script.
	echo "Usage: `basename $0` pattern"
	exit $E_BADARGS
fi

echo 

for file in * 	# Traverse all files in $PWD.
do
	output=$(sed -n /"$1"/p $file)  #  Command substitution.
	if [[ ! -z "$output" ]]; then 	# What happens if "$output" is not quoted?
		echo -n "$file: "
		echo $output
	fi 								# sed -ne "/$1/s|^|${file}: |p" is equivalent to above.

	echo 
done

echo 

exit 0

#  Exercises:
#  --------
# 1) Add newlines to output, if more than one match on any given file.
# 2) Add features.

Example 15-17. Looking up definitions in Webster is 1913 Dictionary
#!/bin/bash 
# dict-lookup.sh 

#  This script looks up definitions in the 1913 Webster is Dictionary.
#  This Public Domain dictionary is available for download 
#+ from variables sites, including
#+ Project Gutenberg (http://www.gutenberg.org/etext247).
#
#  Convert it from DOS to UNIX format (only LF at end of line)
#+ before using it with this script.
#  Store the file in plain, uncompressed ASCII.
#  Set DEFAULT_DICTFILE variable below to path/filename.


E_BADARGS=65
MAXCONTEXTLINES=50					# Maximum number of lines to show.
DEFAULT_DICTFILE="/usr/share/dict/webster1913-dict.txt"
									# Default dictionary file pathname.
									# Change this as necessary.

#  Note:
#  ----
#  This particular edition of the 1913 Webster's
#+ begins each entry with an uppercase letter
#+ (lowercase for the remaining characters).
#  Only the *very first line* of an entry begins this way,
#+ and that's why the search algorithm below works.


if [[ -z $(echo $1 | sed -n '/^[A-Z]/p') ]]; then
	#  Must at least specify word to look up, and
	#+ it must start with an uppercase letter.
	echo "Usage: `basename $0` Word-to-define [dictionary-file]"
	echo
	echo "Note: Word to look up must start with capital letter,"
	echo "with the rest of the word in lowercase."
	echo "---------------------------------------"
	echo "Examples: Abandon, Dictionary, Marking,. etc."
	exit $E_BADARGS
fi

if [[ -z "$2" ]]; then 				#  May specify different dictionary
									#+ as an argument to this script.
	dictfile=$DEFAULT_DICTFILE
else
	dictfile="$2"
fi

# ---------------------------------------------------
Definition=$(fgrep -A $MAXCONTEXTLINES "$1 \\" "$dictfile")
# 					Definitions in form "Word \..."
#
#  And, yes, "fgrep" is fast enough
#+ to search even a very large text file.


#  Now, snip out just the definition block.

echo "$Definition" | sed -n '1,/^[A-Z]/p' |
#  Print from first line of output
#+ to the first line of the next entry.
sed '$d' | sed '$d'
#  Delete last two lines of output
#+ (blank line and first line of next entry).
# -------------------------------------------------

exit 0

#  Exercises:
#  -------------
#  1) Modify the script to accept any type of any alphabetic input
#     + (uppercase, lowercase, mixed case), and convert it
#     + to an acceptable format for processing.
#
#  2) Convert the script to a GUI application,
#     + using something like 'gdialog'...
#       The script will then no longer take its argument(s)
#     + from the command line.
#
#   3) Modify the script to parse one of the other avaiable
#     + Public Domain Dictionaries, such as the U.S. Census Bureau Gazetteer.

Example 15-19. toupper: Transforms a file to all uppercase.

#!/bin/bash
#  Changes a file to all uppercase.

E_BADARGS=65

if [[ -z "$1" ]]; then 	# Standard check for command line arg.
	echo "Usage: `basename $0` filename"
	exit $E_BADARGS
fi

tr a-z A-Z < "$1"

#  Same effect as above, but using POSIX character set notation:
# 			tr '[:lower:]' '[:upper:]' < "$1"
#  Thanks, S.C.

exit 0

#  Exercise:
#  Rewrite this script to give the option of changing a file
#+ to *either* upper of lowercase.

Example 15-20. lowercase: Changes all filenames in working directory to lowercase.
#!/bin/bash
#
#  Changes every filenames in workding directory to all all lowercase.
#
#  Inspired by a script of John Dubois,
#+ which was teanslated into Bash by Chet Ramey,
#+ and considerably simplified by the author of the ABS Guide.

for filname in * 		#  Traverse all files in directory.
do
	fname=`banename $filename`
	n=`echo $fname | tr A-Z a-z` 		# Change name to lowercase.
	if [[ "$fname" != "$n" ]]; then 	# Rename only files not already lowercase.
		mv $fname $n 
	fi
done

exit $?

#  Code below this line will not execute because of "exit".
# ----------------------------------------------------- #
# To run it, delete script above line.

# The above script will not work on filenames containing blanks or newlines.
# Stephane Chazelas therefore suggests the following alternative:

for filename in * 		# Not necessary to use basename,
						# since "*" won't return any file containing '/'.
do
	n=`echo $"filename/" |tr '[:upper:]' '[:lower:]'`
	#                          POSIX   char  set notation.
	#                     Slash added so that trailing newlines are not
	#                     removed by command substitution.
		#  Variable substitution:
		n=${n%/} 		# Removes trailing slash, added above, from filename.
		[[ $filename == $n ]] || mv "$filename" "$n"
							#  Checks if filename already lowercase.
done
exit $?

Example 15-28. Using cpio to move a directory tree 
#!/bin/bash

# Copying a directory of using 'cpio':
#  Speed of copying. It's faster than 'tar' with pipes.
#  Well suited for copying special files (named pipes, etc.)
#+ that 'cp' may choke on.

ARGS=2
E_BADARGS=65

if [[ $# -ne "$ARGS" ]]; then
	echo "Usage: `basename $0` source destination"
	exit $E_BADARGS
fi
source="$1"
destination="$2"

#########################################################
find "$source" -depth | cpio -admvp "$destination"
#			    ^^^^^^^       ^^^^^^
#  Read the 'find' and 'cpio' info pages to decipher these options.
#  The above works only relative to $PWD (current directory)...
#+ full pathnames are specified.
########################################################


#  Exercise:
#  ---------

#  Add code to check the exit status ($?) of the 'find' | cpio pipe
#+ and output appropriate error messages if anything went wrong.

exit $?





# 看到这里
http://www.engr.iupui.edu/~dskim/tutorials/bash-advanced/html/textproc.html

http://www.engr.iupui.edu/~dskim/tutorials/bash-advanced/html/index.html
