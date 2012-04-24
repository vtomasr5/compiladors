--with semantica.c3a; use Semantica.C3a;
with Decls.D_Descripcio, decls.d_c3a, decls.d_pila;
use Decls.D_Descripcio, decls.d_c3a, decls.d_pila;

package body Semantica.g_codi is

   procedure Gc_Prepara (Nom: in String) is
   begin
      Preparac3a(Nom);
   end Gc_Prepara;

   procedure Gc_finalitza is
   begin
      tancarc3a;
   end Gc_finalitza;

   -- DPROC -> procedure ENCAP is
   --            DECLS
   --          begin
   --            SENTS
   --          end id;
   procedure gc_dproc (p: in pnode) is
      n_proc : num_proc;
      elc3a: elementc3a;
   begin
      Gc_Lista_Decls (p.Dproc_Pdecls);
      Gc_Dencap (P.Dproc_Pencap, N_Proc);
      Gc_Lista_Sents (P.Dproc_Psents);
      elc3a := (rtn, n_proc);
      Genera (Elc3a);
      desempilar(pilaProc);
   end gc_dproc;

   -- DECLS -> DECLS DECL
   --       | lambda
   procedure Gc_Lista_Decls (P: in Pnode) is
   begin
      if P.Decls_Pcontlista /= null then
         Gc_Lista_Decls (P.Decls_Pcontlista);
      end if;
      if P.Decls_Pdecl /= null then
         if P.Decls_Pdecl.Decl_Pdecl_Proc/= null then
            Gc_Dproc (P.Decls_Pdecl.Decl_Pdecl_Proc);
         end if;
      end if;
   end Gc_Lista_Decls;

   -- SENTS -> SENTS SENT
   --       | SENT
   procedure gc_lista_sents (p: in pnode) is
   begin
      if p /= null then
         if P.sents_Pcontlista /= null then
            gc_Lista_sents (P.Sents_Pcontlista);
         end if;
         if P.Sents_Psent /= null then
            gc_Sent (P.Sents_Psent);
         end if;
      end if;
   end gc_lista_sents;


   -- SENT -> CONDICIONAL
   --      | ASIGNACIÓ
   --      | ITERERACIÓ
   --      | CRIDA PROC
   procedure gc_Sent (p: in pnode) is
   begin
      if P.Sent_Pcond /= null then
         Gc_Sent_Cond (P.Sent_Pcond);
      elsif P.Sent_Piter /= null then
         Gc_Sent_Iter (P.Sent_Piter);
      elsif P.Sent_Pasig /= null then
         gc_sent_asig (P.Sent_Pasig);
      else
         gc_llam_proc (P.Sent_Pllam_Proc);
      end if;
   end gc_Sent;


   -- ENCAP -> id (LPARAM)
   --       | id
   procedure gc_dencap (p: in pnode; n_proc: out num_proc) is
      e: etiqueta;
      elc3a: elementc3a;
   begin
      N_Proc := P.Encap_Pnumproc;
      empilar(pilaProc, n_proc);
      e := novaEtiqueta;
      elc3a := (etiq, e);
      genera (elc3a);
      if tp(n_proc).mode = ploc then
         tp(n_proc).e := e;
      end if;
      elc3a := (Pmb, n_proc);
      genera (elc3a);
   end gc_dencap;


   -- REF -> id CALFS
   procedure Gc_Ref (P: in Pnode; n_proc: out num_proc; r,d: out num_var) is
      Idt : Id_Nom;
      tsb : tipus_subjacent;
   begin
      gc_ref_id (p.Ref_Pid, d, r, idt, n_proc, tsb);
      gc_calfs (p.Ref_Pcalif, d, idt, tsb);
   end Gc_Ref;


   -- CALFS -> CALFS CALF
   --       | lambda
   procedure gc_Calfs (P: in Pnode; d: in out num_var; idt: in out id_nom; tsb: in out tipus_subjacent) is
   begin
      if P.Calfs_Pcontlista /= null then
         gc_Calfs (P.Calfs_Pcontlista, d, idt, tsb);
      end if;
      if P.Calfs_Pcalif /= null then
         gc_Calf (P.Calfs_Pcalif, d, idt, tsb);
      end if;
   end gc_Calfs;


   -- CALF -> (EXPRS)
   --      | .id
   procedure gc_Calf (P: in Pnode; d : in out num_var; idt: in out id_nom; tsb: in out tipus_subjacent) is
      Primer : Boolean := True;
      dc : num_var;
   begin
      IF P.Calf1_Pid /= NULL THEN
         Gc_Ref_Id (P.Calf1_Pid, D, Idt, Tsb);
      ELSE
         Gc_Ref_Listae (P.Calf2_Pexp, Idt, Tsb, Primer, D, Dc);
         gc_ref_finlista (idt, tsb, dc, d, P.Calf2_Pexp.base, P.Calf2_Pexp.ocup, p.Calf2_Pexp.tipus_comp);
      end if;
   end gc_Calf;


   -- REF -> id
   procedure gc_ref_id (p: in pnode; d,r : out num_var; idt: out id_nom; n_proc: out num_proc; tsb: out tipus_subjacent) is
      t : num_var;
      elc3a: elementc3a;
   begin
      case p.tipus is
         WHEN Dvar =>
            R := p.nv;
            D := Vnula;
            Idt := P.Idt;
            tsb := p.tsb;
         WHEN Dconst =>
            T := NovaVar;
            elc3a := (copia, t, p.nv);
            genera (elc3a);
            r := t;
            D := Vnula;
            Idt := P.Idt;
            tsb := p.tsb;
         WHEN Dparam =>
            r := p.nv;
            D := Vnula;
            Idt := P.Idt;
            tsb := p.tsb;
         when dproc =>
            N_Proc := p.np;
            tsb := ts_procp;
         when others => null;
      end case;
   end gc_ref_id;


   -- CALF -> .id
   procedure gc_Ref_Id (P: in Pnode; d: in out num_var; idt: in out id_nom; tsb: out tipus_subjacent) is
      t : num_var;
      elc3a: elementc3a;
   begin
      t := novaVar;
      if d = vnula then
         elc3a := (copia, t, novaConst(valor (p.ds), ts_enter));
         genera (elc3a);
      else
         elc3a := (suma, t, d, novaConst(valor (p.ds), ts_enter));
         genera (elc3a);
      end if;
      D := T;
      Idt := P.Idt;
      tsb := p.tsb;
   end Gc_Ref_Id;


   -- EXPRS -> EXPRS, E
   --       | E
   procedure Gc_Ref_Listae (P: in Pnode; Idt: in out Id_Nom; tsb: in tipus_subjacent; primer: in out boolean; db: in out num_var; d: in out num_var) is
   begin
      if P.Lexp_Pcontlista /= null then
         gc_Ref_Listae (P.Lexp_Pcontlista, Idt, tsb, primer, db, d);
      end if;
      gc_Ref_E (P.Lexp_Pexp, tsb, primer, d);
   end gc_Ref_Listae;


   -- s'executa al finalitzar una llista d'expressions d'una referència.
   procedure Gc_Ref_Finlista (Idt: in out Id_Nom; Tsb: in tipus_subjacent; D: in out Num_Var; da: in out num_var; base: in valor; ocup: in desplacament; tipus_comp: in id_nom) is
      T1, T2, T3, t4: Num_Var;
      elc3a: elementc3a;
   begin
      if tsb = ts_arr then
         T1 := Novavar;
         Elc3a := (Resta, T1, D, Novaconst(Valor (base), Ts_Enter));
         Genera (Elc3a);
         T2 := Novavar;
         Elc3a := (Prod, T2, T1, Novaconst(Valor (Ocup), Ts_Enter));
         Genera (Elc3a);
         t3 := novaVar;
         Elc3a := (neg,t3,t2);
         genera (Elc3a);
         if da = Vnula then
            Da := T3;
         else
            T4 := Novavar;
            Elc3a := (Suma, T4, T3, Da);
            Genera (Elc3a);
            Da := T4;
         end if;
         Idt := tipus_comp;
      end if;
   end Gc_Ref_Finlista;


   -- E
   procedure Gc_E (P: in Pnode; R,D: out Num_Var) is
      R1, R2, d1, d2: Num_Var;
   begin
      case P.Tnd is
         when Nsuma..Nmod =>
            gc_E (P.N_Oper_Exp1, r1, d1);
            gc_E (P.N_Oper_Exp2, r2, d2);
            gc_Expr_Arit (p, r1, r2, d1, d2, r, d);
         when Nand..Nor =>
            gc_E (P.N_Oper_Exp1, r1, d1);
            gc_E (P.N_Oper_Exp2, r2, d2);
            gc_Expr_log (p, r1, r2, d1, d2, r, d);
         when Nmajor..Nigual =>
            gc_E (P.N_Oper_Exp1, r1, d1);
            Gc_E (P.N_Oper_Exp2, R2, D2);
            Gc_Expr_Comp (P, R1, R2, D1, D2, R, D);
         when Nneg =>
            gc_E (P.N_Oper_Exp1, r1, d1);
            gc_Expr_Neg (r1, d1, r, d);
         when Nparent =>
            gc_E (P.N_Oper_Exp1, r1, d1);
            gc_Expr_parent (r1, d1, r, d);
         when Nnot =>
            gc_E (P.N_Oper_Exp1, r1, d1);
            gc_Expr_Not (r1, d1, r, d);
         WHEN Neref =>
            gc_Expr_Ref (p, r, d);
         when Nelit =>
            Gc_Expr_Lit (P, R, D);
         when others => null;
      end case;
   end Gc_E;



   procedure desreferenciar (d, r: in num_var; x: out num_var) is
      Elc3a: Elementc3a;
   begin
      if D = Vnula then
         x := r;
      else
         X := Novavar;
         Elc3a := (Consindex, X, R, D);
         Genera (Elc3a);
      end if;
   end desreferenciar;


   -- E -> E + E
   -- E -> E - E
   -- E -> E * E
   -- E -> E / E
   -- E -> E mod E
   procedure Gc_Expr_Arit (P: in Pnode; R1, R2, D1, D2: in Num_Var; R,D: out Num_Var) is
      T, T1, T2: Num_Var;
      Elc3a: Elementc3a;
   begin
      desreferenciar (d1, r1, t1);
      desreferenciar (d2, r2, t2);
      T := Novavar;
      case P.Tnd is
         when Nsuma =>
            Elc3a := (Suma, T, T1, T2);
         when Nresta =>
            Elc3a := (Resta, T, T1, T2);
         when Nmult =>
            Elc3a := (prod, T, T1, T2);
         when Ndiv =>
            Elc3a := (div, T, T1, T2);
         when Nmod =>
            Elc3a := (Mod3, T, T1, T2);
         when others => null;
      end case;
      Genera (Elc3a);
      R := T;
      d := vnula;
   end Gc_Expr_Arit;


   -- E -> E and E
   -- E -> E or E
   procedure Gc_Expr_log (P: in Pnode; R1, R2, D1, D2: in Num_Var; R,D: out Num_Var) is
      T, T1, T2: Num_Var;
      Elc3a: Elementc3a;
   begin
      desreferenciar (d1, r1, t1);
      desreferenciar (d2, r2, t2);
      T := Novavar;
      case P.Tnd is
         when Nand =>
            Elc3a := (and3, T, T1, T2);
         when Nor =>
            Elc3a := (Or3, T, T1, T2);
         when others => null;
      end case;
      Genera (Elc3a);
      R := T;
      d := vnula;
   end Gc_Expr_log;


   -- E -> E > E
   -- E -> E < E
   -- E -> E >= E
   -- E -> E <= E
   -- E -> E /= E
   -- E -> E = E
   procedure Gc_Expr_Comp (P: in Pnode; R1, R2, D1, D2: in Num_Var; R,D: out Num_Var) is
      T, T1, T2: Num_Var;
      Elc3a: Elementc3a;
      e: etiqueta;
   begin
      Desreferenciar (D1, R1, T1);
      desreferenciar (d2, r2, t2);
      T := Novavar;
      E := Novaetiqueta;
      Elc3a := (Copia, T, Novaconst(Boolean'Pos(False),Ts_Bool));
      Genera (Elc3a);
      case P.Tnd is
         when Nmajor =>
            Elc3a := (menorig, e, T1, T2);
         when Nmenor =>
            Elc3a := (Majorig, e, T1, T2);
         when Nmajorigual =>
            Elc3a := (menor, e, T1, T2);
         when Nmenorigual =>
            Elc3a := (Major, e, T1, T2);
         when Nigual =>
            Elc3a := (diferent, e, T1, T2);
         when Ndif =>
            Elc3a := (Igual, e, T1, T2);
         when others => null;
      end case;
      Genera (Elc3a);
      Elc3a := (Copia, T, Novaconst(Boolean'Pos(True),Ts_bool));
      Genera (Elc3a);
      Elc3a := (Etiq, E);
      Genera (Elc3a);
      R := T;
      d := vnula;
   end Gc_Expr_comp;


   -- E -> not E
   procedure gc_Expr_Not (R1, D1: in Num_Var; R,D: out Num_Var) is
      T, T1: Num_Var;
      Elc3a: Elementc3a;
   begin
      desreferenciar (d1, r1, t1);
      T := Novavar;
      Elc3a := (not3, T, r1);
      Genera (Elc3a);
      R := T;
      d := vnula;
   end gc_Expr_Not;


   -- E -> - E
   procedure gc_Expr_Neg (R1, D1: in Num_Var; R,D: out Num_Var) is
      T, T1: Num_Var;
      Elc3a: Elementc3a;
   begin
      desreferenciar (d1, r1, t1);
      T := Novavar;
      Elc3a := (neg, T, r1);
      Genera (Elc3a);
      R := T;
      d := vnula;
   end gc_Expr_Neg;


   -- E -> ( E )
   procedure Gc_Expr_Parent (R1, D1: in Num_Var; R, D: out Num_Var) is
   begin
      R := R1;
      D := D1;
   end Gc_Expr_Parent;


   -- E -> REF
   procedure Gc_Expr_Ref (P: in Pnode; R, D: out Num_Var) is
      n_proc: num_proc;
   begin
      Gc_Ref (P.N_Exp, N_Proc, R,D);
   end Gc_Expr_Ref;


   -- E -> lit
   procedure Gc_Expr_Lit (p: in pnode; R, D: out Num_Var) is
   begin
      R := Novaconst (P.n_exp.Vl, P.n_exp.Ts);
      d := vnula;
   end Gc_Expr_Lit;


   -- s'executa al començar una llista d'expressions d'una referència.
   procedure Gc_Ref_E (P: in Pnode; Tsb: in tipus_subjacent; Primer: in out Boolean; D: in out Num_Var) is
      N, li, ls : Valor;
      re, de, T1, T2 : Num_Var;
      Elc3a: Elementc3a;
   begin
      gc_E (P, re, de);
      case Tsb is
         when Ts_Arr =>
            if Primer = True then
               primer := false;
               D := re;
            else
               case P.Tnd is
                  when Nsuma..Nnot =>
                     li := P.Li_Expc;
                     ls := P.Ls_Expc;
                  when Neref .. Nelit =>
                     li := P.Li_Exps;
                     ls := P.Ls_Exps;
                  when others => null;
               end case;
               N := Ls - Li + 1;
               t1 := novaVar;
               Elc3a := (Prod, T1, D, Novaconst(N, Ts_Enter));
               Genera (Elc3a);
               T2 := Novavar;
               Elc3a := (Suma, T2, T1, Re);
               genera (Elc3a);
               d := t2;
            end if;
         when Ts_Procp =>
            if Primer = True then
               Crearpila (Pilapar);
               Primer := false;
            END IF;
            Empilar (Pilapar, (Re, De));
         WHEN OTHERS => null;
      end case;
   end Gc_Ref_E;



   procedure gc_m (e: out etiqueta) is
      Elc3a: Elementc3a;
   begin
      e := novaetiqueta;
      elc3a := (etiq, e);
      genera (elc3a);
   end gc_m;


   -- ITERACIO -> while E loop SENTS end loop;
   procedure gc_sent_iter (p: in pnode) is
      efi, ei: etiqueta;
      Elc3a: Elementc3a;
      r, d : num_var;
   begin
      gc_m (ei);
      Gc_E (p.iterac_pexp, R,D);
      efi := novaetiqueta;
      elc3a := (igual, efi, r, novaconst(0, ts_enter));
      Genera (Elc3a);
      if P.Iterac_Psents /= null then
         gc_lista_sents (P.Iterac_Psents);
      end if;
      elc3a := (goto3, ei);
      genera (elc3a);
      elc3a := (etiq, efi);
      genera (elc3a);
   end gc_sent_iter;


   -- CONDICIONAL -> if E then SENTS end if;
   --             | if E then SENTS else SENTS end if;
   procedure gc_sent_cond (p: in pnode) is
      ef, efi: etiqueta;
      Elc3a: Elementc3a;
      r, d : num_var;
   begin
      Gc_E (P.Cond_Pexp, R,D);
      ef := novaetiqueta;
      elc3a := (igual, ef, r, novaconst (0, ts_enter));
      Genera (Elc3a);
      if P.Cond_Psentsif /= null then
         gc_lista_sents (P.Cond_Psentsif);
      end if;
      if p.Cond_Psentselse /= null then
         efi := novaetiqueta;
         elc3a := (goto3, efi);
         genera (elc3a);
         elc3a := (etiq, ef);
         Genera (Elc3a);
         gc_lista_sents (P.Cond_Psentselse);
         elc3a := (etiq, efi);
         genera (elc3a);
      else
         elc3a := (etiq, ef);
         genera (elc3a);
      end if;
   end gc_sent_cond;


   -- CRIDA PROC -> REF;
   procedure gc_llam_proc (p: in pnode) is
      Elc3a: Elementc3a;
      par : infoparam;
      N_Proc : Num_Proc;
      rr, dr: num_var;
   BEGIN
      gc_ref (p.llam_proc_pref, n_proc, rr, dr);
      while not estaBuida (pilaPar) loop
         par := cim (pilaPar);
         Desempilar (PilaPar);
         if par.des = vnula then
            elc3a := (params, par.res);
         else
            elc3a := (paramc, par.res, par.des);
         end if;
         genera (elc3a);
      end loop;
      elc3a := (call, n_proc);
      genera (elc3a);
   end gc_llam_proc;


   -- ASIGNACIÓ -> REF := E;
   procedure gc_sent_asig (p: in pnode) is
      t: num_var;
      Elc3a: Elementc3a;
      re, de, rr, dr: num_var;
      N_Proc : Num_Proc;
   begin
      gc_ref (p.asig_pref, n_proc, rr, dr);
      Gc_E (p.asig_pexp, Re,De);
      desreferenciar (de, re, t);
      if dr = Vnula then
         Elc3a := (Copia, rr, t);
         Genera (Elc3a);
      else
         Elc3a := (asigindex, rr, dr, t);
         Genera (Elc3a);
      end if;
   end gc_sent_asig;

end semantica.g_codi;
