# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    medium.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lolemmen <lolemmen@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/23 12:53:25 by lolemmen          #+#    #+#              #
#    Updated: 2022/11/25 14:38:15 by lolemmen         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Sources

# 100 values

let "warning=0"
let "ErrCheck=0"
let "ErrLeaks=0"

ft_print "Test using 100 values : " 0
ft_header_tab
ft_push_swap 100 1500 1300 1100 900 700
