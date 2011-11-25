with Ada.Characters.Latin_1; use Ada.Characters.Latin_1;
with Ada.TexT_Io; use Ada.TexT_Io;
with d_generals; use d_generals;
package d_palabra is
   ---------------------------------
   -- DECLARACIO DE PROCEDIMENTS: --
   ---------------------------------
   procedure leer_palabra
            (b:out String;F:in out File_type;l:out Integer;c:in out Character);
   procedure saltar_espacios(F: in out File_type; c: out Character);
end d_palabra;
