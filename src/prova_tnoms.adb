with Ada.Text_IO; use Ada.Text_IO;
with d_taulanoms; use d_taulanoms;
with d_generals; use d_generals;

procedure prova_tnoms is
   id1, id2, id3, id4, id5, id6, id7, id8 : id_nom;
   t_n : t_noms;
begin
   t_buida(t_n);

   posa(t_n, "procedure", id1);
   put(id_nom'image(id1));new_line;
   posa(t_n, "quicksort", id2);
   put(id_nom'image(id2));new_line;
   posa(t_n, "is", id3);
   put(id_nom'image(id3));new_line;
   posa(t_n, "res", id4);
   put(id_nom'image(id4));new_line;
   posa(t_n, "integer", id5);
   put(id_nom'image(id5));new_line;
   posa(t_n, "begin", id6);
   put(id_nom'image(id6));new_line;
   posa(t_n, "quicksort", id7);
   put(id_nom'image(id7));new_line;
   posa(t_n, "end", id8);
   put(id_nom'image(id8));new_line;

   put(consultar(t_n, id1));new_line;
   put(consultar(t_n, id2));new_line;
   put(consultar(t_n, id3));new_line;
   put(consultar(t_n, id4));new_line;
   put(consultar(t_n, id5));new_line;
   put(consultar(t_n, id6));new_line;
   put(consultar(t_n, id7));new_line;
   put(consultar(t_n, id8));new_line;
end prova_tnoms;
