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


# 看到这里
http://www.engr.iupui.edu/~dskim/tutorials/bash-advanced/html/exit-status.html

http://www.engr.iupui.edu/~dskim/tutorials/bash-advanced/html/index.html
