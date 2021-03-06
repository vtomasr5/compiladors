package body decls.d_taulasimbols is

   procedure tbuida(ts : out taula_simbols) is
      td: taula_descripcio renames ts.td;
      ta: taula_ambits renames ts.ta;
      prof: niv_prof renames ts.prof;
   begin
      prof := 0;
      Ta(Prof) := 0;
      for i in 1..id_nom'last loop
         td(i) := (prof,(td => dnul_la),0);
      end loop;
      prof := 1;
      ta(prof) := 0;
   end tbuida;

   procedure posa (ts : in out taula_simbols; id : in id_nom;
                   d : in descripcio; error : out boolean) is
      td: taula_descripcio renames ts.td;
      te: taula_expansio renames ts.te;
      ta: taula_ambits renames ts.ta;
      prof: niv_prof renames ts.prof;
      ne: index_expansio;
   begin
      error := td(id).prof = prof;
      if not error then
         ne := Ta(Prof);
         ne := ne + 1;
         te(ne).prof := td(id).prof;
         te(ne).d := td(id).d;
         Te(Ne).Id := Id;
         ta(prof) := ne;
         td(id).d := d;
         td(id).prof := prof;
      end if;
   end posa;

   function consultar (ts: in taula_simbols; id: in id_nom) return descripcio is
      td: taula_descripcio renames ts.td;
   begin
      return td(id).d;
   end consultar;

   procedure entra_bloc (ts : in out taula_simbols) is
      ta: taula_ambits renames ts.ta;
      prof: niv_prof renames ts.prof;
   begin
      prof := prof+1;
      ta(prof) := ta(prof-1);
   end entra_bloc;

   procedure surt_bloc (ts : in out taula_simbols) is
      td: taula_descripcio renames ts.td;
      te: taula_expansio renames ts.te;
      ta: taula_ambits renames ts.ta;
      prof: niv_prof renames ts.prof;
      li: index_expansio; -- limit inicial
      Id: Id_Nom;
      lf: index_expansio; -- limit final
   begin
      li := ta(prof);
      Prof := Prof-1;
      lf := ta(prof);
      while li > lf loop
         if te(li).prof /= -1 then
            id := te(li).id;
            td(id).prof := te(li).prof;
            td(id).d := te(li).d;
            td(id).s := te(li).s;
         end if;
         li := li - 1;
      end loop;
   end surt_bloc;

   procedure posa_camp (ts : in out taula_simbols; idr,idc: in id_nom;
                        dc: in descripcio; error: out boolean) is
      td: taula_descripcio renames ts.td;
      te: taula_expansio renames ts.te;
      ta: taula_ambits renames ts.ta;
      prof: niv_prof renames ts.prof;
      ie,ne: index_expansio;
      dr: descripcio;
   begin
      dr := td(idr).d;
      if not (dr.td = dtipus) then
         raise error_record;
      end if;
      if not (dr.dtipus_dt.td = ts_rec) then
         raise error_record;
      end if;
      ie := td(idr).s;
      while ie /= 0 and then te(ie).id /= idc loop
         ie := te(ie).s;
      end loop;
      error := ie /= 0;
      if not error then
         Ne := Ta(Prof); -- reservam espai
         Ne := Ne + 1;
         ta(prof) := ne;
         te(ne).id := idc; -- guardam les dades
         te(ne).d := dc;
         te(ne).prof := -1;
         te(ne).s := td(idr).s; -- ajustam els enllaços
         td(idr).s := ne;
      end if;
   end posa_camp;

   function consulta_camp (ts: in taula_simbols; idr, idc: in id_nom) return descripcio is
      td: taula_descripcio renames ts.td;
      te: taula_expansio renames ts.te;
      ie: index_expansio;
      dr, dc: descripcio;
   begin
      dr := td(idr).d;
      if not (dr.td = dtipus) then
         raise error_record;
      end if;
      if not (dr.dtipus_dt.td = ts_rec) then
         raise error_record;
      end if;
      ie := td(idr).s;
      while ie /= 0 and then te(ie).id /= idc loop
         ie := te(ie).s;
      end loop;
      if ie = 0 then
         dc := (td => dnul_la);
      else
         dc := te(ie).d;
      end if;
      return dc;
   end consulta_camp;

   procedure actualizar(ts: in out taula_simbols; id: in id_nom; d: in descripcio) is
   begin
      ts.td(id).d := d;
   end actualizar;

   procedure posa_index (ts: in out taula_simbols; ida: in id_nom; di: in descripcio) is
      td: taula_descripcio renames ts.td;
      te: taula_expansio renames ts.te;
      ta: taula_ambits renames ts.ta;
      da: descripcio;
      ie1, ie2: index_expansio;
      prof : niv_prof renames ts.prof;
      ne: index_expansio;
   begin
      da := td(ida).d;
      if not (da.td = dtipus) then
         raise error_array;
      end if;
      if not (da.dtipus_dt.td = ts_arr) then
         raise error_array;
      end if;
      ie1 := td(ida).s;
      ie2 := 0;
      while ie1 /= 0 loop
         ie2 := ie1;
         ie1 := te(ie1).s;
      end loop;
      Ne := Ta(Prof);
      Ne := Ne + 1;
      ta(prof) := ne;
      te(ne).id := 0;
      te(ne).prof := -1;
      te(ne).d := di;
      te(ne).s := 0;
      if ie2 = 0 then
         td(ida).s := ne;
      else
         te(ie2).s := ne;
      end if;
   end posa_index;

   procedure primer_index (ts: in taula_simbols; ida: in id_nom;
                           it: out index_expansio) is
      td: taula_descripcio renames ts.td;
      da: descripcio;
   begin
      da := td(ida).d;
      if not (da.td = dtipus and then da.dtipus_dt.td = ts_arr) then
         raise error_array;
      end if;
      it := td(ida).s;
   end primer_index;

   procedure seguent_index (ts: in taula_simbols; it: in out index_expansio) is
      te: taula_expansio renames ts.te;
   begin
      it := te(it).s;
   end seguent_index;

   function es_valid (it: in index_expansio) return boolean is
   begin
      return it /= 0;
   end es_valid;

   procedure consulta_index (ts: in taula_simbols;
                             it: in index_expansio;
                             di: out descripcio) is
      te: taula_expansio renames ts.te;
   begin
      di := te(it).d;
   end consulta_index;

   procedure posar_paramf (ts: in out taula_simbols; idproc, idparf: in id_nom;
                           dparf: in descripcio; error: out boolean) is
      td: taula_descripcio renames ts.td;
      te: taula_expansio renames ts.te;
      ta: taula_ambits renames ts.ta;
      dp: descripcio;
      ie1, ie2: index_expansio;
      prof: niv_prof renames ts.prof;
      ne: index_expansio;
   begin
      dp := td(idproc).d;
      if dp.td /= dproc then
         raise error_proc;
      end if;
      ie1 := td(idproc).s;
      ie2 := 0;
      while ie1 /= 0 and then te(ie1).id /= idparf loop
         ie2 := ie1;
         ie1 := te(ie1).s;
      end loop;
      error := (ie1 /= 0);
      if not error then
         Ne := Ta(Prof);
         Ne := Ne + 1;
         ta(prof) := ne;
         te(ne).id := idparf; te(ne).prof := -1; te(ne).d := dparf; te(ne).s := 0;
         if ie2 = 0 then
            td(idproc).s := ne;
         else
            te(ie2).s := ne;
         end if;
      end if;
   end posar_paramf;

   procedure primer_paramf (ts: in taula_simbols;
                            idproc: in id_nom;
                            it: out index_expansio) is
      td: taula_descripcio renames ts.td;
      d: descripcio;
   begin
      d := td(idproc).d;
      if d.td /= dproc then
         raise error_proc;
      end if;
      it := td(idproc).s;
   end primer_paramf;

   procedure seguent_paramf (ts: in taula_simbols; it: in out index_expansio) is
      te: taula_expansio renames ts.te;
   begin
      it := te(it).s;
   end seguent_paramf;

   procedure consulta_paramf (ts: in taula_simbols;
                              it: in index_expansio;
                              idparf: out id_nom;
                              dparf: out descripcio) is
      te: taula_expansio renames ts.te;
   begin
      idparf := te(it).id;
      dparf := te(it).d;
   end consulta_paramf;

end decls.d_taulasimbols;
