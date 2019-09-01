/*
 *   Copyright (C) 2019 AMPhyBio
 *
 *   This program is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with program.  If not, see <http://www.gnu.org/licenses/>.
 *
 *==============================================================================
 *       ARQUIVO:  crescdinam.c
 *
 *     DESCRIÇÃO: Programa para cálculo do crescimento tumoral considerando que
 *                a capacidade do sistema também depende do tempo.
 *
 *        OPÇÕES:
 *               -u        Instuções de uso
 *    REQUISITOS:  ---
 *          BUGS:  ---
 *         NOTAS:  ---
 *         AUTOR:  Alexandre F. Ramos <alex.ramos@usp.br>
 *        VERSÃO:  1.0
 *       CRIAÇÃO:  29/08/2019
 *       REVISÃO:  01/09/2019 Alan U. Sabino <alan.sabino@usp.br> (1)
 *==============================================================================
 */

#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include "sys/time.h"
#include <unistd.h>

/* =============================== CONSTANTES =============================== */

#define OPTS "u"
#define XPNT 0.6666666666666667
#define numero_parametros 3

static const char usage[] =
  "\t Uso: ./crescdinam <nome do arquivo de entrada>.in <nome do arquivo\
de saída>.out <nome do arquivo de log>.log \n\n";

/* ================================ FUNÇÕES ================================= */

long double coeff_f1(long double lambda, long double x, long double K)
{
  long double f1;
  long double aux = log(x/K);
  f1 = -lambda*x*aux;
  return f1;
}

long double coeff_f2(long double phi, long double psi, long double x, long double K)
{
  long double f2;
  f2 = phi*x-psi*K*pow(x,XPNT);
  return f2;
}

