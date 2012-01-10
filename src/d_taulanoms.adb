wiTh Ada.TexT_Io; use Ada.TexT_Io;
wiTh d_taulanoms; use d_taulanoms;

package body d_taulanoms is

   FDC: constant Character := Ascii.Nul;

   -- Hashing
   function Hashing (Nom : in String) return Integer is
      hash: Integer := 0;
   begin
      for I in Nom'Range loop
         hash := (hash + ( I * Character'Pos(Nom(I)) ** I ) ) ;
      end loop;

      return hash mod MAX_NOMS;
   end Hashing;

   -- T_buida
   procedure T_buida (tn: out t_noms) is
   begin
      for I in t_disp'First.. t_disp'Last loop
         tn.td(I) := 0;
      end loop;
      -- init indices para las tablas --
      tn.Index_tid := id_nom'First;
      tn.Index_tcar := id_str'First;
   end T_buida;

   -- Afegir_tc
   procedure Afegir_tc(Nom: in String; Tc: in out t_car; Pos: in out id_str) is
   begin
      for I in Nom'First..Nom'Last loop
         Tc (Pos) := Nom(I);
         Pos := Pos + 1;
      end loop;
      Tc (Pos) := FDC;
      Pos := Pos + 1;
   end Afegir_tc;

   -- Existeix
   function Existeix(Nom: in String; Tc: in t_car; valor: in id_str) return Boolean is
      pos: id_str;
      i_string: integer; -- indice para recorrer el string
   begin
      if valor /=0 then
         i_string := Nom'first;
         pos := valor;
         while Tc(pos) /= Ascii.Nul and i_string <= Nom'last loop
            if Nom (i_string) /= Tc (pos) then
               return False;
            end if;
            pos := pos + 1;
            i_string := i_string + 1;
         end loop;
         if Tc(pos) = FDC and i_string = Nom'last+1 then
            return True;
         end if;
      end if;
      return False;
   end Existeix;

   -- posa
   procedure posa(tn: in out t_noms; Nom: in String; id_out: out id_nom) is
      hash: id_nom;
      valor_td: id_nom;
      td: t_disp renames tn.td;
      tc: t_car renames tn.tc;
      tid: t_ident renames tn.tid;
      index_tid: Id_Nom renames tn.index_tid;
      index_tcar: id_str renames tn.index_tcar;
   begin
      hash := id_nom (Hashing (Nom));
      valor_td := Td (hash);
      while valor_td /= 0 and not Existeix(Nom,Tc,Tid(valor_td).Ptr_t_car) loop
         valor_td := Tid(valor_td).seg;
      end loop;

      if valor_td /= 0 then
         id_out := valor_td;
      else
         Index_tid := Index_tid +1;
         Tid(Index_tid).seg := Td (Hash);
         Td (hash) := Index_tid;
         Id_out := Index_tid;
         Tid(Index_tid).Ptr_t_car:=Index_tcar;
         Afegir_tc (Nom, Tc, Index_tcar);
      end if;
   end posa;

   -- Consultar
   function Consultar(tn: in t_noms; Id_tid: in id_nom) return String is
      Pos_Tc: id_str;
      Tc: t_car renames tn.Tc;
      Tid: t_ident renames tn.Tid;
   begin
      Pos_Tc := Tid(Id_tid).Ptr_t_car;
      while Tc(Pos_Tc) /= FDC loop
         Pos_Tc := Pos_Tc + 1;
      end loop;
      return String(Tc (Tid(Id_tid).Ptr_t_car..Pos_Tc-1));
   end Consultar;

   -- Test
   procedure Test (tn: in t_noms) is
   begin
      Put("---- TD --------");new_line;
      for I in t_disp'First.. t_disp'Last loop
         if (tn.Td(I) /= 0) then
            Put (id_nom'image(I)
                 & ": " & id_nom'image(tn.Td(I))
                 & " " & Consultar(tn,tn.Td(I)));
            new_line;
         end if;
      end loop;

      Put("---- TiD --------");new_line;
      for I in 1.. Integer(tn.index_tid) loop
         Put (integer'image(I)
              & ": " & id_str'image( tn.tid(id_nom(i)).ptr_t_car) & " seg: " & id_nom'image( tn.tid(id_nom(i)).seg) );
         new_line;
      end loop;

      Put("---- TC --------");new_line;
      for I in 1..Integer(tn.index_tcar)-1 loop
         put (character'image(tn.Tc(id_str(I))));
         if (tn.Tc(id_str(I)) = Ascii.Nul) then
            new_line;
         end if;
      end loop;

      Put("---- FIN TEST--------");new_line;
   end Test;

   -- Posa_str
   procedure Posa_Str (T_N: in out T_Noms; Pos_Tc: out id_str; Token: in String) is
      Tc: T_Car renames T_N.Tc;
      Max_Valor_car: Id_str renames T_N.index_tcar;
   begin
      Pos_Tc := Max_Valor_Car;
      Afegir_tc (Token(Token'First+1..Token'Last-1), Tc, Max_Valor_Car);
   end Posa_Str;

   -- Consultar_str
   function Consultar_Str (T_N: in T_Noms; Pos_Tc: in id_str) return String is
      Tc: T_Car renames T_N.Tc;
      index: id_str;
   begin
      index := pos_tc;
      while Tc(Pos_Tc) /= FDC loop
         index := index + 1;
      end loop;
      return String (Tc (pos_tc..index-1));
   end Consultar_Str;

end d_taulanoms;
