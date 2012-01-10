with d_taulasimbols, d_generals, ada.Text_IO,ada.Integer_Text_IO, d_descripcio;
use d_taulasimbols, d_generals, ada.Text_IO,ada.Integer_Text_IO, d_descripcio;

procedure prova_tsimbols is
   Ts: taula_simbols;
   E: Boolean;
   d, d2, d3, d4, d5: Descripcio;
   It: Index_Expansio;
   Idparf: Id_Nom;
begin
   Tbuida (Ts);
   d:= (dtipus, (ts_arr, desplacament(4), id_nom(1)));
   d2:= (Dvar, Id_Nom(2), Num_Var(35));
   d3:= (Dtipus,(Ts_Rec, Desplacament(4)));
   d4:= (dproc, num_proc(39));

   Entra_bloc(ts);
   Posa(Ts, Id_Nom(3), D2, E);
   if E then put("error1"); end if;
   d5:= Consultar (Ts, Id_Nom(3));
   Put ("Var tipus: ");
   Put (Integer (D5.Dvar_Tp));
   new_line;
   Put ("Var valor: ");
   Put (Integer (D5.Dvar_Nv));
   new_line;

   Posa(Ts, Id_Nom(4), D3, E);
   if E then put("error2"); end if;
   Posa_camp (Ts, Id_Nom(4), id_nom(6), D2, E);
   if E then put("error3"); end if;
   Posa_camp (Ts, Id_Nom(4), id_nom(7), D2, E);
   if E then put("error4"); end if;
   d5:= consulta_camp (Ts, Id_Nom(4), id_nom(7));
   Put (integer (D5.Dvar_Tp));
   Put (Integer (D5.Dvar_Nv));

   Posa(Ts, Id_Nom(8), D, E);
   if E then put("error5"); end if;
   Posa_Index (Ts, Id_Nom(8), D2);
   Primer_Index (Ts, Id_Nom(8), It);
   consulta_index (ts, it, d5);
   Put (integer (D5.Dvar_Tp));
   Put (Integer (D5.Dvar_Nv));

   posa (ts, id_nom(5), d4, E);
   posar_paramf(ts,id_nom(5), id_nom(11), d2, e);
   if E then put("error6"); end if;
   posar_paramf(ts,id_nom(5), id_nom(12), d2, e);
   if E then put("error7"); end if;
   primer_paramf(ts, id_nom(5), it);
   Seguent_Paramf(Ts, It);
   consulta_paramf (ts, it, idparf, d5);
   Put(Integer(Idparf));
   put(integer(d5.dvar_tp));

   -- Imprimir les taules
   --     Put_Line("");
   --     put_line("##### Td #####");
   --     for i in 1..5 loop
   --        put("Descripció: ");
   --        put(tipus_descripcio'pos(ts.td(id_nom(i)).d.td));
   --        Put_Line("");
   --        put("Profunditat: ");
   --        put(integer(ts.td(id_nom(i)).prof));
   --        Put_Line("");
   --        put("Següent: ");
   --        put(integer(ts.td(id_nom(i)).s));
   --        Put_Line("");
   --        put_line("------------");
   --     end loop;
   --
   --     put_line("##### Te #####");
   --
   --     for i in 1..ts.ta(ts.prof) loop
   --        put("Idnom: ");
   --        put(integer(ts.te(index_expansio(i)).id));
   --        Put_Line("");
   --        put("Profunditat: ");
   --        put(integer(ts.te(index_expansio(i)).prof));
   --        Put_Line("");
   --        put("Descripció: ");
   --        put(tipus_descripcio'pos(ts.te(index_expansio(i)).d.td));
   --        Put_Line("");
   --        put("Següent: ");
   --        put(integer(ts.te(index_expansio(i)).s));
   --        put_line("");
   --        put_line("------------");
   --     end loop;
   --
   --     put_line("##### Ta #####");
   --
   --     for i in 1..ts.prof loop
   --        put("Ambit:");
   --        put(integer(ts.ta(niv_prof(i))));
   --        put_line("");
   --        put_line("------------");
   --     end loop;
   surt_bloc(ts);
exception
   when CONSTRAINT_ERROR => put("Error");
end prova_tsimbols;
