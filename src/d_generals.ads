package d_generals is
   ------------------------------
   -- DECLARACIO DE CONSTANTS: --
   ------------------------------
   max_str: constant integer := 25000;
   max_noms: constant Integer := 1005;
   Max_Prof: constant Integer := 20;
   Max_Num_Var: constant Integer := 500;
   Max_Num_Proc: constant Integer := 100;

   ---------------------------
   -- DECLARACIO DE TIPUS:  --
   ---------------------------
   type id_nom is new Natural range 0..max_noms;
   type id_str is new Natural range 1..max_str;

   type Valor is new Integer;
   type desplacament is new Integer;

   type num_var is new Integer range 0..Max_Num_Var;
   type Num_Proc is new Integer range 0..Max_Num_Proc;

end d_generals;
