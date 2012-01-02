%token Error
%token End_Of_Input
%token id
%token literal
%token pc_procedure
%token pc_is
%token pc_begin
%token pc_end
%token pc_in
%token pc_out
%token pc_constant
%token pc_type
%token pc_array
%token pc_record
%token pc_if
%token pc_then
%token pc_else
%token pc_while
%token pc_loop
%token pc_mod
%token pc_and
%token pc_or
%token pc_new
%token pc_range
%token pc_of
%token pc_not
%token pc_null
%token pc_return
%token s_puntpunt
%token s_punticoma
%token s_parentesiobert
%token s_parentesitancat
%token s_dospunts
%token s_coma
%token s_punt
%token s_mes
%token s_menys
%token s_per
%token s_divisio
%token s_major
%token s_menor
%token s_majorigual
%token s_menorigual
%token s_diferent
%token s_igual
%token s_assignacio

%with semantica.C_arbre_sintactic;
%use semantica.C_arbre_sintactic;

%left pc_or
%left pc_and
%left pc_not
%nonassoc s_major s_majorigual s_menor s_menorigual s_diferent s_igual s_assignacio
%left s_mes s_menys
%left menysunitari
%left s_per s_divisio pc_mod

{subtype yystype is semantica.C_arbre_sintactic.pnode;}

%%

P:
     DECL_PROC   
     {rs_p ($$, $1);}
     ;

DECL_PROC:
     pc_procedure ENCAP pc_is 
        DECLARACIONS 
     pc_begin 
        SENTENCIES 
     pc_end id s_punticoma
     {rs_decl_proc ($$, $2, $4, $6, $8);}
  ;

ENCAP:
     id PARAMS
     {rs_encap ($$, $1, $2);}
  ;

PARAMS:
     s_parentesiobert L_PARAM s_parentesitancat
     {rs_cenc ($$, $2);}
  |  {rs_cenc ($$);}
  ;

L_PARAM:
     L_PARAM s_punticoma PARAM
     {rs_l_param ($$, $1, $3);}
  |  PARAM
     {rs_l_param ($$, $1);}
  ;

PARAM:
     id s_dospunts MODE id
     {rs_param ($$, $1, $3, $4);}
  ;

MODE:
     pc_in
     {rs_tipus_param1 ($$);}
  |  pc_in pc_out
     {rs_tipus_param2 ($$);}
  ;

DECLARACIONS:
     DECLARACIONS DECLARACIO
     {rs_decls ($$, $1, $2);}
  |  {rs_decls ($$);}
  ;

DECLARACIO:
     DECL_CONST
     {rs_decl1 ($$, $1);}
  |  DECL_VAR
     {rs_decl2 ($$, $1);}
  |  DECL_TIPUS
     {rs_decl3 ($$, $1);}
  |  DECL_PROC
     {rs_decl4 ($$, $1);}
  ;

DECL_CONST:
     LLISTA_ID s_dospunts pc_constant id s_assignacio VALOR s_punticoma
     {rs_decl_const ($$, $1, $4, $6);}
  ;

VALOR:
     literal
     {rs_valor1 ($$, $1);}
  |  s_menys literal
     {rs_valor2 ($$, $2);}
  |  id
     {rs_valor3 ($$, $1);}
  |  s_menys id
     {rs_valor4 ($$, $2);}
  ;

DECL_VAR:
     LLISTA_ID s_dospunts id s_punticoma
     {rs_decl_var ($$, $1, $3);}
  ;

LLISTA_ID:
     LLISTA_ID s_coma id
     {rs_lista_id ($$, $1, $3);}
  |  id
     {rs_lista_id ($$, $1);}
  ;

DECL_TIPUS:
     DECL_SUBRANG
     {rs_decl_tipus1 ($$, $1);}
  |  DECL_ARRAY
     {rs_decl_tipus2 ($$, $1);}
  |  DECL_RECORD
     {rs_decl_tipus3 ($$, $1);}
  ;

DECL_SUBRANG:
     pc_type id pc_is pc_new id pc_range VALOR s_puntpunt VALOR s_punticoma
     {rs_decl_subr ($$, $2, $5, $7, $9);}
  ;

DECL_ARRAY:
     pc_type id pc_is pc_array s_parentesiobert LLISTA_ID s_parentesitancat pc_of id s_punticoma
     {rs_decl_array ($$, $2, $6, $9);}
  ;

DECL_RECORD:
     pc_type id pc_is pc_record DECL_CAMPS pc_end pc_record s_punticoma
     {rs_decl_record ($$, $2, $5);}
  ;

