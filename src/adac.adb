with lexic_io; use lexic_io;
with Ada.Text_Io; use Ada.Text_Io;
with Ada.IO_Exceptions;

-- Punt d'inici del compilador Adac
procedure Adac is
   nom: string(1..50);
   Length: Integer;
   nom_introduit: boolean := false;
begin
   new_line;
   put_line(">>>>>>>>>> ADA COMPILER <<<<<<<<<<");
   New_Line;
   while Nom_Introduit = False loop
      put("Nom del fitxer (.txt): ");
      get_line(nom, length);
      if (length-3 < 1) or (length > 3 and then (nom(length - 3..length) /= ".txt")) then
         new_line;
         put_line("ERROR: Nom de fitxer incorrecte, ha d'acabar en "".txt""!");
         new_line;
      else
         Nom_Introduit := True;
      end if;
   end loop;

   Open_Input(nom(1..length));
   -- accions
   put("Pareix que tot va bé :)");
   Close_Input;
exception
   when ada.IO_Exceptions.Name_Error =>
      new_line;
      put_line("ERROR: El fitxer no existeix!");
      Adac;
end Adac;
