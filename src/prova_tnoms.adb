with d_Taulanoms; use d_Taulanoms;
with Ada.TexT_Io; use Ada.TexT_Io;
with d_generals; use d_generals;
with d_palabra; use d_palabra;

procedure prova_Tnoms is
   F: File_Type;
   buffer: String (1 .. 50) := (others => ' ');
   tn: t_noms;
   car: Character := '#';
   lenght: Integer;
   id_out: id_nom;
begin
   t_buida(tn);
   Open(F, in_File, "prova_tnoms.txt");
   while not End_Of_File(F) loop
      saltar_espacios(F, car);
      leer_palabra(buffer, F, lenght,car);
      posa(tn, buffer(1..lenght - 1), id_out);
   end loop;
   Close(F);
   -- Test ---
   Test(Tn);
end prova_Tnoms;
