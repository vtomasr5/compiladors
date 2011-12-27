with d_generals, d_descripcio;
use d_generals, d_descripcio;
package d_taulasimbols is
   pragma Pure;

   --type Niv_Prof is private;
   type Niv_Prof is new Integer range -1..Max_Prof;

   type index_expansio is private;

   type taula_simbols is private;

   procedure tbuida(ts : out taula_simbols);
   procedure posa (ts : in out taula_simbols; id : in id_nom; d : in descripcio; error : out boolean);
   function consultar (ts : in taula_simbols; id : in id_nom) return descripcio;

   procedure entra_bloc (ts : in out taula_simbols);
   procedure surt_bloc (ts : in out taula_simbols);

   procedure posa_camp (ts : in out taula_simbols; idr,idc: in id_nom; dc: in descripcio; error: out boolean);
   function Consulta_Camp (Ts: in Taula_Simbols; Idr, Idc: in Id_Nom) return Descripcio;
   procedure actualizar(ts: in out taula_simbols; id: in id_nom; d: in descripcio);

   procedure posa_index (ts: in out taula_simbols; ida: in id_nom; di: in descripcio);
   procedure primer_index (ts: in taula_simbols; ida: in id_nom; it: out index_expansio);
   procedure seg�ent_index (ts: in taula_simbols; it: in out index_expansio);
   function es_valid (it: in index_expansio) return boolean;
   procedure consulta_index (ts: in taula_simbols; it: in index_expansio; di: out descripcio);

   procedure posar_paramf (ts: in out taula_simbols; idproc, idparf: in id_nom; dparf: in descripcio; error: out boolean);
   procedure primer_paramf (ts: in taula_simbols; idproc: in id_nom; it: out index_expansio);
   procedure seg�ent_paramf (ts: in taula_simbols; it: in out index_expansio);
   procedure consulta_paramf (ts: in taula_simbols; it: in index_expansio; idparf: out id_nom; dparf: out descripcio);

   error_record, error_array, error_proc : exception;

private

   type index_expansio is new integer range 0..max_id*max_prof;

   --type Niv_Prof is new Integer range -1..Max_Prof;

   type bloc_tdescr is record
      prof : niv_prof;
      d : descripcio;
      s: index_expansio;
   end record;

   type taula_descripcio is array (id_nom range 1..id_nom'last) of bloc_tdescr;

   type taula_ambits is array (0..niv_prof'last) of index_expansio;

   type bloc_texp is record
      prof: niv_prof;
      d: descripcio;
      id: id_nom;
      s : index_expansio;
   end record;

   type taula_expansio is array (1..index_expansio'last) of bloc_texp;

   type taula_simbols is record
      td: taula_descripcio;
      te: taula_expansio;
      ta: taula_ambits;
      prof: niv_prof;
   end record;

end d_taulasimbols;