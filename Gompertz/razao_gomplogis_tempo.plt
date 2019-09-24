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
#       ARQUIVO:  razao_gomplogis_tempo.plt
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
set output "razao_gomplogis_tempo.eps"

# Definir legenda dos eixos x(xtics) e y(ytics).
# auto: permite que o gnuplot decida a escala da legenda no eixo.
set xtics auto
set ytics ("0" 0,"0.22" 0.22, "0.4" 0.40, "0.6" 0.6, "0.75" 0.75)

# Definir tics apenas na base e à esquerda.
set tics nomirror

# Definir os valores mínimos e máximos dos eixos.
set xr [0:100]
set yr [0.22:0.75]

# Definir legenda dos eixos.
set encoding utf8
set xlabel "{/Helvetica Densidade (UA)}"
set ylabel "{/Helvetica Razão tempo (UA)}"

# Definir título da figura.
set title "{/Helvetica Razão dos tempos Gompertz / logístico}"

# Definir posição da legenda do gráfico.
set key left top

# Definir grade.
set grid

# Variáveis das funções. Valores inteiros devem ser escritos seguidos
# de ponto e zero (##.0) para que sejam representados como números do
# conjunto dos reais.

# K: capacidade.
K = 100.0

# c0: tamanho inicial.
c01 = 1.0
c02 = 2.0
c03 = 4.0

# e0:
e01 = c01 / K
e02 = c02 / K
e03 = c03 / K
#e0(x) = x / K

# lambda#: valores para taxa de crescimento.
lambda=0.5

tg1(x) = (1.0/lambda)*log(log(e01)/log(x/K))
tl1(x) = (1.0/lambda)*log(((1.0-e01)/(1.0-(x/K)))*((x/K)/e01))

tg2(x) = (1.0/lambda)*log(log(e02)/log(x/K))
tl2(x) = (1.0/lambda)*log(((1.0-e02)/(1.0-(x/K)))*((x/K)/e02))

tg3(x) = (1.0/lambda)*log(log(e03)/log(x/K))
tl3(x) = (1.0/lambda)*log(((1.0-e03)/(1.0-(x/K)))*((x/K)/e03))

#tg1(x) = (1.0/lambda1)*log(log(e0(x))/log(x/K))
#tg2(x) = (1.0/lambda2)*log(log(e0(x))/log(x/K))
#tg3(x) = (1.0/lambda3)*log(log(e0(x))/log(x/K))
#
#tl1(x) = (1.0/lambda1)*log(((1.0-e0(x))/(1.0-(x/K)))*((x/K)/e0(x)))
#tl2(x) = (1.0/lambda2)*log(((1.0-e0(x))/(1.0-(x/K)))*((x/K)/e0(x)))
#tl3(x) = (1.0/lambda3)*log(((1.0-e0(x))/(1.0-(x/K)))*((x/K)/e0(x)))

plot (tg1(x)/tl1(x)) title "{/Symbol e_0} = 1"with lines lc rgb "red" lw 2, \
     (tg2(x)/tl2(x)) title "{/Symbol e_0} = 2"with lines lc rgb "blue" lw 2, \
     (tg3(x)/tl3(x)) title "{/Symbol e_0} = 4"with lines lc rgb "green" lw 2
