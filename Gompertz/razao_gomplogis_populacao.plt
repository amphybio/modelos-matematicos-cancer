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
#       ARQUIVO:  razao_gomplogis_populacao.plt
#
#     DESCRIÇÃO:  Script gnuplot que gera grafícos da razao entre os tempos do
#                 modelo de Gompertz e o modelo logístico
#
#        OPÇÕES:  ---
#    REQUISITOS:  gnuplot
#          BUGS:  ---
#         NOTAS:  ---
#         AUTOR:  Alan U. Sabino <alan.sabino@usp.br>
#        VERSÃO:  1.0
#       CRIAÇÃO:  12/09/2019
#       REVISÃO:  ---
#===============================================================================

# Definir tamanho da figura (padrão em polegadas)
set size 1.4, 0.618034

# Indicar caracteristicas desejadas da saída.
# terminal postscript: arquivo de saída em formato vetorial PS/EPS
# portrait: orientação
# enhanced: melhorar fontes
# lw (linewidth): define escala padrão da espessura das linhas
# "Helvetica" 25: define padrão para tipo e tamanho da fonte
set terminal postscript portrait enhanced color lw 2 "Helvetica" 25

# Definir nome e extensão do arquivo de saída.
set output "razao_gomplogis_populacao.eps"

# Definir legenda dos eixos x(xtics) e y(ytics).
# auto: permite que o gnuplot decida a escala da legenda no eixo.
set xtics auto
set ytics ("1" 1,"" 3, "5" 5.0, "" 7, "8.5" 8.5)

# Definir tics apenas na base e à esquerda.
set tics nomirror

# Definir os valores mínimos e máximos dos eixos.
set xr [0:30]
set yr [0.8:8.5]

# Definir legenda dos eixos.
set encoding utf8
set xlabel "{/Helvetica Tempo (UA)}"
set ylabel "{/Helvetica Razão densidades (UA)}"

# Definir título da figura.
set title "{/Helvetica Razão das densidades Gompertz / logístico}"

# Definir posição da legenda do gráfico.
set key right top

# Definir grade.
set grid

# Variáveis das funções. Valores inteiros devem ser escritos seguidos
# de ponto e zero (##.0) para que sejam representados como números do
# conjunto dos reais.

# K: capacidade.
K = 100.0

# c0: tamanho inicial.
c0 = 1.0

# lambda#: valores para taxa de crescimento.
lambda1=0.25
lambda2=0.5
lambda3=0.75

# cg#(x): Função do modelo de Gompertz da poulação. c#(x) se diferencia
# nos valores do parâmetro lambda.
cg1(x) = K*(c0/K)**(exp(-lambda1*x))
cg2(x) = K*(c0/K)**(exp(-lambda2*x))
cg3(x) = K*(c0/K)**(exp(-lambda3*x))

# cl#(x): Função logística da poulação. c#(x) se diferencia nos valores do
# parâmetro lambda.
# x: tempo. O gnuplot varia de forma automática o valor desse parâmetro.
cl1(x) = (c0*K)/((K-c0)*exp(-lambda1*x)+c0)
cl2(x) = (c0*K)/((K-c0)*exp(-lambda2*x)+c0)
cl3(x) = (c0*K)/((K-c0)*exp(-lambda3*x)+c0)

plot (cg1(x)/cl1(x)) title "{/Symbol l} = 0.25" with lines lc rgb "red" lw 2, \
     (cg2(x)/cl2(x)) title "{/Symbol l} = 0.50" with lines lc rgb "blue" lw 2, \
     (cg3(x)/cl3(x)) title "{/Symbol l} = 0.75" with lines lc rgb "green" lw 2