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
#   along with program.  If not, see <http://www.gnu.org/licenses/>.

#===============================================================================
#       ARQUIVO:  capacidade_dinamica.plt
#
#     DESCRIÇÃO:  Script gnuplot que gera grafícos do modelo de capacidade
#                 dinâmica
#
#        OPÇÕES:  ---
#    REQUISITOS:  gnuplot
#          BUGS:  ---
#         NOTAS:  ---
#         AUTOR:  Alexandre F. Ramos <alex.ramos@usp.br>
#        VERSÃO:  1.0
#       CRIAÇÃO:  29/08/2019
#       REVISÃO:  01/09/2019 Alan U. Sabino <alan.sabino@usp.br> (1)
#===============================================================================

# Gnuplot script file for plotting data in file "hist_n12_nm6432_d2346.out"
# This file is called barr-hyp-mesh_n12_nm6432_d2346.plt
reset
set size 1.4, 0.618034
set terminal postscript portrait enhanced color lw 2 "Helvetica" 25 dashed
set output "capacidade_dinamica.eps"
#set terminal fig portrait color font "Helvetica" inches dashed
#set output "DNAreading.fig"
#set terminal x11 enhanced

set   autoscale                        # scale axes automatically
unset log                              # remove any log-scaling
unset label                            # remove any previous labels
set key right bottom

set xtics auto                          # set xtics automatically
set ytics auto                          # set ytics automatically
#set label "{/Helvetica-Bold 1.}" at 0.9,142

set grid

set xtics offset 0,0.25
set ytics offset 0.8,0

set xlabel "{/Helvetica Tempo (UA)}"
set ylabel "{/Helvetica Volume (UA)}"

set xlabel offset 0,0
set ylabel offset 0.5,0

unset xr #[0:4]
unset yr #[0:10000]

set title "{/Helvetica Crescimento tumoral}"

plot 'par1.out' using 1:2 title "Capacity" with lines lc rgb "blue" lw 2, \
     'par1.out' using 1:3 title "Cell density" with lines lc rgb "red" lw 2
