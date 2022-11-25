# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    UnitTest.sh                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lolemmen <lolemmen@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/23 12:31:18 by lolemmen          #+#    #+#              #
#    Updated: 2022/11/24 17:40:48 by lolemmen         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Values to change

ACCESS='../'
CHECKER="checker_Mac"

# Sources

source utils.sh

# Colors

LOG_CLEAR="\033[2K";
LOG_UP="\033[A";
LOG_NOCOLOR="\033[0m";
LOG_BLACK="\033[1;30m";
LOG_RED="\033[1;31m";
LOG_GREEN="\033[1;32m";
LOG_YELLOW="\033[1;33m";
LOG_BLUE="\033[1;34m";
LOG_VIOLET="\033[1;35m";
LOG_CYAN="\033[1;36m";
LOG_WHITE="\033[1;37m";

# Variables

let "leaks=0";
let "tester=0";

# Which test do you want

if [ $# -eq 0 ]
then
	echo "To use this UnitTester, these flags are available :\n
${LOG_BLUE}-all${LOG_NOCOLOR} : All test\n
${LOG_GREEN}-small${LOG_NOCOLOR} : Test with 1 2 3 5 values\n
${LOG_RED}-medium${LOG_NOCOLOR} : Test with 100 Values\n
${LOG_VIOLET}-big${LOG_NOCOLOR} : Test with 500 Values\n
${LOG_WHITE}-${LOG_BLUE}e${LOG_GREEN}r${LOG_YELLOW}r${LOG_RED}o${LOG_VIOLET}r${LOG_NOCOLOR} : Test all error case\n
${LOG_CYAN}clean fclean re bonus${LOG_NOCOLOR} : Your makefile commands\n";
	exit;
fi
for ARG in $@
do
	case $ARG in
		'-all')
			echo "Running Makefile..."
			make re -C $ACCESS
			ft_norm
			ft_check
			source error.sh
			echo
			source utils.sh
			echo
			source small.sh
			echo
			source medium.sh
			echo
			source big.sh
			;;
		'-small')
			ft_check
			make -C $ACCESS
			source small.sh
			;;
		'-medium')
			ft_check
			make -C $ACCESS
			source medium.sh
			;;
		'-big')
			ft_check
			make -C $ACCESS
			source big.sh
			;;
		'-error')
			ft_check
			echo "Running Makefile..."
			make -C $ACCESS
			source error.sh
			;;
		'-norm')
			ft_norm
			;;
		'-make')
			echo "make re : "
			make re -C $ACCESS
			echo "fclean : "
			make fclean -C $ACCESS
			echo "make : "
			make -C $ACCESS
			echo "check if compile again : "
			make -C $ACCESS
			echo "clean : "
			make clean -C $ACCESS
			;;
		*)
		echo "To use this UnitTester, these flags are available :\n
${LOG_BLUE}-all${LOG_NOCOLOR} : All test\n
${LOG_GREEN}-small${LOG_NOCOLOR} : Test with 1 2 3 5 values\n
${LOG_RED}-medium${LOG_NOCOLOR} : Test with 100 Values\n
${LOG_VIOLET}-big${LOG_NOCOLOR} : Test with 500 Values\n
${LOG_WHITE}-${LOG_BLUE}e${LOG_GREEN}r${LOG_YELLOW}r${LOG_RED}o${LOG_VIOLET}r${LOG_NOCOLOR} : Test all error case\n
${LOG_CYAN}clean fclean re bonus${LOG_NOCOLOR} : Your makefile commands\n";
exit;
			;;
	esac
done
