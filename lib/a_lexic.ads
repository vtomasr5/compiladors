package a_lexic is
   type Token is (End_of_Input, Error, pc_and, pc_array, pc_begin, pc_constant,
                  pc_else, pc_end, pc_in, pc_is, pc_loop, pc_mod, pc_new,
                  pc_not, pc_null, pc_of, pc_or, pc_out, pc_procedure,
                  pc_record, pc_range, pc_return, pc_then, pc_type, pc_while,
                  s_dospunts, s_punticoma, s_parantesisobert, s_parentesitancat,
                  s_mes, s_menys, s_per, s_divisio, s_igual, s_menor, s_major,
                  s_menorigual, s_majorigual, s_coma, s_punt, s_assignacio,
                  s_diferent, s_puntpunt, id, literal);

   function yylex return token;
end a_lexic;



