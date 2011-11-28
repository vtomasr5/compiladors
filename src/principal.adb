with a_lexic; use a_lexic;
with lexic_io; use lexic_io;
with d_token; use d_token;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;

procedure Principal is
   Tk: Token := Error;
begin
   Open_Input("../tests/prova_tnoms.txt");
   while tk /= End_of_Input loop
      Tk := Yylex;
   end loop;
   Close_Input;
end Principal;
