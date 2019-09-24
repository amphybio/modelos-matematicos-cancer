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
 *       ARQUIVO:  competicao.c
 *
 *     DESCRIÇÃO: Programa para cálculo do crescimento de multiplas
 *                populações considerando que a capacidade do sistema
 *                também depende do tempo.
 *
 *        OPÇÕES:
 *               -u        Instuções de uso
 *    REQUISITOS:  ---
 *          BUGS:  ---
 *         NOTAS:  ---
 *         AUTOR:  Alexandre F. Ramos <alex.ramos@usp.br>
 *        VERSÃO:  1.0
 *       CRIAÇÃO:  29/08/2019
 *       REVISÃO:  09/09/2019 Alan U. Sabino <alan.sabino@usp.br> (1)
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
#define numero_parametros 3

static const char usage[] =
  "\t Uso: ./crescdinam <nome do arquivo de entrada>.in <nome do arquivo\
de saída>.out <nome do arquivo de log>.log \n\n";

/* ================================ FUNÇÕES ================================= */

long double coeff_f1(long double r1, long double K1, long double alpha12, long double x1, long double x2)
{
  long double f;
  f =  r1*x1*( 1 - ( x1 + alpha12*x2 )/K1 );
  return f;
}

long double coeff_f2(long double r2, long double K2, long double alpha21, long double x1, long double x2)
{
  long double f;
  f =  r2*x2*( 1 - ( x2 + alpha21*x1 )/K2 );
  return f;
}

