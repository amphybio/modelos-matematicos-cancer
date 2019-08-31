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

#===============================================================================
#       ARQUIVO:  exponencial.plt
#
#     DESCRIÇÃO:  Script gnuplot que gera grafícos do modelo exponencial
#
#        OPÇÕES:  ---
#    REQUISITOS:  gnuplot
#          BUGS:  ---
#         NOTAS:  ---
#         AUTOR:  Alexandre F. Ramos <alex.ramos@usp.br>
#        VERSÃO:  1.0
#       CRIAÇÃO:  28/08/2019
#       REVISÃO:  31/08/2019 Alan U. Sabino <alan.sabino@usp.br> (1)
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

# Definir nome e extensão do arquivo de saída
set output "exponencial.eps"

# Definir legenda dos eixos x(xtics) e y(ytics).
# unset: remove todas as legendas do eixo
unset xtics
set ytics ("10^3" 1000)

# Definir os valores mínimos e máximos dos eixos.
set xr [0:2]
set yr [0:5000]

# Definir legenda dos eixos.
set xlabel "{/Helvetica Tempo (UA)}"
set ylabel "{/Helvetica Densidade (UA)}"

# Definir título da figura.
set title "{/Helvetica Crescimento tumoral}"

# Definir posição da legenda do gráfico.
set key left top

# Variáveis das funções. Valores inteiros devem ser escritos seguidos
# de ponto e zero (##.0) para que sejam representados como números do
# conjunto dos reais.

# n0: população inicial.
n0 = 1000.0

# lambda#: valores para taxa de crescimento.
lambda1 = 1.0
lambda2 = 0.5
lambda3 = 0
lambda4 = -0.5
lambda5 = -2.0

# n#(x): Função exponencial. n#(x) se diferencia nos valores do
# parâmetro lambda.
# x: tempo. O gnuplot varia de forma automática o valor desse parâmetro.
n1(x) = n0*exp(lambda1*x)
n2(x) = n0*exp(lambda2*x)
n3(x) = n0*exp(lambda3*x)
n4(x) = n0*exp(lambda4*x)
n5(x) = n0*exp(lambda5*x)

# Desenhar as saídas das funções
# title: define legenda dos dados representados
# lines: define representação em linhas
# lc (linecolor): define cor
# lw (linewidth): define espessura
plot n1(x) title "{/Symbol l} > 0" with lines lc rgb "red" lw 2, \
     n2(x) title "{/Symbol l} > 0" with lines lc rgb "brown" lw 2, \
     n3(x) title "{/Symbol l} = 0" with lines lc rgb "black" lw 2, \
     n4(x) title "{/Symbol l} < 0" with lines lc rgb "navy" lw 2, \
     n5(x) title "{/Symbol l} < 0" with lines lc rgb "blue" lw 2

