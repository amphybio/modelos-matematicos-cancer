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
#       ARQUIVO:  gompertz_populacao.plt
#
#     DESCRIÇÃO:  Script gnuplot que gera grafícos do modelo de Gompertz
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

# Definir nome e extensão do arquivo de saída.
set output "gompertz_populacao.eps"

# Definir legenda dos eixos x(xtics) e y(ytics).
# auto: permite que o gnuplot decida a escala da legenda no eixo.
set xtics auto
set ytics ("0" 0,"" 25, "50" 50, "" 75, "100" 100)

# Definir tics apenas na base e à esquerda.
set tics nomirror

# Definir os valores mínimos e máximos dos eixos.
set xr [0:25]
set yr [0:105]

# Definir legenda dos eixos.
set xlabel "{/Helvetica Tempo (UA)}"
set ylabel "{/Helvetica Densidade (UA)}"

# Definir título da figura.
set title "{/Helvetica Crescimento tumoral}"

# Definir gráfico sem legenda.
unset key

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

# c#(x): Função do modelo de Gompertz da poulação. c#(x) se diferencia
# nos valores do parâmetro lambda.
c1(x) = K*(c0/K)**(exp(-lambda1*x))
c2(x) = K*(c0/K)**(exp(-lambda2*x))
c3(x) = K*(c0/K)**(exp(-lambda3*x))

# Desenhar as saídas das funções
# lines: define representação em linhas
# lc (linecolor): define cor
# lw (linewidth): define espessura
plot c1(x) with lines lc rgb "red" lw 2, \
     c2(x) with lines lc rgb "blue" lw 2, \
     c3(x) with lines lc rgb "green" lw 2

