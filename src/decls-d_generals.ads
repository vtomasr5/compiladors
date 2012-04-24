package decls.d_generals is
   pragma Pure;
   ------------------------------
   -- declaracio de constants: --
   ------------------------------
   max_str: constant integer := 25000;
   max_noms: constant integer := 1005;
   max_prof: constant integer := 20;
   max_num_var: constant integer := 500;
   max_num_proc: constant integer := 100;
   long_max_str: constant integer := 100;

   ---------------------------
   -- declaracio de tipus:  --
   ---------------------------
   type id_nom is new natural range 0..max_noms;
   type id_str is new natural range 1..max_str;
   id_nul: constant id_nom := 0;

   type valor is new integer;
   type desplacament is new integer;

   type num_var is new integer range 0..max_num_var;
   type num_proc is new integer range 0..max_num_proc;

   subtype etiqueta is string (1..10);
   enula : constant etiqueta := ("");

   Tam_Int: constant Desplacament := 4;
   Tam_Bool: constant Desplacament := 4;
   Tam_Car: constant Desplacament := 4;

end decls.d_generals;