DECL_CAMPS:
     DECL_CAMPS DECL_CAMP
     {rs_decl_camps ($$, $1, $2);}
  |  {rs_decl_camps ($$);}
  ;

DECL_CAMP:
     id s_dospunts id s_punticoma
     {rs_decl_camp ($$, $1, $3);}
  ;
     
SENTENCIES:
     SENTENCIES SENTENCIA
     {rs_sents ($$, $1, $2);}
  |  SENTENCIA
     {rs_sents ($$, $1);}
  ;

SENTENCIA:
     CONDICIONAL
     {rs_sent1 ($$, $1);}
  |  ASIGNACIO
     {rs_sent2 ($$, $1);}
  |  ITERACIO
     {rs_sent3 ($$, $1);}
  |  CRIDA_PROC
     {rs_sent4 ($$, $1);}
  ;

CONDICIONAL:
     pc_if E pc_then SENTENCIES pc_end pc_if s_punticoma
     {rs_cond ($$, $2, $4);}
  |  pc_if E pc_then SENTENCIES pc_else SENTENCIES pc_end pc_if s_punticoma
     {rs_cond ($$, $2, $4, $6);}
  ;

ASIGNACIO:
     REF s_assignacio E s_punticoma
     {rs_asig ($$, $1, $3);}
  ;

REF:
     id QUALIFICADORS
     {rs_ref ($$, $1, $2);}
  ;

QUALIFICADORS:
     QUALIFICADORS QUALIFICADOR
     {rs_calfs ($$, $1, $2);}
  |  {rs_calfs ($$);}
  ;

QUALIFICADOR:
     s_punt id
     {rs_calf1 ($$, $2);}
  |  s_parentesiobert LE s_parentesitancat
     {rs_calf2 ($$, $2);}
  ;

LE:
     LE s_coma E
     {rs_lexp ($$, $1, $3);}
  |  E
     {rs_lexp ($$, $1);}
  ;

ITERACIO:
     pc_while E pc_loop SENTENCIES pc_end pc_loop s_punticoma
     {rs_iterac ($$, $2, $4);}
  ;

CRIDA_PROC:
     REF s_punticoma
     {rs_llam_proc ($$, $1);} 
  ;

E:
     E s_mes E
     {rs_suma ($$, $1, $3);}
  |  E s_menys E
     {rs_resta ($$, $1, $3);}
  |  E s_per E
     {rs_mult ($$, $1, $3);}
  |  E s_divisio E
     {rs_div ($$, $1, $3);}
  |  E pc_mod E
     {rs_mod ($$, $1, $3);}
  |  E pc_and E
     {rs_and ($$, $1, $3);}
  |  E pc_or E
     {rs_or ($$, $1, $3);}
  |  E s_major E
     {rs_major ($$, $1, $3);}
  |  E s_menor E
     {rs_menor ($$, $1, $3);}
  |  E s_majorigual E
     {rs_majorig ($$, $1, $3);}
  |  E s_menorigual E
     {rs_menorig ($$, $1, $3);}
  |  E s_diferent E
     {rs_dif ($$, $1, $3);}
  |  E s_igual E
     {rs_igual ($$, $1, $3);}
  |  s_menys E %prec menysunitari
     {rs_neg ($$, $2);}
  |  s_parentesiobert E s_parentesitancat
     {rs_parent ($$, $2);}
  |  pc_not E
     {rs_not ($$, $2);}
  |  REF
     {rs_eref ($$, $1);}
  |  literal
     {rs_elit ($$, $1);}
  ;

%%

package a_sintactic is
	procedure yyparse;
	procedure yyerror (s: in string);
end a_sintactic;

with text_io, a_sintactic_tokens, a_sintactic_shift_reduce, a_sintactic_goto, a_lexic, d_arbre;
use text_io, a_sintactic_tokens, a_sintactic_shift_reduce, a_sintactic_goto, a_lexic, d_arbre;

package body a_sintactic is
##
procedure yyerror(s: in string) is
begin
   case yylval.tnd is
      when Nident => Missatge_Error_Sintactic (Yylval.Pos1.Lin, Yylval.Pos1.Col);
      when Nlit => Missatge_Error_Sintactic (Yylval.Pos2.Lin, Yylval.Pos2.Col);
      when Natom => Missatge_Erro_Sintactic (Yylval.Pos3.Lin, Yylval.Pos3.Col);
      when others => null;
   end case;
end yyerror;
end a_sintactic;