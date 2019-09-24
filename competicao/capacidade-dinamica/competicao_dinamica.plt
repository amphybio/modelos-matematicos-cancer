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
#       ARQUIVO:  competicao.plt
#
#     DESCRIÇÃO:  Script gnuplot que gera grafícos do modelo de competição
#
#        OPÇÕES:  ---
#    REQUISITOS:  gnuplot
#          BUGS:  ---
#         NOTAS:  ---
#         AUTOR:  Alexandre F. Ramos <alex.ramos@usp.br>
#        VERSÃO:  1.0
#       CRIAÇÃO:  29/08/2019
#       REVISÃO:  24/09/2019 Alan U. Sabino <alan.sabino@usp.br> (1)
#===============================================================================
# Definir tamanho da figura (padrão em polegadas)
set size 1.4, 0.618034

# Indicar caracteristicas desejadas da saída.
# terminal postscript: arquivo de saída em formato vetorial PS/EPS
# portrait: orientação
# enhanced: melhorar fontes
# lw (linewidth): define escala padrão da espessura das linhas
# "Helvetica" 25: define padrão para tipo e tamanho da fonte
set terminal postscript portrait enhanced color lw 2 "Helvetica" 25 dashed

# Definir nome e extensão do arquivo de saída
# Neste caso, 'saida' esta como uma variavel que deve ser passada como
# paramêtro na chamada do script gnuplot pela opção '-e'
set output saida

# Definir legenda dos eixos x(xtics) e y(ytics).
# auto: permite que o gnuplot decida a escala da legenda no eixo.
set xtics auto
set ytics auto

# Definir legenda dos eixos.
set xlabel "{/Helvetica Tempo (UA)}"
set ylabel "{/Helvetica Volume (UA)}"

# Definir título da figura.
set title "{/Helvetica Crescimento tumoral}"

# Definir grade.
set grid

# Definir posição da legenda do gráfico.
set key right bottom

# Desenhar as saídas das funções
# title: define legenda dos dados representados
# lines: define representação em linhas
# lc (linecolor): define cor
# lw (linewidth): define espessura
# entrada: nome do arquivo de entrada que deve ser passado como
# paramêtro na chamada do script gnuplot pela opção '-e'
plot entrada using ($1):($3) title "Capacidade" with lines lc rgb "blue" lw 2, \
     entrada using ($1):($2) title "Densidade" with lines lc rgb "red" lw 2
