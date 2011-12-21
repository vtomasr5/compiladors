with d_taulanoms; use d_taulanoms;
with d_generals; use d_generals;
with Ada.Text_Io; use Ada.Text_Io;
with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;

package body D_Token is

   -- rl_identificador
   procedure Rl_Identificador (A: out atribut; Nom: in String; L,C: in Natural) is
      Id: id_nom;
      p: posicio;
   begin
      p:= (l, c);
      Posa (t_n, Nom, Id);
      A:= (A_Ident, P, Id);
      new_line;
      put ("IDENTIFICADOR");
      new_line;
      put ("nom: ");
      Put (Nom);
      new_line;
      put ("lin: ");
      Put (L);
      new_line;
      put ("col: ");
      put (c);
      new_line;
      put ("id: ");
      Put (Integer (Id));
      new_line;
   end Rl_Identificador;

   -- rl_literal_string
   procedure Rl_Literal_String (A: out atribut; Nom: in String; L,C: in Natural) is
      Id: id_str;
      p: posicio;
   begin
      p:= (l, c);
      Posa_Str (t_n, Id, Nom (nom'first+1..nom'last-1));
      A:= (A_Lit, P, Ts_String, Valor (Id));
      new_line;
      put ("LITERAL_STRING");
      new_line;
      put ("nom: ");
      Put (Nom (nom'first+1..nom'last-1));
      new_line;
      put ("lin: ");
      Put (L);
      new_line;
      put ("col: ");
      put (c);
      new_line;
      put ("id: ");
      Put (Integer (Id));
      new_line;
   end Rl_Literal_String;

   -- rl_literal_caracter
   procedure Rl_Literal_Caracter (A: out atribut; Nom: in String; L,C: in Natural) is
      p: posicio;
   begin
      p:= (l, c);
      A:= (A_Lit, P, Ts_Caracter, Valor (Character'Pos(Nom(Nom'First+1))));
      new_line;
      put ("LITERAL_CARACTER");
      new_line;
      put ("nom: ");
      Put (Nom (Nom'First+1));
      new_line;
      put ("lin: ");
      Put (L);
      new_line;
      put ("col: ");
      put (c);
      new_line;
      put ("char: ");
      Put (Character'Pos(Nom(Nom'First+1)));
      new_line;
   end Rl_Literal_Caracter;

   -- rl_literal_enter
   procedure Rl_Literal_Enter (A: out atribut; Nom: in String; L,C: in Natural) is
      p: posicio;
   begin
      p:= (l, c);
      A:= (A_Lit, P, Ts_Enter, Valor (Integer'Value(Nom)));
      new_line;
      put ("LITERAL_ENTER");
      new_line;
      put ("nom: ");
      Put (Nom);
      new_line;
      put ("lin: ");
      Put (L);
      new_line;
      put ("col: ");
      put (c);
      new_line;
      put ("enter: ");
      Put (integer (Valor (Integer'Value(Nom))));
      new_line;
   end Rl_Literal_Enter;

   -- rl_atom
   procedure Rl_Atom (A: out atribut; L,C: in Natural) is
      p: posicio;
   begin
      p:= (l, c);
      A:= (A_Atom, P);
      new_line;
      put ("ATOM");
      new_line;
      put ("lin: ");
      Put (L);
      new_line;
      put ("col: ");
      Put (C);
      new_line;
   end Rl_Atom;

begin
   t_buida(t_n);
end d_token;