int main(int argc, char * * argv)
{

  int cc;

  optarg = NULL;

  while ( ( cc=getopt(argc,argv,OPTS))!=-1)
    {
      switch (cc)
        {
        case 'u':
          printf("%s",usage);
          break;
        }
    }

  /* ============================== VARIÁVEIS  ============================== */

  /* inteiros para contagem nos laços */
  int i;

  // --- eq. 1: on x1 ---/
  long double x1, r1, K1, alpha12;
  /*
    x1: densidade de celulas tipo 1 (saudável);
    r1: taxa de crescimento da população tipo 1;
    K1: capacidade do nicho para abrigar o tipo 1;
    alpha12: capacidade das células do tipo 2 de reduzirem as quantidades das
    células do tipo 1;
  */

  // --- eq. 2: on x2 ---/
  long double x2, r2, K2, alpha21;
  /*
    x2: densidade de celulas tipo 2 (cancerosa);
    r2: taxa de crescimento da população tipo 2;
    K2: capacidade do nicho para abrigar o tipo 2;
    alpha21: capacidade das células do tipo 1 de reduzirem as quantidades das
    células do tipo 2;
  */

  // --- Numerical solution parameters ---//
  long double h,t;
  // h: passo de integração; t: tempo em unidades arbitrárias.
  unsigned long long int n;
  // número de passos de integração

  // ********************************************************* //

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
      printf("Please add 3 parameter: inputfile, outputfile, logfile\n");
      exit(0);
    }

  strcpy(infile, argv[argc-3]);
  strcpy(outfile, argv[argc-2]);
  strcpy(logfile, argv[argc-1]);

  strcpy(tmp, "date ");
  strncat(tmp, ">> ", 3);
  strncat(tmp, logfile, strlen(logfile));
  flog = fopen(logfile, "w");
  fprintf(flog, "------------Start time------------\n");
  fclose(flog);
  if(system(tmp)) printf("Ok");

  gettimeofday( & start, NULL);

  /* -------------------------------------------------------------------*/

  fin = fopen(infile, "r");
  if (fin == NULL)
    {
      printf("File %s is  not exist\n", infile);
      exit(0);
    }
  if ((fscanf(fin, "Parametros\n"))) printf("Error: Parametros\n");
  if ((fscanf(fin, "#Eq1\n"))) printf("Error: Eq1\n");
  if (!(fscanf(fin, "r1=%Lf\n", &r1 ))) printf("Error: variable r1\n");
  if (!(fscanf(fin, "K1=%Lf\n", &K1 ))) printf("Error: variable K1\n");
  if (!(fscanf(fin, "alpha12=%Lf\n", &alpha12 ))) printf("Error: variable alpha12\n");
  if ((fscanf(fin, "##\n"))) printf("Error: ##\n");

  if ((fscanf(fin, "#Eq2\n"))) printf("Error: Eq2\n");
  if (!(fscanf(fin, "r2=%Lf\n", &r2 ))) printf("Error: variable r2\n");
  if (!(fscanf(fin, "K2=%Lf\n", &K2 ))) printf("Error: variable K2\n");
  if (!(fscanf(fin, "alpha21=%Lf\n", &alpha21 ))) printf("Error: variable alpha21\n");
  if ((fscanf(fin, "##\n"))) printf("Error: ##\n");

  if ((fscanf(fin, "==>IntlCndtns\n"))) printf("Error: IntlCndtns\n");
  if (!(fscanf(fin, "x1=%Lf\n", &x1 ))) printf("Error: variable x1\n");
  if (!(fscanf(fin, "x2=%Lf\n", &x2 ))) printf("Error: variable x2\n");

  if ((fscanf(fin, "==>NumSimParms\n"))) printf("Error: NumSimParms\n");
  if (!(fscanf(fin, "h=%Lf\n", &h ))) printf("Error: variable h\n");
  if (!(fscanf(fin, "t=%Lf\n", &t ))) printf("Error: variable t\n");
  if (!(fscanf(fin, "n=%llu\n", &n ))) printf("Error: variable n\n");

  fclose(fin);

  flog = fopen(logfile, "a");

  fprintf(flog, "==>Parametros\n");
  fprintf(flog, "#Eq1\n");
  fprintf(flog, "r1=%Lf\n",r1);
  fprintf(flog, "K1=%Lf\n",K1);
  fprintf(flog, "alpha12=%Lf\n",alpha12);
  fprintf(flog, "##\n");
  fprintf(flog, "#Eq2\n");
  fprintf(flog, "r2=%Lf\n",r2);
  fprintf(flog, "K2=%Lf\n",K2);
  fprintf(flog, "alpha21=%Lf\n",alpha21);
  fprintf(flog, "##\n");
  fprintf(flog, "==>IntlCndtns\n");
  fprintf(flog, "x1=%Lf\n",x1);
  fprintf(flog, "x2=%Lf\n",x2);
  fprintf(flog, "==>NumSimParms\n");
  fprintf(flog, "h=%Lf\n",h);
  fprintf(flog, "t=%Lf\n",t);
  fprintf(flog, "n=%llu\n",n);

  fclose(flog);

  fout=fopen(outfile,"w");

  fprintf(fout,"%Lf \t %Lf \t %Lf\n",t,x1,x2);

  long double A11, A12, A21, A22, A31, A32, A41, A42;

  for (i=0;i<n;i++)
    {
      A11 = coeff_f1(r1, K1, alpha12, x1, x2);
      A12 = coeff_f2(r2, K2, alpha21, x1, x2);

      A21 = coeff_f1(r1, K1, alpha12, x1 + h*0.5*A11, x2 + h*0.5*A12);
      A22 = coeff_f2(r2, K2, alpha21, x1 + h*0.5*A11, x2 + h*0.5*A12);

      A31 = coeff_f1(r1, K1, alpha12, x1 + h*0.5*A21, x2 + h*0.5*A22);
      A32 = coeff_f2(r2, K2, alpha21, x1 + h*0.5*A21, x2 + h*0.5*A22);

      A41 = coeff_f1(r1, K1, alpha12, x1 + h*A31, x2 + h*A32);
      A42 = coeff_f2(r2, K2, alpha21, x1 + h*A31, x2 + h*A32);

      x1 += (A11+2.*A21+2.*A31+A41)*h/6.;
      x2 += (A12+2.*A22+2.*A32+A42)*h/6.;
      t += h;

      fprintf(fout,"%Lf \t %Lf \t %Lf\n", t, x1, x2);
    }

  fclose(fout);

  gettimeofday( & end, NULL);
  all_time = (end.tv_sec - start.tv_sec) + (float)(end.tv_usec - start.tv_usec) / 1000000.0;
  flog = fopen(logfile, "a");
  fprintf(flog, "\nRun time:\t%f s\n\n", all_time);
  fclose(flog);
  flog = fopen(logfile, "a");
  fprintf(flog, "------------ Fim ------------\n");
  fclose(flog);
  if(system(tmp)) printf("Ok");
  return 1;
}
