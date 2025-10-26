%{
#include <stdio.h>
#include <string.h>

FILE *fin, *fout;
%}
%option noyywrap
%%
input           { fprintf(fout, "output"); }   /* replace "input" with "output" */
.|\n            { fputc(yytext[0], fout); }    /* copy everything else */
%%
int main(int argc, char *argv[])
{
    if (argc < 2) {
        printf("Usage: %s <inputfile>\n", argv[0]);
        return 1;
    }

    fin = fopen(argv[1], "r");
    if (!fin) {
        perror("Error opening input file");
        return 1;
    }

    fout = fopen("output.txt", "w");
    if (!fout) {
        perror("Error creating output file");
        fclose(fin);
        return 1;
    }

    yyin = fin;
    yylex();

    fclose(fin);
    fclose(fout);
    printf("Replacement complete. Output written to output.txt\n");
    return 0;
}
