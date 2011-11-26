with d_generals; use d_generals;

package d_taulanoms is
   --------------------------
   -- DECLARACIO DE TIPUS: --
   --------------------------
   type t_noms is limited private;
   ------------------------------------------
   -- DECLARACIO DE PROCEDIMENTS/FUNCIONS: --
   ------------------------------------------
   procedure Test (tn: in t_noms); -- hay que quitarlo, pero por ahora lo dejamos
   procedure T_buida (tn: out t_noms);
   procedure posa (tn: in out t_noms; Nom: in String; id_out: out id_nom);
   function Consultar (tn: in t_noms; id_tid: in id_nom) return String;

private
   -- DEFINICIO DE TIPUS--
   type t_id is record
      seg: id_nom;
      ptr_t_car: id_str;
   end record;
   type t_car is array (id_str) of character;
   type t_disp is array (id_nom) of id_nom;
   type t_ident is array (id_nom) of t_id;

   -- DECLARACIO DE TAULA DE NOMS--
   type t_noms is record
      tc: t_car;
      td: t_disp;
      tid: t_ident;
      index_tid: id_nom;
      index_tcar: id_str;
   end record;

end d_taulanoms;
