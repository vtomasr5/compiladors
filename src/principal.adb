with a_lexic; use a_lexic;
with lexic_io; use lexic_io;
with d_token; use d_token;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with d_taulanoms; use d_taulanoms;

procedure Principal is
   Tk: Token:= Error;
begin
   t_buida(t_noms);

   posa(t_noms, "procedure", id1);
   put(id1);
   posa(t_noms, "quicksort", id2);
   put(id2);
   posa(t_noms, "is", id3);
   put(id3);
   posa(t_noms, "res", id4);
   put(id4);
   posa(t_noms, "integer", id5);
   put(id5);
   posa(t_noms, "begin", id6);
   put(id6);
   posa(t_noms, "quicksort", id7);
   put(id7);
   posa(t_noms, "end", id8);
   put(id8);

   consulta(t_noms, id1);
   consulta(t_noms, id2);
   consulta(t_noms, id3);
   consulta(t_noms, id4);
   consulta(t_noms, id5);
   consulta(t_noms, id6);
   consulta(t_noms, id7);
   consulta(t_noms, id8);
end Principal;
