
package d_generals is
   ------------------------------
   -- DECLARACIO DE CONSTANTS: --
   ------------------------------
   max_str: constant integer := 25000;
   max_noms: constant Integer := 1005;

   ---------------------------
   -- DECLARACIO DE TIPUS:  --
   ---------------------------
   type id_nom is new Natural range 0..max_noms;
   type id_str is new Natural range 1..max_str;
end d_generals;
