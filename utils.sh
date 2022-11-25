# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    utils.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lolemmen <lolemmen@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/23 12:41:36 by lolemmen          #+#    #+#              #
#    Updated: 2022/11/25 12:58:18 by lolemmen         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Error Management

ft_check_error()
{
	SEG=`echo $? | bc`;

	if [ $SEG -ne $1 ]
	then
		let "warning += 1"
		echo "${LOG_RED}Your push_swap CRASH with these arguments : ${LOG_NOCOLOR}${ARG}";
		return 1
	else
		echo "${LOG_GREEN}\t[OK]${LOG_NOCOLOR}\c";
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
			echo "${LOG_GREEN}\t[OK]${LOG_NOCOLOR}\c"
		else
			echo "${LOG_RED}\t[KO]${LOG_NOCOLOR}\c"
			let "ErrCheck+=1"
		fi
	fi
}

ft_check_leaks()
{
	LEAKS="`leaks --atExit -- ${ACCESS}push_swap $1 | grep "leaked"`"
	CHECK=`echo ${LEAKS:15} | grep "0" | wc -l`
	if [ $CHECK != 1 ]
	then
		echo "${LOG_RED}\t[KO]${LOG_NOCOLOR}\c"
		ft_print_leaks $1
		let "ErrLeaks+=1"
		return 1
	else
		echo "${LOG_GREEN}\t[OK]${LOG_NOCOLOR}\c"
	fi
	return 0
}

ft_print_leaks()
{
	LEAKS="`leaks --atExit -- ${ACCESS}push_swap $1 | grep "leaked"`"
	echo "\n${LEAKS:14}\c"
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
	echo "Do you want to check the leaks ? [y/n]"
	read input
	case $input in
		'y')
			let "leaks++";
			break
			;;
		'n')
			break
			;;
	esac
done
}
