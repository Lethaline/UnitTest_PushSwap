# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    small.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lolemmen <lolemmen@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/23 12:51:29 by lolemmen          #+#    #+#              #
#    Updated: 2022/11/24 17:45:35 by lolemmen         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Sources

source utils.sh

# 2 Values

let "warning=0"
let "ErrLeaks=0"
let "ErrCheck=0"
let "min=0"
let "max=0"
let "average=0"

echo "Test using 2 values : ";
echo "NB\tReturn\c"
if test -f $ACCESS$CHECKER
then
	echo "\tCheck\c"
fi
if [ $leaks == 1 ]
then
	echo "\tLeaks"
else
	echo
fi
for i in {1..20}
do
	ARG=`ruby -e "puts (0..1).to_a.shuffle.join(' ')"`;

	RESULT="`${ACCESS}push_swap $ARG`";
	echo "${i} : \c"
	ft_check_error 0
	COUNT=`echo "$RESULT" | wc -l | bc`;
	ft_checker $ARG
	if [ $i == 1 ]
	then
		let "min=$COUNT"
		let "max=$COUNT"
	else
		if [ $min -gt $COUNT ]
		then
			let "min=$COUNT"
		fi
		if [ $max -lt $COUNT ]
		then
			let "max=$COUNT"
		fi
	fi
	let "average+=$COUNT"
	if [ $leaks == 1 ]
	then
		ft_check_leaks $ARG
	fi
	if [ $COUNT -gt 1 ]
	then
		echo "${LOG_YELLOW} Your push_swap does more than 1 instructions [$COUNT] to resolve this test : \n${LOG_NOCOLOR}${ARG}"
		let "warning+=1";
	fi
	echo
done

let "average/=20"
echo "\n\tMin\tMax\tAverage"
echo "\t$min\t$max\t$average"
echo "${warning} error(s), ${ErrCheck} checker error(s) and ${ErrLeaks} leaks error(s) in this test\n"

# 3 values

let "warning=0"
let "ErrLeaks=0"
let "ErrCheck=0"
let "min=0"
let "max=0"
let "average=0"

echo "Test using 3 values : ";
echo "NB\tReturn\c"
if test -f $CHECKER
then
	echo "\tCheck"
fi
if [ $leaks == 1 ]
then
	echo "\tLeaks"
else
	echo
fi
for i in {1..20}
do
	ARG=`ruby -e "puts (0..2).to_a.shuffle.join(' ')"`;
	RESULT="`${ACCESS}push_swap $ARG`";
	echo "${i} : \c"
	ft_check_error 0
	COUNT=`echo "$RESULT" | wc -l | bc`;
	ft_checker $ARG
	if [ $i == 1 ]
	then
		let "min=$COUNT"
		let "max=$COUNT"
	else
		if [ $min -gt $COUNT ]
		then
			let "min=$COUNT"
		fi
		if [ $max -lt $COUNT ]
		then
			let "max=$COUNT"
		fi
	fi
	let "average+=$COUNT"
	if [ $leaks == 1 ]
	then
		ft_check_leaks $ARG
	fi
	if [ $COUNT -gt 2 ]
	then
		echo "${LOG_YELLOW} Your push_swap does more than 2 instructions [$COUNT] to resolve this test : \n${LOG_NOCOLOR}${ARG}"
		let "warning+=1";
	fi
	echo
done

let "average/=20"
echo "\n\tMin\tMax\tAverage"
echo "\t$min\t$max\t$average"
echo "${warning} error(s), ${ErrCheck} checker error(s) and ${ErrLeaks} leaks error(s) in this test\n"

# 5 values

let "warning=0"
let "ErrCheck=0"
let "ErrLeaks=0"
let "min=0"
let "max=0"
let "average=0"

echo "Test using 5 values : ";
echo "NB\tReturn\c"
if test -f $CHECKER
then
	echo "\tCheck"
fi
if [ $leaks == 1 ]
then
	echo "\tLeaks"
else
	echo
fi
for i in {1..20}
do
	ARG=`ruby -e "puts (0..4).to_a.shuffle.join(' ')"`;
	RESULT="`${ACCESS}push_swap $ARG`";
	echo "${i} : \c"
	ft_check_error 0
	COUNT=`echo "$RESULT" | wc -l | bc`;
	ft_checker $ARG
	if [ $i == 1 ]
	then
		let "min=$COUNT"
		let "max=$COUNT"
	else
		if [ $min -gt $COUNT ]
		then
			let "min=$COUNT"
		fi
		if [ $max -lt $COUNT ]
		then
			let "max=$COUNT"
		fi
	fi
	let "average+=$COUNT"
	if [ $leaks == 1 ]
	then
		ft_check_leaks $ARG
	fi
	if [ $COUNT -gt 12 ]
	then
		echo "${LOG_YELLOW} Your push_swap does more than 12 instructions [$COUNT] to resolve this test : \n${LOG_NOCOLOR}${ARG}"
		let "warning+=1";
	fi
	echo
done

let "average/=20"
echo "\n\tMin\tMax\tAverage"
echo "\t$min\t$max\t$average"
echo "${warning} error(s), ${ErrCheck} checker error(s) and ${ErrLeaks} leaks error(s) in this test"
