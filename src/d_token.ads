with d_generals; use d_generals;
with d_taulanoms; use d_taulanoms;

package d_Token is
   type Token is (End_of_Input, Error, pc_and, pc_array, pc_begin, pc_constant,
                  pc_else, pc_end, pc_in, pc_is, pc_loop, pc_mod, pc_new,
                  pc_not, pc_null, pc_of, pc_or, pc_out, pc_procedure,
                  pc_record, pc_range, pc_return, pc_then, pc_type, pc_while,
                  s_dospunts, s_punticoma, s_parantesisobert, s_parentesitancat,
                  s_mes, s_menys, s_per, s_divisio, s_igual, s_menor, s_major,
                  s_menorigual, s_majorigual, s_coma, s_punt, s_assignacio,
                  s_diferent, s_puntpunt, id, literal);
   -- NO PRINT
   --     type Tipus_Atribut is (A_Ident, A_Lit, A_Atom);
   --
   --     type Posicio is record
   --        Lin, Col: Natural;
   --     end record;
   --
   --     type valor is new Integer;
   --
   --     type Atribut (Ta: Tipus_Atribut:= A_Atom) is record
   --        P: Posicio;
   --        case Ta is
   --           when A_Ident => Id: id_nom;
   --           when A_Lit => Ts: Tipus_Subj; Vl:valor;
   --           when A_Atom => null;
   --        end case;
   --     end record;
   --
   --     procedure Rl_Identificador (A: out atribut; Nom: in String; L,C: in Natural);
   --     procedure Rl_literal_string (A: out atribut; Nom: in String; L,C: in Natural);
   --     procedure Rl_literal_caracter (A: out atribut; Nom: in String; L,C: in Natural);
   --     procedure Rl_literal_enter (A: out atribut; Nom: in String; L,C: in Natural);
   --     procedure Rl_Atom (A: out atribut; L,C: in Natural);
   --
   --     A: Atribut;
   --  private
   --     t_n: t_noms;
end d_Token;
