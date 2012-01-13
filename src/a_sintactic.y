%token Error
%token end_of_Input
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

%left pc_or pc_and
%left pc_not
%nonassoc s_major s_majorigual s_menor s_menorigual s_diferent s_igual s_assignacio
%left s_mes s_menys
%left menys_unitari
%left s_per s_divisio pc_mod

%%

PROGRAMA:
     DECL_PROC
     {rs_programa ($$, $1);}
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
     {rs_params ($$, $2);}
  |  {rs_params ($$);}
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
     {rs_mode_in ($$);}
  |  pc_in pc_out
     {rs_mode_out ($$);}
  ;

DECLARACIONS:
     DECLARACIONS DECLARACIO
     {rs_declaracions ($$, $1, $2);}
  |  {rs_declaracions ($$);}
  ;

DECLARACIO:
     DECL_CONST
     {rs_declaracio ($$, $1);}
  |  DECL_VAR
     {rs_declaracio ($$, $1);}
  |  DECL_TIPUS
     {rs_declaracio ($$, $1);}
  |  DECL_PROC
     {rs_declaracio ($$, $1);}
  ;

DECL_CONST:
     L_ID s_dospunts pc_constant id s_assignacio VALOR s_punticoma
     {rs_decl_const ($$, $1, $4, $6);}
  ;

VALOR:
     literal
     {rs_valor_literal ($$, $1);}
  |  s_menys literal
     {rs_valor_s_menys ($$, $2);}
  |  id
     {rs_valor_id ($$, $1);}
  |  s_menys id
     {rs_valor_s_menys_id ($$, $2);}
  ;

DECL_VAR:
     L_ID s_dospunts id s_punticoma
     {rs_decl_var ($$, $1, $3);}
  ;

L_ID:
     L_ID s_coma id
     {rs_l_id ($$, $1, $3);}
  |  id
     {rs_l_id ($$, $1);}
  ;

DECL_TIPUS:
     DECL_SUBRANG
     {rs_decl_tipus_subrang ($$, $1);}
  |  DECL_ARRAY
     {rs_decl_tipus_array ($$, $1);}
  |  DECL_RECORD
     {rs_decl_tipus_record ($$, $1);}
  ;

DECL_SUBRANG:
     pc_type id pc_is pc_new id pc_range VALOR s_puntpunt VALOR s_punticoma
     {rs_decl_subrang ($$, $2, $5, $7, $9);}
  ;

DECL_ARRAY:
     pc_type id pc_is pc_array s_parentesiobert L_ID s_parentesitancat pc_of id s_punticoma
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
     {rs_sentencies ($$, $1, $2);}
  |  SENTENCIA
     {rs_sentencia ($$, $1);}
  ;

SENTENCIA:
     CONDICIONAL
     {rs_sent_cond ($$, $1);}
  |  ASSIGNACIO
     {rs_sent_assig ($$, $1);}
  |  ITERACIO
     {rs_sent_iter ($$, $1);}
  |  CRIDA_PROCEDIMENT
     {rs_sent_proc ($$, $1);}
  ;

CONDICIONAL:
     pc_if E pc_then SENTENCIES pc_end pc_if s_punticoma
     {rs_cond ($$, $2, $4);}
  |  pc_if E pc_then SENTENCIES pc_else SENTENCIES pc_end pc_if s_punticoma
     {rs_cond ($$, $2, $4, $6);}
  ;

ASSIGNACIO:
     REF s_assignacio E s_punticoma
     {rs_assignacio ($$, $1, $3);}
  ;

REF:
     id QUALIFICADORS
     {rs_ref ($$, $1, $2);}
  ;

QUALIFICADORS:
     QUALIFICADORS QUALIFICADOR
     {rs_qualifs ($$, $1, $2);}
  |  {rs_qualifs ($$);}
  ;

QUALIFICADOR:
     s_punt id
     {rs_qualif_simple ($$, $2);}
  |  s_parentesiobert L_E s_parentesitancat
     {rs_qualif_complex ($$, $2);}
  ;

L_E:
     L_E s_coma E
     {rs_l_e ($$, $1, $3);}
  |  E
     {rs_l_e ($$, $1);}
  ;

ITERACIO:
     pc_while E pc_loop SENTENCIES pc_end pc_loop s_punticoma
     {rs_iteracio ($$, $2, $4);}
  ;

CRIDA_PROCEDIMENT:
     REF s_punticoma
     {rs_crida_procediment ($$, $1);}
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
  |  s_menys E %prec menys_unitari
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
end a_sintactic;

with Ada.text_io, a_sintactic_tokens, a_sintactic_shift_reduce, a_sintactic_goto, a_lexic;
use Ada.text_io, a_sintactic_tokens, a_sintactic_shift_reduce, a_sintactic_goto, a_lexic;

package body a_sintactic is
##
end a_sintactic;