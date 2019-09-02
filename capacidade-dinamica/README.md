# Modelo de crescimento dinâmico da capacidade

Neste diretório além do *script* gnuplot e da imagem *tif* podem ser encontrados:

  - crescdinam.c: código fonte com a implementação do algoritmo
  - crescdinam: arquivo executavél gerado a partir do código fonte
  - parametros-1.in: arquivo com os valores de entrada para os
    calculos realizados pelo modelo
  - executar: *script* shell que faz chamada ao programa crescdinam e
    gera grafícos a partir do resultado

Diferente dos arquivos de *script* os comentários no código fonte do
algoritmo podem ser indicados por */\* Comentário \*/*.

## Como executar

#### Execução passo a passo

1) Verifique os valores do arquivo *parametros-1.in* e altere caso desejar.

2) Executar o programa que gera os resultados da simulação:
```
    ./crescdinam parametros-1.in parametros-1.out parametros-1.log
```

3) Executar o *script* que gera o gráfico usando gnuplot:
```
    gnuplot -e "entrada='parametros-1.out'; saida='parametros-1.eps'" capacidade_dinamica.plt
```
4) Converter a imagem *eps* para formato *tif*:
```
    convert -flatten -density 300 -depth 8 -compress lzw parametros-1.eps parametros-1.tif
```
5) [Opcional] Remover arquivo *eps*:
```
    rm -rf parametros-1.eps
```
#### Execução usando o *script* shell

1) Verifique os valores do arquivo *parametros-1.in* e altere caso desejar.

2) Executar o *script* shell:
```
    ./executar parametros-1.in
```
**Observação:** Caso seja exibida alguma mensagem de erro de
permisssão, execute o comando *chmod 755 ./executar ./crescdinam* e em
seguida tente executar novamente.
