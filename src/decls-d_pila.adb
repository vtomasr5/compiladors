package body decls.d_pila is

   procedure crearPila(p: out pila) is
   begin
      p.cim := ipNul;
   end crearPila;

   procedure empilar(p: in out pila; x: in item) is
   begin
      p.cim := p.cim + 1;
      p.llista(p.cim) := x;
   end empilar;

   procedure desempilar(p: in out pila) is
   begin
      if not estabuida(p) then
         p.cim := p.cim - 1;
      end if;
   end desempilar;

   function cim(p: in pila) return item is
   begin
      if not estabuida(p) then
         return p.llista(p.cim); 
      else
         raise pbuida;
      end if;
   end cim;

   function estabuida(p: in pila) return boolean is
   begin
      return p.cim = ipNul;
   end estabuida;

end decls.d_pila;
