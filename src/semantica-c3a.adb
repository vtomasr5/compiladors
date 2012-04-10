package body semantica.c3a is

   procedure tancarC3a is
   begin
      tancar(semantica.gcodi.c3a);
      tancar(c3at);
   end tancarC3a;

   procedure preparaC3a(nom: in string) is
   begin
      obrir(nom, semantica.gcodi.c3a);
      Obrir(Nom, C3at);
   end preparaC3a;

   procedure genera(c: in elementc3a) is
   begin
      generac3a(c,semantica.gcodi.c3a);
      generac3at(c,c3at);
   end genera;

   function novaEtiqueta return etiqueta is
      e: etiqueta;
   begin
      num_Etiq := num_Etiq + 1;
      e := ('E', 't',others => ascii.nul);
      for i in 2..integer'image(num_Etiq)'length loop
         e(i+1) := integer'image(num_Etiq)(i);
      end loop;
      return e;
   end novaEtiqueta;

   function novaConst(val: in valor; tsub: in t_descr_tipus) return num_Var is
      ivar: infovar;
   begin
      for i in num_var'first+1..nv loop
         ivar := tv(i);
         if ivar.mode = mconst and then ivar.val = val then
            return i;
         end if;
      end loop;
      nc := nc + 1;
      Ivar:= (Mconst, Id_Nul, False, val, tsub, nc);
      nv := nv + 1;
      tv(nv) := iVar;
      return nv;
   end novaConst;

   function novaVar return num_Var is
      ivar: infovar;
   begin
      ivar:= (mvar, id_nul, false, 0, 4, cim(pilaProc));
      nv := nv + 1;
      tv(nv) := iVar;
      return nv;
   end novaVar;

end semantica.c3a;
