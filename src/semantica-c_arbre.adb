with Semantica.c_tipus, Decls.D_Descripcio, Semantica.G_codi;
use Semantica.c_tipus,Decls.D_Descripcio, Semantica.G_codi;

package body semantica.C_Arbre is

   Arrel, Nom_Final: Pnode;

   procedure Rs_Inicialitzar_Analisis (nombref: in string) is
   begin
      error_comp := false;
      tbuida(tn);
      Tbuida(Ts);
      nv := num_var'first;
      Np := Num_Proc'First;
      nc := 0;
      entra_bloc(ts);
      Ct_Inic;
      gc_prepara(nombref);
   end rs_Inicialitzar_analisis;

   procedure rs_finalitzar_analisis is
   begin
      Ct_Declproc (arrel, nom_final.Id, nom_final.pos1.lin, nom_final.pos1.col);
      Gc_Dproc (arrel);
      ct_conclueix;
      gc_finalitza;
      surt_bloc(ts);
   end rs_finalitzar_analisis;

   procedure Rs_Aturar_Analisis is
   begin
      Error_Comp := True;
      Ct_Conclueix;
   end Rs_Aturar_Analisis;

   procedure Rl_Identificador (pident: out Pnode; Nom: in String;
                               L,C: in Natural) is
      Id: Id_Nom;
      p: posicio;
   begin
      p :=(l,c);
      Afegir_Id (tn, Id, Nom);
      Pident := new Node (Nident);
      Pident.Id := Id;
      Pident.Pos1 := P;
   end Rl_Identificador;

   procedure Rl_Literal_String (Pstring: out Pnode; Nom: in String;
                                L,C: in Natural) is
      Id: Id_String;
      p: posicio;
   begin
      p :=(l,c);
      Afegir_Str (tn, Id, Nom (Nom'First..Nom'Last));
      Pstring := new Node (Nlit);
      pstring.ts := Ts_arr;
      Pstring.Vl := Valor (Id);
      Pstring.Pos2 := P;
   end Rl_Literal_String;

   procedure Rl_Literal_caracter (Pcar: out Pnode; Nom: in String;
                                  L,C: in Natural) is
      p: posicio;
   begin
      p :=(l,c);
      Pcar := new Node (Nlit);
      pcar.ts := Ts_car;
      Pcar.Vl := Valor (Character'Pos(Nom(2)));
      Pcar.Pos2 := P;
   end Rl_Literal_Caracter;

   procedure Rl_Literal_enter (Pent: out Pnode; Nom: in String;
                               L,C: in Natural) is
      p: posicio;
   begin
      p :=(l,c);
      Pent := new Node (Nlit);
      Pent.ts := Ts_Enter;
      Pent.Vl := Valor (Integer'Value(Nom));
      Pent.Pos2 := P;
   end Rl_Literal_Enter;

   procedure Rl_atom (Pent: out Pnode; L,C: in Natural) is
      p: posicio;
   begin
      p :=(l,c);
      Pent := new Node (Natom);
      Pent.Pos3 := P;
   end Rl_Atom;

   procedure Rs_Programa (Pprog: out Pnode; Pdecl_Proc: in Pnode) is
   begin
      Pprog := new Node (Nprog);
      Pprog.Prog_Pproc := Pdecl_Proc;
   end Rs_Programa;

   procedure Rs_Decl_Proc (Pdecl_Proc: out Pnode;
                           Pencap, Pdecls, Psents, Pidfinal: in Pnode) is
   begin
      Pdecl_Proc := new Node (Ndproc);
      Pdecl_Proc.Dproc_Pencap := Pencap;
      pdecl_proc.dproc_pdecls := pdecls;
      Pdecl_Proc.Dproc_Psents := Psents;
      Pdecl_Proc.Dproc_Pidfinal := Pidfinal;
      Arrel := Pdecl_Proc;
      nom_final := Pidfinal;
   end Rs_Decl_Proc;

   procedure Rs_Encap (Pencap: out Pnode; Pid_Proc, Pcenc: in Pnode) is
   begin
      Pencap := new Node (Nencap);
      Pencap.Encap_Pidproc := Pid_Proc;
      Pencap.Encap_Pcenc := Pcenc;
      Pencap.Encap_Pnumproc := num_proc (0);
   end Rs_Encap;

   procedure Rs_Params (Pcenc: out Pnode; Pl_Param: in Pnode) is
   begin
      Pcenc := new Node (ncenc);
      Pcenc.Cenc_Plpar := Pl_Param;
   end Rs_Params;

   procedure Rs_Params (Pcenc: out Pnode) is
   begin
      Pcenc := new Node (ncenc);
      Pcenc.Cenc_Plpar := null;
   end Rs_Params;

   procedure Rs_L_Param (Pl_Param: out Pnode; Pl_Param2, Pparam: in Pnode) is
   begin
      Pl_Param := new Node (nl_param);
      Pl_Param.L_Param_Pl_Param := Pl_Param2;
      Pl_Param.L_Param_Pparam := Pparam;
   end Rs_L_Param;

   procedure Rs_L_Param (Pl_Param: out Pnode; Pparam: in Pnode) is
   begin
      Pl_Param := new Node (Nl_Param);
      Pl_Param.L_Param_Pl_Param := null;
      Pl_Param.L_Param_Pparam := Pparam;
   end Rs_L_Param;

   procedure Rs_Param (Pparam: out Pnode;
                       Pidparam, Ptipusparam, Pidtipusparam: in Pnode) is
   begin
      Pparam := new Node (Nparam);
      Pparam.Param_Pidparam := Pidparam;
      Pparam.Param_Ptipusparam := Ptipusparam;
      Pparam.Param_Pidtipusparam := Pidtipusparam;
   end Rs_Param;

   procedure Rs_mode_in (Ptipus_Param: out Pnode) is
   begin
      Ptipus_Param := new Node (Ntipus_Param);
      Ptipus_Param.Tipus_Param := P_In;
   end Rs_mode_in;

   procedure Rs_mode_out (Ptipus_Param: out Pnode) is
   begin
      Ptipus_Param := new Node (Ntipus_Param);
      Ptipus_Param.Tipus_Param := P_In_out;
   end Rs_mode_out;

   procedure Rs_declaracions (Pdecls: out Pnode; pcontlista, pdecl: in pnode) is
   begin
      Pdecls := new Node (Ndecls);
      Pdecls.Decls_Pcontlista := Pcontlista;
      Pdecls.Decls_Pdecl := Pdecl;
   end Rs_declaracions;

   procedure Rs_declaracions (Pdecls: out Pnode) is
   begin
      Pdecls := new Node (Ndecls);
      Pdecls.Decls_Pcontlista := null;
      Pdecls.Decls_Pdecl := null;
   end Rs_declaracions;

   procedure rs_declaracio_const (Pdecl: out Pnode; pdecl_const: in pnode) is
   begin
      Pdecl := new Node (Ndecl);
      Pdecl.Decl_Pdecl_Const := pdecl_const;
      Pdecl.Decl_Pdecl_Var := null;
      Pdecl.Decl_Pdecl_tipus := null;
      Pdecl.Decl_Pdecl_Proc := null;
   end rs_declaracio_const;

   procedure rs_declaracio_var (Pdecl: out Pnode; pdecl_var: in pnode) is
   begin
      Pdecl := new Node (Ndecl);
      Pdecl.Decl_Pdecl_Const := null;
      Pdecl.Decl_Pdecl_Var := Pdecl_var;
      Pdecl.Decl_Pdecl_tipus := null;
      Pdecl.Decl_Pdecl_Proc := null;
   end rs_declaracio_var;

   procedure rs_declaracio_tipus (Pdecl: out Pnode; pdecl_tipus: in pnode) is
   begin
      Pdecl := new Node (Ndecl);
      Pdecl.Decl_Pdecl_Const := null;
      Pdecl.Decl_Pdecl_Var := null;
      Pdecl.Decl_Pdecl_tipus := pdecl_tipus;
      Pdecl.Decl_Pdecl_Proc := null;
   end rs_declaracio_tipus;

   procedure rs_declaracio_proc (Pdecl: out Pnode; pdecl_proc: in pnode) is
   begin
      Pdecl := new Node (Ndecl);
      Pdecl.Decl_Pdecl_Const := null;
      Pdecl.Decl_Pdecl_Var := null;
      Pdecl.Decl_Pdecl_tipus := null;
      Pdecl.Decl_Pdecl_Proc := Pdecl_Proc;
   end rs_declaracio_proc;

   procedure Rs_Decl_Const (Pdecl_Const: out Pnode;
                            Plistaid, Pidtipus, Pvalor: in Pnode) is
   begin
      Pdecl_Const := new Node (Ndecl_const);
      Pdecl_Const.Decl_Const_Plistaid := Plistaid;
      Pdecl_Const.Decl_Const_Pidtipus := Pidtipus;
      Pdecl_Const.Decl_Const_Pvalor := Pvalor;
   end Rs_Decl_Const;

   procedure rs_valor_literal (Pvalor: out Pnode; Plit: in Pnode) is
   begin
      Pvalor := new Node (Nvalor);
      Pvalor.Valor_Lit := Plit;
      Pvalor.Valor_Lit_Neg := null;
      Pvalor.Valor_id := null;
      Pvalor.Valor_id_Neg := null;
   end rs_valor_literal;

   procedure rs_valor_s_menys (Pvalor: out Pnode; Plit_neg: in Pnode) is
   begin
      Pvalor := new Node (Nvalor);
      Pvalor.Valor_Lit := null;
      Pvalor.Valor_Lit_Neg := Plit_neg;
      Pvalor.Valor_id := null;
      Pvalor.Valor_id_Neg := null;
   end rs_valor_s_menys;

   procedure rs_valor_id (Pvalor: out Pnode; Pid: in Pnode) is
   begin
      Pvalor := new Node (Nvalor);
      Pvalor.Valor_Lit := null;
      Pvalor.Valor_Lit_Neg := null;
      Pvalor.Valor_id := pid;
      Pvalor.Valor_id_Neg := null;
   end rs_valor_id;

   procedure rs_valor_s_menys_id (Pvalor: out Pnode; Pid_neg: in Pnode) is
   begin
      Pvalor := new Node (Nvalor);
      Pvalor.Valor_Lit := null;
      Pvalor.Valor_Lit_Neg := null;
      Pvalor.Valor_id := null;
      Pvalor.Valor_id_Neg := pid_neg;
   end rs_valor_s_menys_id;

   procedure Rs_Decl_Var (Pdecl_Var: out Pnode; Plistaid, Pidtipus: in Pnode) is
   begin
      Pdecl_Var := new Node (Ndecl_Var);
      Pdecl_Var.Decl_Var_Plistaid := Plistaid;
      Pdecl_Var.Decl_Var_Pidtipus := Pidtipus;
   end Rs_Decl_Var;

   procedure rs_l_id (Plista_id: out Pnode; Pcontlista, Pid: in Pnode) is
   begin
      Plista_Id := new Node (Nlista_Id);
      Plista_Id.Lista_Id_Pcontlista := Pcontlista;
      Plista_Id.Lista_Id_Pid := Pid;
   end rs_l_id;

   procedure rs_l_id (Plista_id: out Pnode; Pid: in Pnode) is
   begin
      Plista_Id := new Node (Nlista_Id);
      Plista_Id.Lista_Id_Pcontlista := null;
      Plista_Id.Lista_Id_Pid := Pid;
   end rs_l_id;

   procedure rs_decl_tipus_subrang (Pdecl_tipus: out Pnode;
                                    Pdecl_subr: in Pnode) is
   begin
      Pdecl_tipus := new Node (Ndecl_Tipus);
      Pdecl_tipus.Decl_Tipus_Pdecl_Subr := Pdecl_subr;
      Pdecl_Tipus.Decl_Tipus_Pdecl_Array := null;
      Pdecl_tipus.Decl_Tipus_Pdecl_record := null;
   end rs_decl_tipus_subrang;

   procedure rs_decl_tipus_array (Pdecl_tipus: out Pnode;
                                  Pdecl_array: in Pnode) is
   begin
      Pdecl_tipus := new Node (Ndecl_Tipus);
      Pdecl_tipus.Decl_Tipus_Pdecl_Subr := null;
      Pdecl_Tipus.Decl_Tipus_Pdecl_Array := Pdecl_array;
      Pdecl_tipus.Decl_Tipus_Pdecl_record := null;
   end rs_decl_tipus_array;

   procedure rs_decl_tipus_record (Pdecl_tipus: out Pnode;
                                   Pdecl_record: in Pnode) is
   begin
      Pdecl_tipus := new Node (Ndecl_Tipus);
      Pdecl_tipus.Decl_Tipus_Pdecl_Subr := null;
      Pdecl_Tipus.Decl_Tipus_Pdecl_Array := null;
      Pdecl_tipus.Decl_Tipus_Pdecl_record := Pdecl_record;
   end rs_decl_tipus_record;

   procedure rs_decl_subrang (Pdecl_Subr: out Pnode;
                              Pid, Pidtipus, Pvlmin, Pvlmax: in Pnode) is
   begin
      Pdecl_Subr := new Node (Ndecl_Subr);
      Pdecl_Subr.Decl_Subr_Pid := Pid;
      Pdecl_Subr.Decl_Subr_Pidtipus := Pidtipus;
      Pdecl_Subr.Decl_Subr_Pvlmin := Pvlmin;
      Pdecl_Subr.Decl_Subr_Pvlmax := Pvlmax;
   end rs_decl_subrang;

   procedure Rs_Decl_Array (Pdecl_Array: out Pnode;
                            Pid, Plistaid, Pidtipus: in Pnode) is
   begin
      Pdecl_Array := new Node (Ndecl_Array);
      pdecl_Array.Decl_Array_Pid := Pid;
      pdecl_Array.decl_array_plistaid := plistaid;
      Pdecl_Array.Decl_Array_Pidtipus := Pidtipus;
   end Rs_Decl_Array;

   procedure Rs_Decl_record (Pdecl_record: out Pnode;
                             Pid, pdecl_camps: in Pnode) is
   begin
      Pdecl_record := new Node (Ndecl_Record);
      pdecl_record.Decl_Record_Pid := Pid;
      Pdecl_Record.Decl_Record_Pdecl_Camps := Pdecl_Camps;
   end Rs_Decl_Record;

   procedure Rs_Decl_camps (Pdecl_camps: out Pnode;
                            Pcontlista, pdecl_camp: in Pnode) is
   begin
      Pdecl_camps := new Node (Ndecl_Camps);
      pdecl_camps.Decl_Camps_Pcontlista := Pcontlista;
      pdecl_camps.decl_camps_pdecl_camp := pdecl_camp;
   end Rs_Decl_Camps;

   procedure Rs_Decl_camps (Pdecl_camps: out Pnode) is
   begin
      Pdecl_camps := new Node (Ndecl_Camps);
      pdecl_camps.Decl_Camps_Pcontlista := null;
      pdecl_camps.decl_camps_pdecl_camp := null;
   end Rs_Decl_Camps;

   procedure Rs_Decl_camp (Pdecl_camp: out Pnode; Pid, pidtipus: in Pnode) is
   begin
      Pdecl_camp := new Node (Ndecl_Camp);
      pdecl_camp.Decl_Camp_Pid := Pid;
      pdecl_camp.decl_camp_pidtipus := pidtipus;
   end Rs_Decl_Camp;

   procedure rs_sentencies (Psents: out Pnode; pcontlista, psent: in pnode) is
   begin
      Psents := new Node (Nsents);
      Psents.sents_Pcontlista := Pcontlista;
      Psents.Sents_Psent := Psent;
   end rs_sentencies;

   procedure rs_sentencies (Psents: out Pnode; psent: in pnode) is
   begin
      Psents := new Node (Nsents);
      Psents.sents_Pcontlista := null;
      Psents.Sents_Psent := Psent;
   end rs_sentencies;

   procedure rs_sent_cond (Psent: out Pnode; pcond: in pnode) is
   begin
      Psent := new Node (Nsent);
      Psent.sent_Pcond := pcond;
      Psent.sent_Pasig := null;
      Psent.sent_Piter := null;
      Psent.Sent_Pllam_Proc := null;
   end rs_sent_cond;

   procedure rs_sent_assig (Psent: out Pnode; pasig: in pnode) is
   begin
      Psent := new Node (Nsent);
      Psent.sent_Pcond := null;
      Psent.sent_Pasig := pasig;
      Psent.sent_Piter := null;
      Psent.Sent_Pllam_Proc := null;
   end rs_sent_assig;

   procedure rs_sent_iter (Psent: out Pnode; piter: in pnode) is
   begin
      Psent := new Node (Nsent);
      Psent.sent_Pcond := null;
      Psent.sent_Pasig := null;
      Psent.sent_Piter := piter;
      Psent.Sent_Pllam_Proc := null;
   end rs_sent_iter;

   procedure rs_sent_proc (Psent: out Pnode; pllam_proc: in pnode) is
   begin
      Psent := new Node (Nsent);
      Psent.sent_Pcond := null;
      Psent.sent_Pasig := null;
      Psent.sent_Piter := null;
      Psent.Sent_Pllam_Proc := Pllam_Proc;
   end rs_sent_proc;

   procedure Rs_cond (Pcond: out Pnode; Pexp, psents: in Pnode) is
   begin
      Pcond := new Node (Ncond);
      Pcond.Cond_Pexp := Pexp;
      Pcond.Cond_Psentsif := Psents;
      Pcond.Cond_Psentselse := null;
   end Rs_Cond;

   procedure Rs_cond (Pcond: out Pnode;
                      Pexp2, Psents2if, psents2else: in Pnode) is
   begin
      Pcond := new Node (Ncond);
      Pcond.Cond_Pexp := Pexp2;
      Pcond.Cond_Psentsif := Psents2if;
      Pcond.Cond_Psentselse := psents2else;
   end Rs_Cond;

   procedure rs_assignacio (Pasig: out Pnode; Pref, pexp: in Pnode) is
   begin
      Pasig := new Node (nasig);
      Pasig.Asig_Pref := Pref;
      Pasig.asig_pexp := pexp;
   end rs_assignacio;

   procedure Rs_ref (pref: out Pnode; Pid, pcalif: in Pnode) is
   begin
      pref := new Node (Nref);
      pref.Ref_Pid := Pid;
      pref.ref_pcalif := pcalif;
   end Rs_Ref;

   procedure rs_qualifs (pcalfs: out Pnode; pcontlista, pcalif: in Pnode) is
   begin
      pcalfs := new Node (Ncalfs);
      pcalfs.calfs_pcontlista := pcontlista;
      pcalfs.calfs_pcalif := pcalif;
   end rs_qualifs;

   procedure rs_qualifs (pcalfs: out Pnode) is
   begin
      pcalfs := new Node (Ncalfs);
      pcalfs.calfs_pcontlista := null;
      pcalfs.calfs_pcalif := null;
   end rs_qualifs;

   procedure rs_qualif_simple (pcalf: out Pnode; Pid: in Pnode) is
   begin
      pcalf := new Node (Ncalf);
      Pcalf.Calf1_Pid := Pid;
      pcalf.Calf2_Pexp := null;
   end rs_qualif_simple;

   procedure rs_qualif_complex (pcalf: out Pnode; Pexp: in Pnode) is
   begin
      Pcalf := new Node (Ncalf);
      Pcalf.Calf1_Pid := null;
      pcalf.Calf2_Pexp := Pexp;
   end rs_qualif_complex;

   procedure rs_iteracio (piter: out Pnode; Pexp, psents: in Pnode) is
   begin
      piter := new Node (Niterac);
      Piter.Iterac_Pexp := Pexp;
      piter.iterac_psents := psents;
   end rs_iteracio;

   procedure rs_crida_procediment (pllam_proc: out pnode; Pref: in Pnode) is
   begin
      pllam_proc := new Node (Nllam_proc);
      pllam_proc.llam_proc_pref := Pref;
   end rs_crida_procediment;

   procedure rs_l_e (pl_exp: out pnode; Pcontlista, Pexp: in Pnode) is
   begin
      pl_exp := new Node (Nlexp);
      Pl_Exp.Lexp_Pcontlista := Pcontlista;
      pl_exp.Lexp_Pexp := Pexp;
   end rs_l_e;

   procedure rs_l_e (pl_exp: out pnode; Pexp: in Pnode) is
   begin
      Pl_Exp := new Node (Nlexp);
      Pl_Exp.Lexp_Pcontlista := null;
      pl_exp.Lexp_Pexp := Pexp;
   end rs_l_e;

   procedure Rs_suma (psuma: out pnode; Pexp1, pexp2: in Pnode) is
   begin
      psuma := new Node (Nsuma);
      Psuma.N_Oper_Exp1 := Pexp1;
      psuma.n_oper_exp2 := Pexp2;
   end Rs_Suma;

   procedure Rs_resta (presta: out pnode; Pexp1, pexp2: in Pnode) is
   begin
      presta := new Node (Nresta);
      presta.N_Oper_Exp1 := Pexp1;
      presta.n_oper_exp2 := Pexp2;
   end Rs_Resta;

   procedure Rs_mult (pmult: out pnode; Pexp1, pexp2: in Pnode) is
   begin
      pmult := new Node (Nmult);
      Pmult.N_Oper_Exp1 := Pexp1;
      pmult.n_oper_exp2 := Pexp2;
   end Rs_Mult;

   procedure Rs_div (pdiv: out pnode; Pexp1, pexp2: in Pnode) is
   begin
      pdiv := new Node (Ndiv);
      pdiv.N_Oper_Exp1 := Pexp1;
      pdiv.n_oper_exp2 := Pexp2;
   end Rs_Div;

   procedure Rs_mod (pmod: out pnode; Pexp1, pexp2: in Pnode) is
   begin
      pmod := new Node (Nmod);
      Pmod.N_Oper_Exp1 := Pexp1;
      pmod.n_oper_exp2 := Pexp2;
   end Rs_Mod;

   procedure Rs_and (pand: out pnode; Pexp1, pexp2: in Pnode) is
   begin
      pand := new Node (Nand);
      pand.N_Oper_Exp1 := Pexp1;
      pand.n_oper_exp2 := Pexp2;
   end Rs_And;

   procedure Rs_or (por: out pnode; Pexp1, pexp2: in Pnode) is
   begin
      por := new Node (Nor);
      Por.N_Oper_Exp1 := Pexp1;
      por.n_oper_exp2 := Pexp2;
   end Rs_Or;

   procedure Rs_major (pmajor: out pnode; Pexp1, pexp2: in Pnode) is
   begin
      pmajor := new Node (Nmajor);
      pmajor.N_Oper_Exp1 := Pexp1;
      pmajor.n_oper_exp2 := Pexp2;
   end Rs_Major;

   procedure Rs_menor (pmenor: out pnode; Pexp1, pexp2: in Pnode) is
   begin
      pmenor := new Node (Nmenor);
      Pmenor.N_Oper_Exp1 := Pexp1;
      pmenor.n_oper_exp2 := Pexp2;
   end Rs_Menor;

   procedure Rs_majorig (pmajorig: out pnode; Pexp1, pexp2: in Pnode) is
   begin
      pmajorig := new Node (Nmajorigual);
      pmajorig.N_Oper_Exp1 := Pexp1;
      pmajorig.n_oper_exp2 := Pexp2;
   end Rs_Majorig;

   procedure Rs_menorig (pmenorig: out pnode; Pexp1, pexp2: in Pnode) is
   begin
      pmenorig := new Node (Nmenorigual);
      pmenorig.N_Oper_Exp1 := Pexp1;
      pmenorig.n_oper_exp2 := Pexp2;
   end Rs_Menorig;

   procedure Rs_dif (pdif: out pnode; Pexp1, pexp2: in Pnode) is
   begin
      pdif := new Node (Ndif);
      Pdif.N_Oper_Exp1 := Pexp1;
      pdif.n_oper_exp2 := Pexp2;
   end Rs_Dif;

   procedure Rs_igual (pigual: out pnode; Pexp1, pexp2: in Pnode) is
   begin
      pigual := new Node (Nigual);
      pigual.N_Oper_Exp1 := Pexp1;
      pigual.n_oper_exp2 := Pexp2;
   end Rs_Igual;

   procedure Rs_neg (pneg: out pnode; Pexp: in Pnode) is
   begin
      pneg := new Node (Nneg);
      Pneg.N_Oper_Exp1 := Pexp;
      pneg.n_oper_exp2 := null;
   end Rs_Neg;

   procedure Rs_parent (pparent: out pnode; Pexp: in Pnode) is
   begin
      pparent := new Node (Nparent);
      Pparent.N_Oper_Exp1 := Pexp;
      pparent.n_oper_exp2 := null;
   end Rs_Parent;

   procedure Rs_not (pnot: out pnode; Pexp: in Pnode) is
   begin
      pnot := new Node (Nnot);
      Pnot.N_Oper_Exp1 := Pexp;
      pnot.n_oper_exp2 := null;
   end Rs_Not;

   procedure Rs_Eref (Peref: out Pnode; Pexp: in Pnode) is
   begin
      Peref := new Node (Neref);
      Peref.N_Exp := Pexp;
   end Rs_Eref;

   procedure Rs_Elit (Pelit: out Pnode; Pexp: in Pnode) is
   begin
      Pelit := new Node (Nelit);
      Pelit.N_Exp := Pexp;
   end Rs_Elit;

end semantica.C_Arbre;
