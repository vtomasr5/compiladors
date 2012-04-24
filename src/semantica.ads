with decls.d_taulanoms, decls.d_taulasimbols, decls.d_generals, decls.d_pila, decls.d_c3a, decls.d_descripcio;
use decls.d_taulanoms, decls.d_taulasimbols, decls.d_generals, decls.d_c3a, decls.d_descripcio;

package Semantica is

   Tn: t_noms;
   Ts: taula_simbols;
   tv: tVariables;
   tp: tProcediments;
   nv: num_var;
   Np: Num_Proc;
   nc: integer;

   package d_pilaproc is new decls.d_pila(num_proc);
   use d_pilaproc;

   pilaProc: d_pilaProc.pila;

   package d_pilapar is new decls.d_pila(infoparam);
   use d_pilapar;

   Pilapar: D_Pilapar.Pila;
   error_comp: boolean;

end semantica;
