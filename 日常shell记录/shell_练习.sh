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



# 看到这里
http://www.engr.iupui.edu/~dskim/tutorials/bash-advanced/html/fto.html

http://www.engr.iupui.edu/~dskim/tutorials/bash-advanced/html/index.html
