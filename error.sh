# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    error.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lolemmen <lolemmen@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/23 13:13:48 by lolemmen          #+#    #+#              #
#    Updated: 2022/11/25 14:36:12 by lolemmen         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Sources

source utils.sh

# Variables

let "LeakErr=0";
let "warning=0";
let "nbTest=0";

# Using a NULL argument

ARG="";
let "nbTest+=1";
ft_print "Test running with [$ARG] : " 1
result="`${ACCESS}push_swap $ARG`\n";
ft_check_error 0
if [ $leaks == 1 ]
then
	ft_check_leaks $ARG
fi
ft_print "" 0

# Using a atoi-breaker

ARG="-2a 2";
let "nbTest+=1";
ft_print "Test running with [$ARG] : " 1
result="`${ACCESS}push_swap $ARG`\n"
ft_check_error 1
if [ $leaks == 1 ]
then
	ft_check_leaks $ARG
fi
ft_print "" 0

# Using a non-numeric argument

ARG="- 2";
let "nbTest+=1";
ft_print "Test running with [$ARG] : " 1
result="`${ACCESS}push_swap $ARG`\n"
ft_check_error 1
if [ $leaks == 1 ]
then
	ft_check_leaks $ARG
fi
ft_print "" 0

# Using a non-numeric argument

ARG="2 -";
let "nbTest+=1";
ft_print "Test running with [$ARG] : " 1
result="`${ACCESS}push_swap $ARG`\n"
ft_check_error 1
if [ $leaks == 1 ]
then
	ft_check_leaks $ARG
fi
ft_print "" 0

# Using a non-numeric argument

ARG="-2 a";
let "nbTest+=1";
ft_print "Test running with [$ARG] : " 1
result="`${ACCESS}push_swap $ARG`\n"
ft_check_error 1
if [ $leaks == 1 ]
then
	ft_check_leaks $ARG
fi
ft_print "" 0

# Using a number under INT_MIN

ARG="-2 -9999999999999";
let "nbTest+=1";
ft_print "Test running with [$ARG] : " 1
result="`${ACCESS}push_swap $ARG`\n"
ft_check_error 1
if [ $leaks == 1 ]
then
	ft_check_leaks $ARG
fi
ft_print "" 0

# Using a number under INT_MAX

ARG="-2 9999999999999 5 3 2";
let "nbTest+=1";
ft_print "Test running with [$ARG] : " 1
result="`${ACCESS}push_swap $ARG`\n"
ft_check_error 1
if [ $leaks == 1 ]
then
	ft_check_leaks $ARG
fi
ft_print "" 0

# Using a duplicate number

ARG="-2 -9999999999999 -2";
let "nbTest+=1";
ft_print "Test running with [$ARG] : " 1
result="`${ACCESS}push_swap $ARG`\n"
ft_check_error 1
if [ $leaks == 1 ]
then
	ft_check_leaks $ARG
fi
ft_print "" 0

# Using an already sort tab

ARG="-9 0 1 2 3 4 5";
let "nbTest+=1";
ft_print "Test running with [$ARG] : " 1
RESULT="`${ACCESS}push_swap $ARG`";
ft_check_error 0
COUNT=`printf "$RESULT" | wc -l | bc`;
if [ "$RESULT" != "" ]
then
	echo "${YELLOW}Your push_swap does more than 0 instructions to resolve sorted test like :\n${EOC}${ARG}";
	let "warning += 1";
fi
if [ $leaks == 1 ]
then
	ft_check_leaks $ARG
fi
ft_print "" 0

# Forcing non-split usage

let "nbTest+=1";
ft_print "Test running with [5 3 6] : " 1
RESULT="`${ACCESS}push_swap "5" "3" "6"`";
ft_check_error 0
COUNT=`printf "$RESULT" | wc -l | bc`;
if [ $leaks == 1 ]
then
	ft_check_leaks $ARG
fi
ft_print "" 0

# Forcing non-split usage

let "nbTest+=1";
ft_print "Test running with [5 \" \" \"\"] : " 1
RESULT="`${ACCESS}push_swap "5" " " ""`";
ft_check_error 1
COUNT=`printf "$RESULT" | wc -l | bc`;
if [ $leaks == 1 ]
then
	ft_check_leaks $ARG
fi
ft_print "\n\n$warning return error(s) and $LeakErr leaks error(s) on ${nbTest} test(s)." 1
