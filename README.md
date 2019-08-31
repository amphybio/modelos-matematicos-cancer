# Modelos matemáticos

Este repositório contem a implementação de alguns modelos matemáticos
usados para o estudo dos fenômenos ligados a carcinogênese. A
estrutura de pastas se encontra da seguinte forma:

  - Nome do modelo
    - *scripts* gnuplot
    - figura exemplo EPS

Os *scripts* possuem comentários, indicados por **#**, antes de cada
instrução com objetivo de elucidar sua finalidade para a geração do
gráfico.

### Pré-requisitos

  1. [gnuplot](http://www.gnuplot.info)<br/>
  gnuplot é um programa de linha de comando, de código aberto, que pode
  desenhar gráficos a partir de funções ou dados fornecidos.

  2. [ImageMagick](https://imagemagick.org/index.php) <br/>
  ImageMagick é um programa, de código aberto, para tratar imagens
  através da linha de comando.

### Baixar e Executar

#### Instalando pré-requisitos

  Antes de iniciar a instalação, é necessário atualizar o índice de
  pacotes do linux:

    sudo apt-get update

  Instalar gnuplot:

    sudo apt-get install gnuplot-x11

  Instalar ImageMagick:

    sudo apt-get install imagemagick

#### Baixando e Executando os *scripts*

  1) Nesta página, clicar no botão verde com o texto ***clone or
  download*** e baixar arquivo zip. <br/>
  2) Descompactar arquivo zip pela linha de comando:

    unzip modelos-matematicos-cancer-master.zip

  3) Mudar para o diretório em que se deseja gerar o gráfico:

    cd modelos-matematicos-cancer-master/Exponencial/

  4) Executar o *script* usando o gnuplot:

     gnuplot exponencial.plt

  Os comandos acima são um exemplo para o caso que se deseja gerar os
  gráficos do modelo exponencial. Para gerar os gráficos dos demais
  modelos, basta alterar o diretório (passo 3) e o nome do *script*
  (passo 4).

  O arquivo gerado terá a extensão EPS (*Encapsulated PostScript*),
  mas caso desejável é possível alterar sua extensão para outros
  formatos através do ImageMagick. Por exemplo o formato *tif*:

    convert -flatten -density 300 -depth 8 -compress lzw exponencial.eps exponencial.tif

  - -flatten: remove transparência
  - -density: especifica a resolução (em *dots per inch*)
  - -depth: determina a profundidade de cor
  - -compress: comprime imagem com algoritmo especificado
