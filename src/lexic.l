lletra [A-Za-z]
digit [0-9]

-- Tots els caracters representables
car_repr [\040-\176]

-- Tots els caracters representables excepte la doble cometa
car_repr_ex_doble_cometa [\040-\041\043-\176]

-- Totes les lletres que generaran les paraules clau
a [aA]
b [bB]
c [cC]
d [dD]
e [eE]
f [fF]
g [gG]
h [hH]
i [iI]
j [jJ]
k [kK]
l [lL]
m [mM]
n [nN]
o [oO]
p [pP]
q [qQ]
r [rR]
s [sS]
t [tT]
u [uU]
v [vV]
w [wW]
x [xX]
y [yY]
z [zZ]

%%

-- paraules reservades (en ordre alfabetic)
{a}{n}{d}			{rl_atom (yylval, yy_line_number, yy_begin_column); return pc_and;}
{a}{r}{r}{a}{y}			{rl_atom (yylval, yy_line_number, yy_begin_column); return pc_array;}
{b}{e}{g}{i}{n}			{rl_atom (yylval, yy_line_number, yy_begin_column); return pc_begin;}
{c}{o}{n}{s}{t}{a}{n}{t}	{rl_atom (yylval, yy_line_number, yy_begin_column); return pc_constant;}
{e}{l}{s}{e}			{rl_atom (yylval, yy_line_number, yy_begin_column); return pc_else;}
{e}{n}{d}			{rl_atom (yylval, yy_line_number, yy_begin_column); return pc_end;}
{i}{f}				{rl_atom (yylval, yy_line_number, yy_begin_column); return pc_if;}
{i}{n}				{rl_atom (yylval, yy_line_number, yy_begin_column); return pc_in;}
{i}{s}				{rl_atom (yylval, yy_line_number, yy_begin_column); return pc_is;}
{l}{o}{o}{p}			{rl_atom (yylval, yy_line_number, yy_begin_column); return pc_loop;}
{m}{o}{d}			{rl_atom (yylval, yy_line_number, yy_begin_column); return pc_mod;}
{n}{e}{w}			{rl_atom (yylval, yy_line_number, yy_begin_column); return pc_new;}
{n}{o}{t}			{rl_atom (yylval, yy_line_number, yy_begin_column); return pc_not;}
{n}{u}{l}{l}			{rl_atom (yylval, yy_line_number, yy_begin_column); return pc_null;}
{o}{f}				{rl_atom (yylval, yy_line_number, yy_begin_column); return pc_of;}
{o}{r}				{rl_atom (yylval, yy_line_number, yy_begin_column); return pc_or;}
{o}{u}{t}			{rl_atom (yylval, yy_line_number, yy_begin_column); return pc_out;}
{p}{r}{o}{c}{e}{d}{u}{r}{e}	{rl_atom (yylval, yy_line_number, yy_begin_column); return pc_procedure;}
{r}{e}{c}{o}{r}{d}		{rl_atom (yylval, yy_line_number, yy_begin_column); return pc_record;}
{r}{a}{n}{g}{e}			{rl_atom (yylval, yy_line_number, yy_begin_column); return pc_range;}
{r}{e}{t}{u}{r}{n}		{rl_atom (yylval, yy_line_number, yy_begin_column); return pc_return;}
{t}{h}{e}{n}			{rl_atom (yylval, yy_line_number, yy_begin_column); return pc_then;}
{t}{y}{p}{e}			{rl_atom (yylval, yy_line_number, yy_begin_column); return pc_type;}
{w}{h}{i}{l}{e}			{rl_atom (yylval, yy_line_number, yy_begin_column); return pc_while;}

-- simbols 
":"				{rl_atom (yylval, yy_line_number, yy_begin_column); return s_dospunts;}
";"				{rl_atom (yylval, yy_line_number, yy_begin_column); return s_punticoma;}
"("				{rl_atom (yylval, yy_line_number, yy_begin_column); return s_parentesiobert;}
")"				{rl_atom (yylval, yy_line_number, yy_begin_column); return s_parentesitancat;}
"+"				{rl_atom (yylval, yy_line_number, yy_begin_column); return s_mes;}
"-"				{rl_atom (yylval, yy_line_number, yy_begin_column); return s_menys;}
"*"				{rl_atom (yylval, yy_line_number, yy_begin_column); return s_per;}
"/"				{rl_atom (yylval, yy_line_number, yy_begin_column); return s_divisio;}
"="				{rl_atom (yylval, yy_line_number, yy_begin_column); return s_igual;}
"<"				{rl_atom (yylval, yy_line_number, yy_begin_column); return s_menor;}
">"				{rl_atom (yylval, yy_line_number, yy_begin_column); return s_major;}
"<="				{rl_atom (yylval, yy_line_number, yy_begin_column); return s_menorigual;}
">="				{rl_atom (yylval, yy_line_number, yy_begin_column); return s_majorigual;}
","				{rl_atom (yylval, yy_line_number, yy_begin_column); return s_coma;}
"."				{rl_atom (yylval, yy_line_number, yy_begin_column); return s_punt;}
":="				{rl_atom (yylval, yy_line_number, yy_begin_column); return s_assignacio;}
"/="				{rl_atom (yylval, yy_line_number, yy_begin_column); return s_diferent;}
".."				{rl_atom (yylval, yy_line_number, yy_begin_column); return s_puntpunt;}

-- Expressions regulars reconegudes. Ex: sumar_parells2
{lletra}((_?)({lletra}|{digit}))*	{rl_identificador (yylval, yytext, yy_line_number, yy_begin_column); return id;}

\"({car_repr_ex_doble_cometa})*\"	{rl_literal_string (yylval, yytext, yy_line_number, yy_begin_column); return literal;}

{digit}+				{rl_literal_enter (yylval, yytext, yy_line_number, yy_begin_column); return literal;}

"'"{car_repr}"'"			{rl_literal_caracter (yylval, yytext, yy_line_number, yy_begin_column); return literal;}

-- caracters no representables
[\t\n \r]+				{null;}

-- comentari
"--"[^\n]*				{null;}

-- qualsevol altra cosa
. 					{return Error;}

%%

with lexic_io; use lexic_io; 
with lexic_dfa; use lexic_dfa;
with d_token; use d_token;
package a_lexic is 
	function yylex return token;
end a_lexic;
package body a_lexic is
##
end a_lexic;
