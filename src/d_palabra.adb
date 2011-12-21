package body d_palabra is
   ---------------------------------
   -- DEFINICIO DE PROCEDIMENTS: --
   ---------------------------------
   procedure leer_palabra(b: out String;
                          F: in out File_type;
                          l:out Integer;
                          c:in out Character) is
   begin
      l := 1;
      while c /= ' ' and c /= Ada.Characters.Latin_1.HT and not End_Of_Line(F) loop
         b(l):= c;
         l:= l + 1;
         Get(F, c);
      end loop;
      if c = Ada.Characters.Latin_1.HT or End_Of_Line(F) then
         b(l):= c;
         l := l + 1;
      end if;
   end leer_palabra;

   procedure saltar_espacios(F: in out File_type; c: out Character) is
   begin
      Get (F,c);
      while c = ' ' or c = Ada.Characters.Latin_1.HT loop
         Get (F, c);
      end loop;
   end saltar_espacios;

end d_palabra;
