#   Copyright (C) 2019 AMPhyBio
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with Bash.  If not, see <http://www.gnu.org/licenses/>.

#===============================================================================|
#       ARQUIVO:  ---                                                           |
#                                                                               |
#     DESCRIÇÃO:                                                                |
#                                                                               |
#        OPÇÕES:  ---                                                           |
#    REQUISITOS:  ---                                                           |
#          BUGS:  ---                                                           |
#         NOTAS:  ---                                                           |
#         AUTOR:  ---                                                           |
#        VERSÃO:  ---                                                           |
#       CRIAÇÃO:  ---                                                           |
#       REVISÃO:  ---                                                           |
#===============================================================================

# Gnuplot script file for plotting data in file "hist_n12_nm6432_d2346.out"
# This file is called barr-hyp-mesh_n12_nm6432_d2346.plt
reset
set size 1.4, 0.618034
set terminal postscript portrait enhanced color lw 2 "Helvetica" 25 dashed
set output "exponential.eps"
#set terminal fig portrait color font "Helvetica" inches dashed
#set output "DNAreading.fig"
#set terminal x11 enhanced

set   autoscale                        # scale axes automatically
unset log                              # remove any log-scaling
unset label                            # remove any previous labels
set key left top

#set xtics auto                          # set xtics automatically
#set ytics auto                          # set ytics automatically
#set label "{/Helvetica-Bold 1.}" at 0.9,142

set grid

set xtics offset 0,0.25
set ytics offset 0.8,0

unset xtics #auto #("0" 0,"10" 10, "20" 20, "30" 30, "40" 40)#, "50" 50)#, "60" 60)
set ytics ("10^3" 1000) #, "" 0.05, "1" 0.1,  "" 0.15, "2" 0.2,  "" 0.25, "3" 0.3,  "" 0.35, "4" 0.4)

set xlabel "{/Helvetica Tempo (UA)}"
set ylabel "{/Helvetica Densidade (UA)}"

set xlabel offset 0,0
set ylabel offset 0.5,0

set xr [0:2]
set yr [0:5000]

set title "{/Helvetica Crescimento tumoral}"

a1 = 1.0
a2 = 0.5
a3 = 0
a4 = -0.5
a5 = -2.0

c0 = 1000.0

f1(x) = c0*exp(a1*x)
f2(x) = c0*exp(a2*x)
f3(x) = c0*exp(a3*x)
f4(x) = c0*exp(a4*x)
f5(x) = c0*exp(a5*x)

set style arrow 1 lw 2 lt 4 lc rgb "red"
set style arrow 2 lw 2 lt 4 lc rgb "blue"
set style arrow 3 lw 2 lt 4 lc rgb "green"
set style arrow 4 lw 2 lt 4 lc rgb "magenta"

set style arrow 5 lw 0.5 lt 5 lc rgb "black"

b1=1
b2=0.6
b3=0.65

c1=3000
c2=2000
c3=1010
c4=800
c5=400

# set label "{/Symbol l} = 2" at b1,c1
# set label "{/Symbol l} = 1" at b1,c2
# set label "{/Symbol l} = 0" at b1,c3
# set label "{/Symbol l} =-1" at b1,c4
# set label "{/Symbol l} =-2" at b1,c5

# set arrow from b3,c1 to b2,c1 arrowstyle 1 nohead
# set arrow from b3,c2 to b2,c2 arrowstyle 2 nohead
# set arrow from b3,c3 to b2,c3 arrowstyle 3 nohead
# set arrow from b3,c4 to b2,c4 arrowstyle 4 nohead
#
# set arrow from 0,1 to 0.3,0.7 arrowstyle 4 nohead
#
# set arrow from 0.3,0 to 0.3,0.7 arrowstyle 5 nohead
# set arrow from 0,0.7 to 0.3,0.7 arrowstyle 5 nohead

plot f1(x) title "{/Symbol l} > 0" with lines lc rgb "red" lw 2, \
     f2(x) title "{/Symbol l} > 0" with lines lc rgb "brown" lw 2, \
     f3(x) title "{/Symbol l} = 0" with lines lc rgb "black" lw 2, \
     f4(x) title "{/Symbol l} < 0" with lines lc rgb "navy" lw 2, \
     f5(x) title "{/Symbol l} < 0" with lines lc rgb "blue" lw 2

