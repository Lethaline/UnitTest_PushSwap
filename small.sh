# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    small.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lolemmen <lolemmen@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/23 12:51:29 by lolemmen          #+#    #+#              #
#    Updated: 2022/11/25 14:38:28 by lolemmen         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Sources

source utils.sh

# 2 Values

let "warning=0"
let "ErrLeaks=0"
let "ErrCheck=0"

ft_print "Test using 2 values : " 0
ft_header_tab
ft_push_swap 2 2 2 2 2 2

# 3 values

let "warning=0"
let "ErrLeaks=0"
let "ErrCheck=0"

ft_print "\nTest using 3 values : " 0
ft_header_tab
ft_push_swap 3 3 3 3 3 3

# 5 values

let "warning=0"
let "ErrCheck=0"
let "ErrLeaks=0"

ft_print "\nTest using 5 values : " 0
ft_header_tab
ft_push_swap 5 13 13 13 13 13
