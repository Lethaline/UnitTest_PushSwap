# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    utils.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lolemmen <lolemmen@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/23 12:41:36 by lolemmen          #+#    #+#              #
#    Updated: 2022/11/25 22:27:46 by lolemmen         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Error Management

ft_check_error()
{
	SEG=`echo $? | bc`;

	if [ $SEG -ne $1 ]
	then
		let "warning += 1"
		ft_print "${LOG_RED}Your push_swap CRASH with these arguments : ${LOG_NOCOLOR}${ARG}" 0
		return 1
	else
		ft_print "${LOG_GREEN}\t[OK]${LOG_NOCOLOR}" 1
	fi
	return 0
}

ft_checker()
{
	if ! test -f ${ACCESS}${CHECKER}
	then
		return
	else
		result="`${ACCESS}push_swap $ARG | ${ACCESS}${CHECKER} ${ARG}`";
		if [[ $result =~ "OK" ]]
		then
			ft_print "${LOG_GREEN}\t[OK]${LOG_NOCOLOR}" 1
		else
			ft_print "${LOG_RED}\t[KO]${LOG_NOCOLOR}" 1
			let "ErrCheck+=1"
		fi
	fi
}

ft_check_leaks()
{
	ft_cmd "leaks"
	cmd=`echo $?`
	if [ $cmd == 1 ]
	then
		ft_print "\nCommand not found : leaks" 0
	else
		LEAKS="`leaks --atExit -- ${ACCESS}push_swap $1 | grep "leaked"`"
		CHECK=`echo ${LEAKS:15} | grep "0" | wc -l`
		if [ $CHECK != 1 ]
		then
			ft_print "${LOG_RED}\t[KO]${LOG_NOCOLOR}" 1
			ft_print_leaks $1
			let "ErrLeaks+=1"
			return 1
		else
			ft_print "${LOG_GREEN}\t[OK]${LOG_NOCOLOR}" 1
		fi
	fi
	return 0
}

ft_print_leaks()
{
	LEAKS="`leaks --atExit -- ${ACCESS}push_swap $1 | grep "leaked"`"

	ft_print "\t${LEAKS:14}" 1
	return 1
}

ft_norm()
{
	files=`find ${ACCESS} -type f -name '*.[c\|h]' | wc -l | bc`
	norm=`norminette ${ACCESS} | wc -l | bc`

	let "norm-=files"
	if [ $norm != 0 ]
	then
		echo "You have ${norm} error(s)."
		errors=`norminette ${ACCESS} | grep "Error:"`
		echo "${errors}"
	else
		echo "Norminette : ${LOG_GREEN}[OK]${LOG_NOCOLOR}"
	fi
}

ft_check()
{
	while [ 1 ]
do
	ft_print "Do you want to check the leaks ? [y/n]" 0
	read input
	case $input in
		'y')
			let "leaks++";
			ft_print "" 0
			break
			;;
		'n')
			ft_print "" 0
			break
			;;
	esac
done
}

ft_print()
{
	if [ $2 == 1 ]
	then
		echo "$1\c"
	else
		echo "$1"
	fi
}

ft_result()
{
	let "average/=$1"
	ft_print "\tMin\tMax\tAverage
\t$min\t$max\t$average
${warning} error(s), ${ErrCheck} chercker error(s) and ${ErrLeaks} leaks error(s)." 0
}

ft_border_push()
{
	if [ $1 -gt $2 ]
	then
		ft_print "\t${LOG_RED}[KO][$1]${LOG_NOCOLOR}" 0
		let "warning+=1"
	elif [ $1 -lt $6 ]
	then
		ft_print "\t${LOG_GREEN}[5][$1]${LOG_NOCOLOR}" 0
	elif [ $1 -lt $5 ] && [ $1 -gt $6 ]
	then
		ft_print "\t${LOG_CYAN}[4][$1]${LOG_NOCOLOR}" 0
	elif [ $1 -lt $4 ] && [ $1 -gt $5 ]
	then
		ft_print "\t${LOG_VIOLET}[3][$1]${LOG_NOCOLOR}" 0
	elif [ $1 -lt $3 ] && [ $1 -gt $4 ]
	then
		ft_print "\t${LOG_BLUE}[2][$1]${LOG_NOCOLOR}" 0
	else
		ft_print "\t${LOG_YELLOW}[1][$1]${LOG_NOCOLOR}" 0
	fi
}

ft_push_swap()
{
	for i in {1..20}
	do
		ARG=`ruby -e "puts (1..$1).to_a.shuffle.join(' ')"`;
		RESULT="`${ACCESS}push_swap $ARG`";
		ft_print "${i} : " 1
		ft_check_error 0
		COUNT=`echo "${RESULT}" | wc -l | bc`;
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
		ft_border_push $COUNT $2 $3 $4 $5 $6
	done
	ft_result $i
}

ft_header_tab()
{
	ft_print "NB\tReturn" 1
	if test -f ${ACCESS}${CHECKER}
	then
		ft_print "\tCheck" 1
	fi
	if [ $leaks == 1 ]
	then
		ft_print "\tLeaks" 0
	else
		ft_print "" 0
	fi
}

ft_cmd()
{
	if command -v $1 &> /dev/null
	then
		return 0
	else
		return 1
	fi
}