int main(int argc, char *argv[])
{

  int cc;

  optarg = NULL;
  while ( ( cc=getopt(argc,argv,OPTS))!=-1)
    {
      switch (cc)
        {
        case 'u':
          printf("%s",usage);
          exit(0);
          break;
        }
    }

  /* ============================== VARIÁVEIS  ============================== */

  /* inteiros para contagem nos laços */
  int i, j;

  /* --- eq. 1: on x ---

     lambda: taxa de crescimento das células tumorais
     x: densidade de células tumorais
  */
  long double lambda, x;

  /* --- eq. 2: on K ---

     K: fator de capacidade do tumor
     psi: constante de crescimento da capacidade
     phi: constante de decaimento da capacidade
  */
  long double K, phi, psi;

  /* --- Numerical solution parameters ---

     h: passo de integração;
     t: tempo em unidades arbitrárias.
  */
  long double h,t;

  /* n:  número de passos de integração */
  unsigned long long int n;

  /* Aqui introduzimos as funções de leitura de variáveis
     nos arquivos de entrada, e os arquivos log e de saída do
     programa.
  */
  char infile[80], outfile[80];		//files
  char logfile[80], tmp[80];
  FILE * fin, * fout, * flog;
  struct timeval start, end;
  float all_time;

  if (argc-1 < numero_parametros)
    {
      printf("Por favor, passar 3 parâmetros: arquivo de entrada,\
 arquivo de saída e arquivo de log.\n");
      exit(0);
    }

  strcpy(infile, argv[argc-3]);
  strcpy(outfile, argv[argc-2]);
  strcpy(logfile, argv[argc-1]);

  strcpy(tmp, "date ");
  strncat(tmp, ">> ", 3);
  strncat(tmp, logfile, strlen(logfile));
  flog = fopen(logfile, "w");
  fprintf(flog, "------------ Inicio ------------\n");
  fclose(flog);
  if(system(tmp)) printf("Ok");

  gettimeofday( & start, NULL);

  fin = fopen(infile, "r");

  if (fin == NULL)
    {
      printf("File %s is  not exist\n", infile);
      exit(0);
    }

  if ((fscanf(fin, "Parametros\n"))) printf("Error: Parametros\n");
  if ((fscanf(fin, "#Eq1\n"))) printf("Error: Eq1\n");
  if (!(fscanf(fin, "lambda=%Lf\n", &lambda ))) printf("Error: variable lambda\n");
  if ((fscanf(fin, "##\n"))) printf("Error: ##\n");

  if ((fscanf(fin, "#Eq2\n"))) printf("Error: Eq2\n");
  if (!(fscanf(fin, "phi=%Lf\n", &phi ))) printf("Error: variable psi\n");
  if (!(fscanf(fin, "psi=%Lf\n", &psi ))) printf("Error: variable phi\n");
  if ((fscanf(fin, "##\n"))) printf("Error: ##\n");

  if ((fscanf(fin, "==>IntlCndtns\n"))) printf("Error: IntlCndtns\n");
  if (!(fscanf(fin, "x=%Lf\n", &x ))) printf("Error: variable x\n");
  if (!(fscanf(fin, "K=%Lf\n", &K ))) printf("Error: variable K\n");

  if ((fscanf(fin, "==>NumSimParms\n"))) printf("Error: NumSimParms\n");
  if (!(fscanf(fin, "h=%Lf\n", &h ))) printf("Error: variable h\n");
  if (!(fscanf(fin, "t=%Lf\n", &t ))) printf("Error: variable t\n");
  if (!(fscanf(fin, "n=%llu\n", &n ))) printf("Error: variable n\n");

  fclose(fin);

  flog = fopen(logfile, "a");

  fprintf(flog, "Parametros\n");
  fprintf(flog, "#Eq1\n");
  fprintf(flog, "lambda=%Lf\n",lambda);
  fprintf(flog, "##\n");
  fprintf(flog, "#Eq2\n");
  fprintf(flog, "phi=%Lf\n",phi);
  fprintf(flog, "psi=%Lf\n",psi);
  fprintf(flog, "##\n");
  fprintf(flog, "==>IntlCndtns\n");
  fprintf(flog, "x=%Lf\n",x);
  fprintf(flog, "K=%Lf\n",K);
  fprintf(flog, "==>NumSimParms\n");
  fprintf(flog, "h=%Lf\n",h);
  fprintf(flog, "t=%Lf\n",t);
  fprintf(flog, "n=%llu\n",n);

  fclose(flog);

  fout=fopen(outfile,"w");

  coeff_f1(lambda, x, K);
  coeff_f2(phi, psi, x, K);

  long double A11,
              A12,
              A21,
              A22,
              A31,
              A32,
              A41,
              A42;

  fprintf(fout,"%Lf \t %Lf \t %Lf\n",t,x,K);

  for (i=0;i<n;i++)
    {
      A11 = coeff_f1(lambda, x, K);
      A12 = coeff_f2(phi, psi, x, K);

      A21 = coeff_f1(lambda, x + h*0.5*A11, K + h*0.5*A12);
      A22 = coeff_f2(phi, psi, x + h*0.5*A11, K + h*0.5*A12);

      A31 = coeff_f1(lambda, x + h*0.5*A21, K + h*0.5*A22);
      A32 = coeff_f2(phi, psi, x + h*0.5*A21, K + h*0.5*A22);

      A41 = coeff_f1(lambda, x + h*A31, K + h*A32);
      A42 = coeff_f2(phi, psi, x + h*A31, K + h*A32);

      x += (A11+2.*A21+2.*A31+A41)*h/6.;
      K += (A12+2.*A22+2.*A32+A42)*h/6.;

      t += h;

      fprintf(fout,"%Lf \t %Lf \t %Lf\n",t,x,K);
    }

  fclose(fout);

  gettimeofday( & end, NULL);
  all_time = (end.tv_sec - start.tv_sec) + (float)(end.tv_usec - start.tv_usec) / 1000000.0;
  flog = fopen(logfile, "a");
  fprintf(flog, "\nTempo de execução:\t%f s\n\n", all_time);
  fclose(flog);
  flog = fopen(logfile, "a");
  fprintf(flog, "------------ Fim ------------\n");
  fclose(flog);
  if(system(tmp)) printf("Ok");
  return 1;
}
