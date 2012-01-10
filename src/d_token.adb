with d_taulanoms; use d_taulanoms;
with d_generals; use d_generals;
with Ada.Text_Io; use Ada.Text_Io;
with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
-- NO PRINT
package body D_Token is

   procedure Rl_Identificador (A:out atribut; Nom: in String; L,C: in Natural) is
      Id: id_nom;
      p: posicio;
   begin
      p :=(l,c);
      Posa (t_n,Nom,Id);
      A:= (A_Ident, P, Id);
      Put (Nom);
      Put (L);
      put (c);
      Put (Integer (Id));
      new_line;
   end Rl_Identificador;

   procedure Rl_Literal_String (A:out atribut; Nom: in String; L,C: in Natural) is
      Id: id_str;
      p: posicio;
   begin
      p :=(l,c);
      Posa_Str (t_n, Id, Nom (nom'first+1..nom'last-1));
      A:= (A_Lit, P, Ts_String, Valor (Id));
      Put (Nom (nom'first+1..nom'last-1));
      Put (L);
      put (c);
      Put (Integer (Id));
      new_line;
   end Rl_Literal_String;

   procedure Rl_Literal_Caracter (A:out atribut; Nom: in String; L,C: in Natural) is
      p: posicio;
   begin
      p :=(l,c);
      A:= (A_Lit, P, Ts_Caracter, Valor (Character'Pos(Nom(Nom'First+1))));
      Put (Nom (Nom'First+1));
      Put (L);
      put (c);
      Put (Character'Pos(Nom(Nom'First+1)));
      new_line;
   end Rl_Literal_Caracter;

   procedure Rl_Literal_Enter (A:out atribut; Nom: in String; L,C: in Natural) is
      p: posicio;
   begin
      p :=(l,c);
      A:= (A_Lit, P, Ts_Enter, Valor (Integer'Value(Nom)));
      Put (Nom);
      Put (L);
      put (c);
      Put (integer (Valor (Integer'Value(Nom))));
      new_line;
   end Rl_Literal_Enter;


   procedure Rl_Atom (A:out atribut; L,C: in Natural) is
      p: posicio;
   begin
      p :=(l,c);
      A:= (A_Atom, P);
      put ("atom");
      Put (L);
      Put (C);
      new_line;
   end Rl_Atom;

begin
   T_buida(t_n);
end d_token;
