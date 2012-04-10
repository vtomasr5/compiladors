with Semantica.Missatges;
use Semantica.Missatges;

package body semantica.c_tipus is

   idint, idchar, idbool, idstr, idt, idf, idproc, idpar : id_nom;

   procedure ct_inic is
      d , d_aux: descripcio;
      error : boolean := false;
      iProc : infoProc;
      iVar: infoVar;
   begin
      Crearpila(Pilaproc);
      crearFitxerError;

      --Integer
      Afegir_Id (tn,Idint,"integer");
      d := (dtipus,(ts_enter,tam_int,valor(integer'first),valor(integer'last)));
      Posa(Ts,idint,D,Error);

      --Character
      afegir_id (tn,idchar,"character");
      d := (dtipus,(ts_car,tam_car,character'pos(character'first),character'pos(character'last)));
      Posa(Ts,Idchar,D,Error);

      --Boolean
      afegir_id (tn,idbool,"boolean");
      d := (dtipus,(ts_bool,tam_bool,boolean'pos(boolean'first),boolean'pos(boolean'last)));
      posa(ts,idbool,d,error);

      --True
      Afegir_Id (tn,Idt,"true");
      nc := nc + 1;
      iVar := (mconst, idt, false, boolean'pos(true), ts_bool, nc);
      nv := nv + 1;
      tv(nv) := iVar;
      afegir_id (tn,idt,"true");
      d := (dconst,idbool,valor(boolean'pos(true)),nv);
      posa(ts,idt,d,error);

      --False
      Afegir_Id (tn,Idf,"false");
      nc := nc + 1;
      iVar := (mconst, idf, false, boolean'pos(false), ts_bool, nc);
      nv := nv + 1;
      tv(nv) := iVar;
      afegir_id (tn,idf,"false");
      d := (dconst,idbool,valor(boolean'pos(false)),nv);
      posa(ts,idf,d,error);

      --String
      afegir_id (tn,idstr,"string");
      d := (dtipus,(ts_arr,despl(long_max_str)*tam_car,idchar, 0));
      posa(ts,idstr,d,error);

      --Getc
      afegir_id (tn,idproc,"getc");
      afegir_id (tn,idpar,"c_getc");
      iProc := (pext, 0, 0, 0, 1, idproc);
      np := np + 1;
      tp(np) := iProc;
      d := (dproc,np);
      iVar := (mvar, idpar, true, 0, tam_car, np);
      nv := nv + 1;
      tv(nv) := iVar;
      d_aux := (dparam,idchar,nv);
      posa(ts,idproc,d,error);
      posar_paramf(ts, idproc, idpar, d_aux, error);

      --Putc
      afegir_id (tn,idproc,"putc");
      afegir_id (tn,idpar,"c_putc");
      iProc := (pext, 0, 0, 0, 1, idproc);
      np := np + 1;
      tp(np) := iProc;
      d := (dproc,np);
      iVar := (mvar, idpar, true, 0, tam_car, np);
      nv := nv + 1;
      tv(nv) := iVar;
      d_aux := (dparam,idchar,nv);
      posa(ts,idproc,d,error);
      posar_paramf(ts, idproc, idpar, d_aux, error);

      --Geti
      afegir_id (tn,idproc,"geti");
      afegir_id (tn,idpar,"i_geti");
      iProc := (pext, 0, 0, 0, 1, idproc);
      np := np + 1;
      tp(np) := iProc;
      d := (dproc,np);
      iVar := (mvar, idpar, true, 0, tam_int, np);
      nv := nv + 1;
      tv(nv) := iVar;
      d_aux := (dparam,idint,nv);
      posa(ts,idproc,d,error);
      posar_paramf(ts, idproc, idpar, d_aux, error);

      --Puti
      afegir_id (tn,idproc,"puti");
      afegir_id (tn,idpar,"i_puti");
      iProc := (pext, 0, 0, 0, 1, idproc);
      np := np + 1;
      tp(np) := iProc;
      d := (dproc,np);
      iVar := (mvar, idpar, true, 0, tam_int, np);
      nv := nv + 1;
      tv(nv) := iVar;
      d_aux := (dparam,idint,nv);
      posa(ts,idproc,d,error);
      posar_paramf(ts, idproc, idpar, d_aux, error);

      --Puts
      afegir_id (tn,idproc,"puts");
      afegir_id (tn,idpar,"s_puts");
      iProc := (pext, 0, 0, 0, 1, idproc);
      np := np + 1;
      tp(np) := iProc;
      d := (dproc,np);
      iVar := (mvar, idpar, true, 0, 4, np);
      nv := nv + 1;
      tv(nv) := iVar;
      d_aux := (dparam,idstr,nv);
      posa(ts,idproc,d,error);
      posar_paramf(ts, idproc, idpar, d_aux, error);

      --New_line
      afegir_id (tn,idproc,"new_line");
      iProc := (pext, 0, 0, 0, 0, idproc);
      np := np + 1;
      tp(np) := iProc;
      d := (dproc,np);
      posa(ts,idproc,d,error);
   end ct_inic;

   procedure ct_conclueix is
   begin
      tancarFitxererror;
      if error_comp then
         missatge_error_comp;
      else
         missatge_comp_ok;
      end if;
   end ct_conclueix;


   -- DVAR -> LID : id;
   procedure ct_decl_var (p:in pnode) is
      pidt: pnode;
      idt: id_nom;
      dt: descripcio;
   begin
      pidt := p.decl_var_pidtipus;
      idt := pidt.id;
      dt := consultar (ts, idt);
      if Dt.Td /= Dtipus then
         missatge_nodtipus (pidt.pos1.lin, pidt.pos1.col, idt);
         raise error;
      end if;
      ct_decl_var (p.Decl_Var_Plistaid, idt);
   end ct_decl_var;


   -- LID -> LID, id
   --     | id
   procedure ct_decl_var (plid: in pnode; idt: in id_nom) is
      pidv: pnode;
      idv: id_nom;
      d, dt: descripcio;
      e: boolean;
      iVar: infovar;
   begin
      pidv := plid.Lista_Id_Pid;
      Idv := Pidv.Id;
      nv := nv + 1;
      d := (Dvar, idt, nv);
      posa (ts, idv, d, e);
      if E then
         missatge_jaexisteix (pidv.pos1.lin, pidv.pos1.col, idv, "la variable");
         raise error;
      end if;
      Dt := Consultar (Ts, Idt);
      iVar := (mVar, idv, false, 0, dt.dtipus_dt.ocup, cim(pilaProc));
      tv(nv) := iVar;
      if plid.Lista_Id_pContlista /= null then
         ct_decl_var (plid.Lista_Id_pContlista, idt);
      end if;
   end ct_decl_var;


   -- VAL -> lit
   procedure ct_val_lit (p: in pnode; idt: out Id_Nom; tsb: out tipus_subjacent; val: out valor; lin, col: out natural) is
   begin
      idt := id_nul;
      tsb := p.ts;
      Val := P.Vl;
      Lin := P.Pos2.Lin;
      col := p.pos2.col;
   end Ct_Val_Lit;


   -- VAL -> - lit
   procedure ct_val_lit_neg (p: in pnode; idt: out id_nom; tsb: out tipus_subjacent; val: out valor; lin, col: out natural) is
   begin
      if P.Ts /= Ts_Enter then
         missatge_noesenter (p.pos2.lin , p.pos2.col, p.ts);
         raise error;
      end if;
      idt := id_nul;
      tsb := p.ts;
      Val := - P.Vl;
      Lin := P.Pos2.Lin;
      col := p.pos2.col;
   end ct_val_lit_neg;


   -- VAL -> id
   procedure ct_val_id (p: in pnode; idt: out id_nom; tsb: out tipus_subjacent; val: out valor; lin, col: out natural) is
      d, dt: descripcio;
   begin
      d := consultar (ts, p.id);
      if d.td /= dconst then
         missatge_noesconstant (p.pos1.lin, p.pos1.col, d.td);
         raise error;
      end if;
      idt := d.Dconst_Tp;
      dt := consultar (ts, idt);
      tsb := dt.dtipus_dt.td;
      Val := D.Dconst_Vl ;
      Lin := P.Pos1.Lin;
      col := p.pos1.col;
   end ct_val_id;


   -- VAL -> - id
   procedure ct_val_id_neg (p: in pnode; idt: out id_nom; tsb: out tipus_subjacent; val: out valor; lin, col: out natural) is
      d, dt: descripcio;
   begin
      d := consultar (ts, p.id);
      if D.Td /= Dconst then
         missatge_noesconstant (p.pos1.lin, p.pos1.col, d.td);
         raise error;
      end if;
      idt := d.Dconst_Tp;
      dt := consultar (ts, idt);
      tsb := dt.dtipus_dt.td;
      if tsb /= ts_enter then
         missatge_noesenter (p.pos1.lin , p.pos1.col, tsb);
         raise error;
      end if;
      Val := - D.Dconst_Vl;
      Lin := P.Pos1.Lin;
      col := p.pos1.col;
   end ct_val_id_neg;


   -- VAL -> lit
   --     | - lit
   --     | id
   --     | - id
   procedure Comprovar_Valor (Pnvalor: in Pnode; Idt_Val: out Id_Nom; Tsb: out tipus_subjacent; Val: out Valor;
                              Dt: in Descripcio; Idt: in Id_Nom; lin, col: out natural) is
   begin
      if pnvalor.Valor_Lit /= null then
         ct_val_lit (pnvalor.Valor_Lit, idt_val, tsb, val, lin, col);
      elsif (pnvalor.Valor_Lit_Neg /= null) then
         ct_val_lit_neg (pnvalor.Valor_Lit_neg, idt_val, tsb, val, lin, col);
      elsif (pnvalor.Valor_id /= null) then
         ct_val_id (pnvalor.Valor_id, idt_val, tsb, val, lin, col);
      else
         ct_val_id_neg (pnvalor.Valor_id_neg, idt_val, tsb, val, lin, col);
      end if;
      if idt_val = id_nul then
         if Tsb /= Dt.Dtipus_Dt.Td then
            missatge_tsbdifconst (lin, col, idt, tsb);
            raise error;
         end if;
      else
         if Idt_Val /= Idt then
            missatge_tipusdif (lin, col, idt, idt_val);
            raise error;
         end if;
      end if;
   end Comprovar_Valor;


   -- DCONST -> LID : constant id := VAL
   procedure ct_decl_const (p: in pnode) is
      pidt, pnvalor: pnode;
      idt, idt_val: id_nom;
      dt: descripcio;
      tsb: tipus_subjacent;
      Val: Valor;
      lin, col : natural;
   begin
      pidt := p.decl_const_pidtipus;
      idt := pidt.id;
      dt := consultar (ts, idt);
      if Dt.Td /= Dtipus then
         missatge_nodtipus (pidt.pos1.lin, pidt.pos1.col, idt);
         raise error;
      end if;
      if Dt.Dtipus_Dt.Td > Ts_Enter then
         missatge_tsbnoescalar (pidt.pos1.lin, pidt.pos1.col, idt);
         raise error;
      end if;
      Pnvalor := P.Decl_Const_Pvalor;
      comprovar_valor (pnvalor, idt_val, tsb, val, dt, idt, lin, col);
      if Val < Dt.Dtipus_Dt.Li then
         missatge_foraderang (lin, col, idt);
         raise error;
      end  if;
      if Val > Dt.Dtipus_Dt.Ls then
         missatge_foraderang (lin, col, idt);
         raise error;
      end  if;
      ct_decl_const (p.Decl_Const_Plistaid, idt, val);
   end ct_decl_const;


   -- LID -> LID, id
   --     | id
   procedure ct_decl_const (plid: in pnode; idt: in id_nom; val: in valor) is
      pidv: pnode;
      idv: id_nom;
      d, dt: descripcio;
      e: boolean;
      iVar: infovar;
   BEGIN
      nv := nv + 1;
      pidv := plid.Lista_Id_Pid;
      Idv := Pidv.Id;
      d := (Dconst, idt, val,nv);
      posa (ts, idv, d, e);
      if e then
         missatge_jaexisteix (pidv.pos1.lin, pidv.pos1.col, idv, "la constant");
         raise error;
      end if;
      Dt := Consultar (Ts, Idt);
      nc := nc + 1;
      iVar := (mconst, id_nul, false, val, dt.dtipus_dt.td, nc);
      tv(nv) := iVar;
      if plid.Lista_Id_pContlista /= null then
         ct_decl_const (plid.Lista_Id_pContlista, idt, val);
      end if;
   end ct_decl_const;


   -- DSUBRANG -> type id is new id range VAL..VAL
   procedure ct_decl_subrang (p: in pnode) is
      pidt, pid, pnvalor: pnode;
      id, idt, idt_val: id_nom;
      d, dt: descripcio;
      dtn : descr_tipus;
      tsb: tipus_subjacent;
      val1, val2: valor;
      e: boolean;
      Tsb_Subrang: tipus_subjacent;
      lin1, col1, lin2, col2 : natural;
   begin
      pidt := p.Decl_Subr_Pidtipus;
      idt := pidt.id;
      pid := p.Decl_Subr_Pid;
      id := pid.id;
      dt := consultar (ts, idt);
      if dt.td /= Dtipus then
         missatge_nodtipus (pidt.pos1.lin, pidt.pos1.col, idt);
         raise error;
      end if;
      tsb_subrang := dt.dtipus_dt.td;
      if tsb_subrang > ts_enter then
         missatge_tsbnoescalar (pidt.pos1.lin, pidt.pos1.col, idt);
         raise error;
      end if;
      Pnvalor := P. Decl_Subr_Pvlmin;
      comprovar_valor (pnvalor, idt_val, tsb, val1, dt, idt, lin1, col1);
      Pnvalor := P. Decl_Subr_Pvlmax;
      comprovar_valor (pnvalor, idt_val, tsb, val2, dt, idt, lin2, col2);
      if (val1 < dt.dtipus_dt.li) then
         missatge_foraderanginf (lin1, col1, pidt.id);
         raise error;
      end if;
      if (Val2 > Dt.Dtipus_Dt.Ls) then
         missatge_foraderangsup (lin2, col2, pidt.id);
         raise Error;
      end if;
      if (val1 > val2) then
         missatge_infmajorsup (lin2, col2);
         raise error;
      end if;
      case tsb_subrang is
         when ts_bool => dtn := (ts_bool, tam_bool, val1, val2);
         when ts_enter => dtn := (ts_enter, tam_int, val1, val2);
         when ts_car => dtn := (ts_car, tam_car, val1, val2);
         when others => null;
      end case;
      d := (dTipus, dtn);
      posa (ts, id, d, e);
      if e then
         missatge_jaexisteix (pid.pos1.lin, pid.pos1.col, id, "l tipus");
         raise error;
      end if;
   end ct_decl_subrang;


   --  DARRAY -> type id is array (LID) of id;
   procedure ct_decl_array (p: in pnode) is
      pidt, pid: pnode;
      idt, id: id_nom;
      nc: valor := 0;
      da, dt, dtc, di: descripcio;
      dta : descr_tipus;
      E : Boolean;
      Ocup: Despl;
      base: valor;
      it: index_expansio;
   begin
      pidt := p.Decl_Array_Pidtipus;
      idt := pidt.id;
      pid := p.decl_array_pid;
      id := pid.id;
      dta := (ts_arr, 0, id_nul, 0);
      da := (Dtipus, dta);
      posa (ts, id, da, e);
      if e then
         missatge_jaexisteix (pid.pos1.lin, pid.pos1.col, id, "l tipus");
         raise error;
      end if;
      dt := consultar (ts, idt);
      if dt.td /= Dtipus then
         missatge_nodtipus (pidt.pos1.lin, pidt.pos1.col, idt);
         raise error;
      end if;
      Ct_Decl_Array (P.Decl_Array_Plistaid, Idt, Id, Nc);
      dtc := consultar (ts, idt);
      ocup := despl (nc) * dtc.dtipus_dt.ocup;
      primer_index (ts, id, it);
      consulta_index (ts, it, di);
      di := consultar (ts, di.dindex_id);
      base := di.dtipus_dt.li;
      seguent_index (ts, it);
      while es_valid (it) loop
         consulta_index (ts, it, di);
         di := consultar (ts, di.dindex_id);
         base := base * (di.dtipus_dt.ls - di.dtipus_dt.li + 1);
         base := base + di.dtipus_dt.li;
         seguent_index (ts, it);
      END LOOP;
      dta := (ts_arr, ocup, idt, base);
      da := (dTipus, dta);
      actualizar (ts, id, da);
   end ct_decl_array;


   -- LID -> LID, id
   --     | id
   procedure ct_decl_array (p: in pnode; idt: in id_nom; id: in id_nom; nc: in out valor) is
      di, d_index : descripcio;
      pindice: pnode;
      id_indice: id_nom;
   begin
      if p.Lista_Id_pContlista /= null then
         Ct_Decl_Array (P.Lista_Id_Pcontlista, Idt, Id, Nc);
      end if;
      pindice := p.Lista_Id_Pid;
      id_indice := pindice.id;
      di := consultar (ts, id_indice);
      if di.td /= Dtipus then
         missatge_nodtipus (pindice.pos1.lin, pindice.pos1.col, id_indice);
         raise error;
      end if;
      if di.dtipus_dt.td > ts_enter then
         missatge_tsbnoescalar (pindice.pos1.lin, pindice.pos1.col, id_indice);
         raise error;
      end if;
      d_index := (Dindex, id_indice);
      Posa_Index (Ts, Id, D_Index);
      if Nc = 0 then
         Nc := Di.Dtipus_Dt.Ls - Di.Dtipus_Dt.Li + 1;
      else
         nc := (di.dtipus_dt.ls - di.dtipus_dt.li + 1)*nc;
      end if;
   end ct_decl_array;


   -- DRECORD -> type id is record DCAMPS end record;
   procedure ct_decl_record (p: in pnode) is
      pid: pnode;
      ocup: despl :=0;
      dt : descr_tipus;
      d : descripcio;
      e : boolean;
   begin
      pid := p.Decl_Record_Pid;
      dt := (ts_rec, 0);
      d := (Dtipus, dt);
      posa (ts, pid.id, d, e);
      if e then
         missatge_jaexisteix (pid.pos1.lin, pid.pos1.col, pid.id, "l tipus");
         raise error;
      end if;
      Ct_Dcamps (P.Decl_Record_Pdecl_Camps, Pid.Id, Ocup);
      dt := (ts_rec, ocup);
      d := (Dtipus, dt);
      actualizar (ts, Pid.Id, d);
   end ct_decl_record;


   -- DCAMPS -> DCAMPS id: id
   --        | lambda
   procedure ct_dcamps (p: in pnode; id: in id_nom; ocup: in out despl) is
      pid_camp, pidc, pidct: pnode;
      idc, idct : id_nom;
      dt, dcmp : descripcio;
      e : boolean;
   begin
      if p.Decl_Camps_Pcontlista.Decl_Camps_Pdecl_Camp /= null then
         Ct_Dcamps (P.Decl_Camps_Pcontlista, Id, Ocup);
      end if;
      pid_camp := p.Decl_Camps_Pdecl_Camp;
      pidc := pid_camp.Decl_Camp_Pid;
      idc := pidc.id;
      pidct := pid_camp.Decl_Camp_Pidtipus;
      idct := pidct.id;
      dt := consultar (ts, idct);
      if  (dt.td /= Dtipus) then
         missatge_nodtipus (pidct.pos1.lin, pidct.pos1.col, idct);
         raise error;
      end if;
      dcmp := (Dcamp, ocup, idct);
      posa_camp (ts, id, idc, dcmp, e);
      if e then
         missatge_jaexisteix (pidc.pos1.lin, pidc.pos1.col, idc, "l camp");
         raise error;
      end if;
      ocup := ocup + dt.dtipus_dt.ocup;
   end ct_dcamps;


   -- DPROC -> procedure ENCAP is
   --            DECLS
   --          begin
   --            SENTS
   --          end id;
   procedure Ct_Declproc (P: in Pnode; idfinal: in id_nom; lin,col: in natural) is
      idini: id_nom;
   begin
      Ct_Declencap (P.Dproc_Pencap, Idini);
      Ct_Listadecls (P.Dproc_Pdecls);
      ct_listasents (p.Dproc_Psents);
      if Idini /= Idfinal then
         missatge_nomproc (lin, col, idini, idfinal);
         raise Error;
      end if;
      Surt_Bloc (Ts);
      desempilar(pilaProc);
   end Ct_Declproc;


   -- SENTS -> SENTS SENT
   --       | SENT
   procedure Ct_Listasents (P: in Pnode) is
   begin
      if P.sents_Pcontlista /= null then
         Ct_Listasents (P.Sents_Pcontlista);
      end if;
      if P.Sents_Psent /= null then
         Ct_Sent (P.Sents_Psent);
      end if;
   end Ct_Listasents;


   -- DECLS -> DECLS DECL
   --       | lambda
   procedure Ct_listaDecls (P: in Pnode) is
   begin
      if P.Decls_Pcontlista /= null then
         Ct_Listadecls (P.Decls_Pcontlista);
      end if;
      if P.Decls_Pdecl /= null then
         Ct_Decls (P.Decls_Pdecl);
      end if;
   end Ct_listaDecls;


   -- DECL -> DCONST
   --      | DVAR
   --      | DSUBRANG
   --      | DARRAY
   --      | DRECORD
   procedure Ct_Decls (P: in Pnode) is
      q: pnode;
   begin
      if P.Decl_Pdecl_Const /= null then
         Ct_Decl_Const (P.Decl_Pdecl_Const);
      elsif P.Decl_Pdecl_Var /= null then
         Ct_Decl_Var (P.Decl_Pdecl_Var);
      elsif P.Decl_Pdecl_Tipus /= null then
         Q :=  P.Decl_Pdecl_Tipus;
         if Q.Decl_Tipus_Pdecl_Subr /= null then
            Ct_Decl_Subrang (Q.Decl_Tipus_Pdecl_Subr);
         elsif Q.Decl_Tipus_Pdecl_Array /= null then
            Ct_Decl_Array (Q.Decl_Tipus_Pdecl_Array);
         else
            Ct_Decl_Record (Q.Decl_Tipus_Pdecl_Record);
         end if;
      else
         Ct_Declproc (P.Decl_Pdecl_Proc, P.Decl_Pdecl_Proc.Dproc_Pidfinal.id, P.Decl_Pdecl_Proc.Dproc_Pidfinal.pos1.lin, P.Decl_Pdecl_Proc.Dproc_Pidfinal.pos1.col);
      end if;
   end Ct_Decls;


   -- ENCAP -> id (LPARAM)
   --       | id
   procedure ct_declencap (p: in pnode; id: out id_nom) is
      d, dp : descripcio;
      e : boolean;
      pid : pnode;
      idp : id_nom;
      i : index_expansio;
      iProc : infoProc;
   BEGIN
      np := np + 1;
      D := (Dproc, Np);
      p.Encap_Pnumproc := np;
      pid := p.Encap_Pidproc;
      id := pid.id;
      posa (ts, id, d, e);
      if e then
         missatge_jaexisteix (pid.pos1.lin, pid.pos1.col, id, "l procediment");
         raise error;
      end if;
      if estabuida(pilaProc) then
         iProc := (pext, 0, 0, 0, 0, id);
      else
         iProc := (ploc, tp(cim(pilaProc)).prof + 1, 0, 0, 0 , id, eNula);
      end if;
      Tp(Np) := Iproc;
      empilar(pilaProc,np);
      if p.Encap_Pcenc.Cenc_pLpar /= null then
         ct_declencap2 (p.Encap_Pcenc.Cenc_pLpar, id, np);
         entra_bloc (ts);
         primer_paramf (ts, id, i);
         while es_valid (i) loop
            Consulta_Paramf (Ts, I, Idp, Dp);
            posa (ts, idp, dp, e);
            seguent_paramf (ts, i);
         end loop;
      else
         entra_bloc (ts);
      end if;
   end ct_declencap;


   -- LPARAM -> LPARAM; PARAM
   --        | PARAM
   -- PARAM -> id: MODE id
   -- MODE -> in
   --      | in out
   procedure ct_declencap2 (p: in pnode; id: in id_nom; np: in num_proc) is
      pidp, pidtp, pmode : pnode;
      idp, idtp : id_nom;
      d, dtp : descripcio;
      mode : T_param;
      E : Boolean;
      iVar: infoVar;
   begin
      if (p.L_Param_pL_Param /= null) then
         ct_declencap2 (p.L_Param_pL_Param, id, np);
      end if;
      pidtp := p.L_Param_Pparam.Param_Pidtipusparam;
      idtp := pidtp.id;
      pidp := p.L_Param_Pparam.Param_Pidparam;
      idp := pidp.id;
      dtp := consultar (ts, idtp);
      if (dtp.td /= Dtipus) then
         missatge_nodtipus (pidtp.pos1.lin, pidtp.pos1.col, idtp);
         raise Error;
      end if;
      pmode := p.L_Param_Pparam.Param_Ptipusparam;
      mode := pmode.Tipus_Param;
      iVar := (mvar, idp, true, 0, 4, cim (pilaproc));
      if Mode = P_In then
         nv := nv + 1;
         D := (Dparam, Idtp, nv);
      else
         nv := nv + 1;
         D := (Dvar, Idtp, nv);
      end if;
      Tv(Nv) := Ivar;
      posar_paramf (ts, id, idp, d, e);
      if e then
         missatge_jaexisteix (pidp.pos1.lin, pidp.pos1.col, idp, "l paràmetre");
         raise error;
      end if;
   end ct_declencap2;


   -- E -> lit
   procedure ct_expr_lit (p: in pnode; tsb: out tipus_subjacent; idt: out id_nom; lin, col: out natural) is
      pnlit: pnode;
   begin
      pnlit := p.n_exp;
      tsb := pnlit.ts;
      Idt := Id_Nul;
      Lin := Pnlit.Pos2.Lin;
      col := pnlit.pos2.col;
   end ct_expr_lit;


   -- E
   procedure Ct_E (P: in Pnode; Idte: out Id_Nom; Tsbe: out tipus_subjacent; Mde : out Mode; lin, col: out natural) is
      Idte1, Idte2 : Id_Nom;
      Tsbe1, Tsbe2 : tipus_subjacent;
      Mde1, Mde2 : Mode;
      lin1, col1, lin2, col2 : natural;
   begin
      case P.Tnd is
         when Nsuma..Nmod =>
            Ct_E (P.N_Oper_Exp1, Idte1, Tsbe1, Mde1, lin1, col1);
            Ct_E (P.N_Oper_Exp2, Idte2, Tsbe2, Mde2, lin2, col2);
            Ct_Expr_Arit (Idte1, Idte2, Idte, Tsbe1, Tsbe2, Tsbe, lin1, col1, lin2, col2);
            Mde := Mdresult;
            Lin := Lin1;
            col := col1;
         when Nand..Nor =>
            Ct_E (P.N_Oper_Exp1, Idte1, Tsbe1, Mde1, lin1, col1);
            Ct_E (P.N_Oper_Exp2, Idte2, Tsbe2, Mde2, lin2, col2);
            Ct_Expr_Log (Idte1, Idte2, Idte, Tsbe1, Tsbe2, Tsbe, lin1, col1, lin2, col2);
            Mde := Mdresult;
            Lin := Lin1;
            col := col1;
         when Nmajor..Nigual =>
            Ct_E (P.N_Oper_Exp1, Idte1, Tsbe1, Mde1, lin1, col1);
            Ct_E (P.N_Oper_Exp2, Idte2, Tsbe2, Mde2, lin2, col2);
            Ct_Expr_Comp (Idte1, Idte2, Idte, Tsbe1, Tsbe2, Tsbe, lin1, col1, lin2, col2);
            Mde := Mdresult;
            Lin := Lin1;
            col := col1;
         when Nneg =>
            Ct_E (P.N_Oper_Exp1, Idte1, Tsbe1, Mde1, lin, col);
            Ct_Expr_Neg (Idte1, Idte, Tsbe1, Tsbe, lin, col);
            Mde := Mdresult;
         when Nparent =>
            Ct_E (P.N_Oper_Exp1, Idte1, Tsbe1, Mde1, lin, col);
            Ct_Exp_Parent (Idte1, Idte, Tsbe1, Tsbe);
            Mde := Mdresult;
         when Nnot =>
            Ct_E (P.N_Oper_Exp1, Idte1, Tsbe1, Mde1, lin, col);
            Ct_Expr_Not (Idte1, Idte, Tsbe1, Tsbe, lin, col);
            Mde := Mdresult;
         when Neref =>
            Ct_Exp_Ref (P, Idte1, Idte, Tsbe1, Tsbe, Mde1, Mde, lin, col);
         when Nelit =>
            Ct_Expr_Lit (P, Tsbe, Idte, lin, col);
            Mde := Mdconst;
         when others => null;
      end case;
   end Ct_E;


   -- E -> E + E
   -- E -> E - E
   -- E -> E * E
   -- E -> E / E
   -- E -> E mod E
   procedure Ct_Expr_Arit (Idte1, Idte2: in Id_Nom; Idter: out Id_Nom; Tsbe1, Tsbe2: in tipus_subjacent; Tsber: out tipus_subjacent;
                           lin1, col1, lin2, col2: in natural) is
   begin
      if Tsbe1 /= Ts_Enter then
         Missatge_Noesenter (lin1, col1, tsbe1);
         raise Error;
      end if;
      if Tsbe2 /= Ts_Enter then
         Missatge_Noesenter (lin2, col2, tsbe2);
         raise Error;
      end if;
      tsber := ts_enter;
      if idte1 = id_nul then
         if idte2 = id_nul then
            idter := id_nul;
         else
            idter := idte2;
         end if;
      else
         if idte2 = id_nul then
            idter := idte1;
         else
            if idte1 /= idte2 then
               missatge_tipusoperdif (lin2, col2);
               raise error;
            end if;
            idter := idte1;
         end if;
      end if;
   end ct_expr_arit;


   -- E -> - E
   procedure ct_expr_neg (Idte1: in id_nom; idter: out Id_Nom; Tsbe1: in tipus_subjacent; tsber: out tipus_subjacent; lin, col : in natural) is
   begin
      if Tsbe1 /= Ts_Enter then
         Missatge_Noesenter (lin, col, tsbe1);
         raise Error;
      end if;
      Idter := Idte1;
      tsber := tsbe1;
   end ct_expr_neg;


   -- E -> E and E
   -- E -> E or E
   procedure Ct_Expr_Log (Idte1, Idte2: in Id_Nom; Idter: out Id_Nom; Tsbe1, Tsbe2: in tipus_subjacent; Tsber: out tipus_subjacent;
                          lin1, col1, lin2, col2: in natural) is
   begin
      if Tsbe1 /= Ts_bool then
         missatge_tsbnobool (lin1, col1, tsbe1);
         raise Error;
      end if;
      if Tsbe2 /= Ts_bool then
         missatge_tsbnobool (lin2, col2, tsbe2);
         raise Error;
      end if;
      tsber := ts_bool;
      if idte1 /= idte2 then
         missatge_tipusoperdif (lin2, col2);
         raise error;
      end if;
      idter := idte1;
   end ct_expr_log;


   -- E -> not E
   procedure ct_expr_not (Idte1: in id_nom; idter: out Id_Nom; Tsbe1: in tipus_subjacent; tsber: out tipus_subjacent; lin, col : in natural) is
   begin
      if Tsbe1 /= Ts_bool then
         missatge_tsbnobool (lin, col, tsbe1);
         raise Error;
      end if;
      Idter := Idte1;
      tsber := tsbe1;
   end ct_expr_not;


   -- E -> E > E
   -- E -> E < E
   -- E -> E >= E
   -- E -> E <= E
   -- E -> E /= E
   -- E -> E = E
   procedure Ct_Expr_Comp (Idte1, Idte2: in Id_Nom; Idter: out Id_Nom; Tsbe1, Tsbe2: in tipus_subjacent; Tsber: out tipus_subjacent;
                           lin1, col1, lin2, col2: in natural) is
   begin
      if Tsbe1 /= Tsbe2 then
         missatge_tipusoperdif (lin2, col2);
         raise Error;
      end if;
      if Tsbe1 > Ts_Enter then
         missatge_tsbnoescalar (lin1, col1, idte1);
         raise Error;
      end if;
      if Idte1 /= Id_Nul and Idte2 /= Id_Nul then
         if Idte1 /= Idte2 then
            missatge_tipusoperdif(lin2 ,col2);
            raise Error;
         end if;
      end if;
      tsber := ts_bool;
      idter := id_nul;
   end ct_expr_comp;


   -- E -> ( E )
   procedure ct_exp_parent (Idte1: in id_nom; idter: out Id_Nom; Tsbe1: in tipus_subjacent; tsber: out tipus_subjacent) is
   begin
      Idter := Idte1;
      tsber := tsbe1;
   end ct_exp_parent;


   -- E -> REF
   procedure ct_exp_ref (p: in pnode; Idtr, idter: out Id_Nom; Tsbr, tsber: out tipus_subjacent; mdr, mder: out mode; lin, col: out natural) is
   begin
      Ct_Ref (p.n_exp, idtr, tsbr, mdr, lin, col);
      Idter := Idtr;
      Tsber := Tsbr;
      mder := mdr;
   end ct_exp_ref;


   -- REF -> id CALFS
   procedure Ct_Ref (P: in Pnode; idt: out Id_nom; Tsb: out tipus_subjacent; md: out mode; lin, col: out natural) is
   begin
      ct_ref_id (p.Ref_Pid, idt, tsb, md, lin, col);
      ct_calfs (p.Ref_Pcalif, idt, tsb, md, lin, col);
   end Ct_Ref;


   -- REF -> id
   procedure Ct_Ref_Id (P: in Pnode; idt: out id_nom; tsb: out tipus_subjacent; md: out mode; lin, col: out natural) is
      id : id_nom;
      d, dt : descripcio;
   begin
      Id := P.Id;
      Lin := P.Pos1.Lin;
      col := p.pos1.col;
      d := consultar (ts, id);
      case d.td is
         when dvar =>
            idt := d.Dvar_Tp;
            dt := consultar (ts, d.Dvar_tp);
            tsb := dt.dtipus_dt.td;
            Md := Mdvar;
            P.Nv := D.Dvar_Nv;
            P.Tipus := Dvar;
            P.Idt := idt;
            p.tsb := tsb;
         when dconst =>
            idt := d.Dconst_Tp;
            dt := consultar (ts, d.Dconst_Tp);
            tsb := dt.dtipus_dt.td;
            Md := Mdconst;
            P.Nv := D.Dconst_Nv;
            P.Tipus := Dconst;
            P.Idt := idt;
            p.tsb := tsb;
         when dproc =>
            idt := id;
            tsb := ts_procp;
            Md := Mdconst;
            P.Np := D.Dproc_Np;
            p.tipus := dproc;
         when Dparam =>
            idt := d.Dparam_Tp;
            dt := consultar (ts, d.Dparam_Tp);
            tsb := dt.dtipus_dt.td;
            Md := Mdconst;
            P.Nv := D.dparam_nv;
            P.Tipus := Dparam;
            P.Idt := idt;
            p.tsb := tsb;
         when others =>
            missatge_elementinexistent (lin, col, id);
            raise error;
      end case;
   end Ct_Ref_Id;


   -- CALFS -> CALFS CALF
   --       | lambda
   procedure Ct_Calfs (P: in Pnode; idt: in out id_nom; tsb: in out tipus_subjacent; md: in out mode; lin, col: in out natural) is
   begin
      if P.Calfs_Pcontlista /= null then
         Ct_Calfs (P.Calfs_Pcontlista, idt, tsb, md, lin, col);
      end if;
      if P.Calfs_Pcalif /= null then
         Ct_Calf (P.Calfs_Pcalif, idt, tsb, lin, col);
      end if;
   end Ct_Calfs;


   -- CALF -> (EXPRS)
   --      | .id
   procedure Ct_Calf (P: in Pnode; Idt: in out Id_Nom; Tsb: in out tipus_subjacent; lin, col: in out natural) is
      It : Index_Expansio;
      Primer : Boolean := True;
      darr, dcomp : Descripcio;
   begin
      if P.Calf1_Pid /= null then
         Ct_Ref_Id (P.Calf1_Pid, idt, tsb, lin, col);
      else
         Ct_Ref_Listae (P.Calf2_Pexp, Idt, Tsb, It, Primer, lin, col);
         if tsb = ts_arr then
            darr := Consultar (Ts, Idt);
            P.Calf2_Pexp.Base := Darr.Dtipus_Dt.B;
            p.calf2_Pexp.tipus_comp := darr.Dtipus_dt.tcomp;
            Ct_Ref_Finlista (it, Idt, Tsb, lin, col);
            Dcomp := Consultar (Ts, Idt);
            P.Calf2_Pexp.Ocup := Dcomp.Dtipus_Dt.Ocup;
         else
            Ct_Ref_Finlista (it, Idt, Tsb, lin, col);
         end if;
      end if;
   end Ct_Calf;


   -- CALF -> .id
   procedure Ct_Ref_Id (P: in Pnode; idt: in out id_nom; tsb: in out tipus_subjacent; lin, col: in out natural) is
      d, dt : descripcio;
   begin
      if Tsb /= Ts_Rec then
         missatge_tsbnorec (lin, col, idt);
         raise Error;
      end if;
      D := Consulta_Camp (Ts, Idt, P.Id);
      Lin := P.Pos1.Lin;
      col := p.pos1.col;
      if D.Td = Dnul_La then
         Missatge_Campnoexistent (P.Pos1.Lin, P.Pos1.Col, P.Id);
         raise Error;
      end if;
      Idt := D.Dcamp_Tp;
      Dt := Consultar (Ts, D.Dcamp_Tp);
      Tsb := Dt.Dtipus_Dt.Td;
      P.Ds := D.Dcamp_Ds;
      P.Idt := Idt;
      p.tsb := tsb;
   end Ct_Ref_Id;


   -- EXPRS -> EXPRS, E
   --       | E
   procedure Ct_Ref_Listae (P: in Pnode; Idt: in out Id_Nom; Tsb: in out tipus_subjacent; pos: in out index_expansio; primer: in out boolean; lin, col: in out natural) is
   begin
      if P.Lexp_Pcontlista /= null then
         Ct_Ref_Listae (P.Lexp_Pcontlista, Idt, Tsb, Pos, primer, lin, col);
      end if;
      Ct_Ref_E (P.Lexp_Pexp, pos, tsb, idt, primer, lin, col);
   end Ct_Ref_Listae;


   -- s'executa al finalitzar una llista d'expressions d'una referència.
   procedure Ct_Ref_Finlista (It: in out Index_Expansio; Idt: in out Id_Nom; Tsb: in out tipus_subjacent; lin, col: in natural) is
      d, dt : descripcio;
   begin
      case Tsb is
         when ts_arr =>
            Seguent_Index (Ts, It);
            if Es_Valid (It) then
               missatge_faltenindexos (lin, col);
               raise Error;
            end if;
            D := Consultar (Ts, Idt);
            Dt := Consultar (Ts, D.Dtipus_Dt.Tcomp);
            Idt := D.Dtipus_Dt.Tcomp;
            Tsb := Dt.Dtipus_Dt.Td;
         when Ts_Procp =>
            Seguent_Paramf (Ts, It);
            if Es_Valid (It) then
               missatge_faltenparametres(lin, col);
               raise Error;
            end if;
            Tsb := Ts_Procc;
         when others =>
            missatge_noarrniproc (lin, col);
            raise Error;
      end case;
   end Ct_Ref_Finlista;


   procedure Tornar_Index (Primer: in out Boolean; Idt: in Id_Nom; It: in out Index_Expansio; lin, col: in natural) is
   begin
      if Primer = True then
         primer := false;
         Primer_Index (Ts, Idt, It);
      else
         Seguent_Index (Ts, It);
      end if;
      if not Es_Valid (It) then
         missatge_sobrenindexos (lin, col);
         raise Error;
      end if;
   end Tornar_Index;


   procedure Tornar_param (Primer: in out Boolean; Idt: in Id_Nom; It: in out Index_Expansio; lin, col: in natural) is
   begin
      if Primer = True then
         primer := false;
         Primer_paramf (Ts, Idt, It);
      else
         Seguent_paramf (Ts, It);
      end if;
      if not Es_Valid (It) then
         missatge_sobrenparametres (lin, col);
         raise Error;
      end if;
   end Tornar_param;


   procedure Validar_Index (Idte: in Id_Nom; Di: in Descripcio; tsbe: in tipus_subjacent; li, ls: out valor; lin, col: in natural) is
      Dti: Descripcio;
   begin
      if Idte = id_nul or idte = idint or idte = idchar or idte = idbool then
         Dti := Consultar (Ts, Di.Dindex_Id);
         Li := Dti.Dtipus_Dt.Li;
         ls := Dti.Dtipus_Dt.Ls;
         if Tsbe /= Dti.Dtipus_Dt.Td then
            missatge_tipusnocomp (lin, col, tsbe, Dti.Dtipus_Dt.Td);
            raise Error;
         end if;
      else
         if Idte /= Di.Dindex_Id then
            missatge_tipusindexdif (lin, col, idte, Di.Dindex_Id);
            raise Error;
         end if;
      end if;
   end Validar_Index;


   procedure Validar_param (Idte: in Id_Nom; Darg: in Descripcio; tsbe: in tipus_subjacent; lin, col: in natural) is
      Dtarg: Descripcio;
      idt: id_nom;
   begin
      if Idte = id_nul or idte = idint or idte = idchar or idte = idbool then
         if Darg.Td = Dvar then
            Dtarg := Consultar (Ts, Darg.Dvar_Tp);
            idt := Darg.Dvar_Tp;
         else
            Dtarg := Consultar (Ts, Darg.Dparam_Tp);
            idt := Darg.Dparam_Tp;
         end if;
         if Tsbe /= Dtarg.Dtipus_Dt.Td then
            missatge_tipusnocomp (lin, col, tsbe, Dtarg.Dtipus_Dt.Td);
            raise Error;
         end if;
      else
         if Darg.Td = Dvar then
            if Idte /= Darg.Dvar_Tp then
               missatge_tipusindexdif (lin, col, Idte, Darg.Dvar_Tp);
               raise Error;
            end if;
         else
            if Idte /= Darg.Dparam_Tp then
               missatge_tipusindexdif (lin, col, Idte, Darg.Dparam_Tp);
               raise Error;
            end if;
         end if;
      end if;
   end Validar_param;


   -- s'executa al començar una llista d'expressions d'una referència.
   procedure Ct_Ref_E (P: in Pnode; it: in out index_expansio; Tsb: in tipus_subjacent; idt: in id_nom; primer: in out boolean; lin, col: in out natural) is
      Di, darg: Descripcio;
      Idte, Idarg: Id_Nom;
      li, ls: valor;
      Tsbe : tipus_subjacent;
      mde : mode;
   begin
      Ct_E (P, Idte, Tsbe, Mde, lin, col);
      case Tsb is
         when Ts_Arr =>
            tornar_index (primer, idt, it, lin, col);
            Consulta_Index (Ts, It, Di);
            Validar_Index (Idte, Di, Tsbe, Li, Ls, lin, col);
            case P.Tnd is
               when Nsuma..Nnot =>
                  P.Li_Expc := Li;
                  P.Ls_Expc := Ls;
               when Neref .. Nelit =>
                  P.Li_Exps := Li;
                  P.Ls_Exps := Ls;
               when others => null;
            end case;
         when Ts_Procp =>
            tornar_param (primer, idt, it, lin, col);
            Consulta_Paramf (Ts, It, Idarg, Darg);
            if Darg.Td = Dvar and Mde /= Mdvar then
               missatge_paramout (lin, col);
               raise Error;
            end if;
            validar_param (idte, darg, tsbe, lin, col);
         when others =>
            missatge_noarrniproc (lin, col);
            raise Error;
      end case;
   end Ct_Ref_E;


   -- SENT -> CONDICIONAL
   --      | ASIGNACIÓ
   --      | ITERERACIÓ
   --      | CRIDA PROC
   procedure Ct_Sent (p: in pnode) is
   begin
      if P.Sent_Pcond /= null then
         Ct_Sent_Cond_It (P.Sent_Pcond.Cond_Pexp);
         if P.Sent_Pcond.Cond_Psentsif /= null then
            Ct_Listasents (P.Sent_Pcond.Cond_Psentsif);
         end if;
         if P.Sent_Pcond.Cond_Psentselse /= null then
            Ct_Listasents (P.Sent_Pcond.Cond_Psentselse);
         end if;
      elsif P.Sent_Piter /= null then
         Ct_Sent_Cond_It (P.Sent_Piter.Iterac_Pexp);
         if P.Sent_Piter.Iterac_Psents /= null then
            Ct_Listasents (P.Sent_Piter.Iterac_Psents);
         end if;
      elsif P.Sent_Pasig /= null then
         Ct_Sent_Asig (P.Sent_Pasig);
      else
         Ct_Sent_Llam_Proc (P.Sent_Pllam_Proc);
      end if;
   end Ct_Sent;


   -- CONDICIONAL -> if E then SENTS end if;
   --             | if E then SENTS else SENTS end if;
   -- ITERACIO -> while E loop SENTS end loop;
   procedure Ct_Sent_Cond_It (P: in Pnode) is
      Idt : Id_Nom;
      Tsb : tipus_subjacent;
      Md : Mode;
      lin, col: natural;
   begin
      ct_e (p, idt, tsb, md, lin, col);
      if Tsb /= Ts_Bool then
         missatge_tsbnobool (lin, col, tsb);
         raise Error;
      end if;
   end Ct_Sent_Cond_It;


   -- ASIGNACIÓ -> REF := E;
   procedure Ct_Sent_Asig (P: in Pnode) is
      Idtr, Idte : Id_Nom;
      Tsbr, Tsbe : tipus_subjacent;
      Mdr, Mde : Mode;
      Dt: Descripcio;
      lin1, col1, lin2, col2 : natural;
   begin
      Ct_Ref (P.Asig_Pref, Idtr, Tsbr, Mdr, lin1, col1);
      Ct_E (P.Asig_Pexp, Idte, Tsbe, Mde, lin2, col2);
      if Mdr /= Mdvar then
         missatge_refnovar (lin1, col1);
         raise Error;
      end if;
      if Idte = id_nul then
         if Tsbe /= Tsbr then
            missatge_tipusdifvar (lin2, col2, tsbr, tsbe);
            raise Error;
         end if;
         if Tsbe > Ts_Enter then
            missatge_tsbnoescalarexpr (lin2, col2);
            raise Error;
         end if;
      else
         if Idte /= Idtr then
            missatge_tipusdif (lin2, col2, idtr, idte);
            raise Error;
         end if;
         Dt := Consultar (Ts, Idte);
         if Dt.Dtipus_Dt.Td > Ts_Enter then
            missatge_tsbnoescalar (lin2, col2, idte);
            raise Error;
         end if;
      end if;
   end Ct_Sent_Asig;


   -- CRIDA PROC -> REF;
   procedure Ct_Sent_Llam_Proc (P: in Pnode) is
      Idtr : Id_Nom;
      Tsbr : tipus_subjacent;
      Mdr : Mode;
      It : Index_Expansio;
      lin, col : natural;
   begin
      Ct_Ref (P.llam_proc_pref, Idtr, Tsbr, Mdr, lin, col);
      case Tsbr is
         when Ts_Procc =>
            null;
         when Ts_Procp =>
            Primer_paramf (Ts, Idtr, It);
            if Es_Valid (It) then
               missatge_faltenparametres (lin, col);
               raise Error;
            end if;
         when others =>
            missatge_noproc (lin, col);
            raise Error;
      end case;
   end Ct_Sent_Llam_Proc;

end semantica.c_tipus;

















