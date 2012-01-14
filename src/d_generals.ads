package d_generals is
   pragma Pure;
   ------------------------------
   -- declaracio de constants: --
   ------------------------------
   max_str: constant integer := 25000;
   max_noms: constant integer := 1005;
   max_prof: constant integer := 20;
   max_num_var: constant integer := 500;
   max_num_proc: constant integer := 100;

   ---------------------------
   -- declaracio de tipus:  --
   ---------------------------
   type id_nom is new natural range 0..max_noms;
   type id_str is new natural range 1..max_str;

   type valor is new integer;
   type desplacament is new integer;

   type num_var is new integer range 0..max_num_var;
   type num_proc is new integer range 0..max_num_proc;

end d_generals;
