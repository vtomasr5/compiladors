generic
   type item is private;

package Decls.D_Pila is

   type pila is limited private;

   procedure crearPila(p: out pila);

   procedure empilar(p: in out pila; x: in item);

   procedure desempilar(p: in out pila);

   function cim(p: in pila) return item;

   function estaBuida(p: in pila) return boolean;

   pbuida: exception;

private
   type indPila is new integer range 0..100;

   ipNul : constant indPila := 0;

   type tLlista is array (indPila) of item;

   type pila is record
      llista: tLlista;
      cim: indPila;
   end record;

end decls.d_pila;
