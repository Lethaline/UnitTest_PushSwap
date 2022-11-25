# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    big.sh                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lolemmen <lolemmen@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/23 12:53:36 by lolemmen          #+#    #+#              #
#    Updated: 2022/11/25 14:38:22 by lolemmen         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Sources

# 500 values

let "warning=0"
let "ErrCheck=0"
let "ErrLeaks=0"

ft_print "Test using 500 values : " 0
ft_header_tab
ft_push_swap 500 11500 10000 8500 7000 5500
