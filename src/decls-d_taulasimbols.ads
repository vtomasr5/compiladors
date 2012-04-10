with decls.d_generals, decls.d_descripcio;
use decls.d_generals, decls.d_descripcio;

package decls.d_taulasimbols is
   pragma pure;

   type index_expansio is private;

   type taula_simbols is limited private;

   procedure tbuida(ts: out taula_simbols);
   procedure posa (ts: in out taula_simbols; id: in id_nom; d: in descripcio; error: out boolean);
   function consultar (ts: in taula_simbols; id: in id_nom) return descripcio;

   procedure entra_bloc (ts: in out taula_simbols);
   procedure surt_bloc (ts: in out taula_simbols);

   procedure posa_camp (ts: in out taula_simbols; idr,idc: in id_nom; dc: in descripcio; error: out boolean);
   function consulta_camp (ts: in taula_simbols; idr, idc: in id_nom) return descripcio;
   procedure actualizar(ts: in out taula_simbols; id: in id_nom; d: in descripcio);

   procedure posa_index (ts: in out taula_simbols; ida: in id_nom; di: in descripcio);
   procedure primer_index (ts: in taula_simbols; ida: in id_nom; it: out index_expansio);
   procedure seguent_index (ts: in taula_simbols; it: in out index_expansio);
   function es_valid (it: in index_expansio) return boolean;
   procedure consulta_index (ts: in taula_simbols; it: in index_expansio; di: out descripcio);

   procedure posar_paramf (ts: in out taula_simbols; idproc, idparf: in id_nom; dparf: in descripcio; error: out boolean);
   procedure primer_paramf (ts: in taula_simbols; idproc: in id_nom; it: out index_expansio);
   procedure seguent_paramf (ts: in taula_simbols; it: in out index_expansio);
   procedure consulta_paramf (ts: in taula_simbols; it: in index_expansio; idparf: out id_nom; dparf: out descripcio);

   error_record, error_array, error_proc: exception;

private
   type niv_prof;

   type niv_prof is new integer range -1..max_prof;

   type index_expansio is new integer range 0..max_noms*max_prof;

   type bloc_tdescr is record
      prof: niv_prof;
      d: descripcio;
      s: index_expansio;
   end record;

   type taula_descripcio is array (id_nom range 1..id_nom'last) of bloc_tdescr;

   type taula_ambits is array (0..niv_prof'last) of index_expansio;

   type bloc_texp is record
      prof: niv_prof;
      d: descripcio;
      id: id_nom;
      s: index_expansio;
   end record;

   type taula_expansio is array (1..index_expansio'last) of bloc_texp;

   type taula_simbols is record
      td: taula_descripcio;
      te: taula_expansio;
      ta: taula_ambits;
      prof: niv_prof;
   end record;

end decls.d_taulasimbols;
