with d_generals, d_descripcio;
use d_generalss, d_descripcio;
package d_arbre is
-- hay mas cosas que en los apuntes
type Node;
   type Pnode is access Node;
   type Tnode is (Nprog, Ndproc, Nident, nlit, natom, Nencap, Ncenc, Nl_Param,
      Nparam, Ntipus_Param, ndecls, ndecl, Ndecl_Const, Ndecl_Var, Nvalor, Nlista_Id,
      ndecl_tipus, Ndecl_Subr, Ndecl_Array, Ndecl_Record, Ndecl_Camps, Ndecl_Camp, Ncond,
      Nsents, Nsent, Nasig, Nref, Ncalfs, Ncalf, Niterac, Nllam_Proc, Nlexp,
      Nsuma, Nresta, Nmult, Ndiv, Nmod, Nand, Nor, Nmajor, Nmenor, Nmajorigual, Nmenorigual,
      Ndif, Nigual, Nneg, Nparent, Nnot, Neref, Nelit   );

   type T_Param is (P_In, P_In_Out);

   type mode is (mdvar, mdconst, mdproc, mdresult);

   type Posicio is record
      Lin,Col: Natural;
   end record;

   type Node (Tnd: Tnode) is record
      case Tnd is
         when Nident =>
            Id: Id_Nom;
            pos1: posicio;
         when Nlit =>
            Ts: T_Descr_Tipus;
            Vl: Valor; Pos2: Posicio;
         when Natom =>
            pos3: posicio;
         when Nprog =>
            Prog_Pproc: Pnode;
         when Ndproc =>
            Dproc_Pencap: Pnode;
            Dproc_Pdecls: Pnode;
            Dproc_Psents: Pnode;
            Dproc_Pidfinal: Pnode;
         when Nencap =>
            Encap_Pidproc: Pnode;
            Encap_Pcenc: Pnode;
         when Ncenc =>
            Cenc_pLpar: Pnode;
         when Nl_Param =>
            L_Param_pL_Param: Pnode;
            L_Param_Pparam: Pnode;
         when Nparam =>
            Param_Pidparam: Pnode;
            Param_Ptipusparam: Pnode;
            Param_Pidtipusparam: Pnode;
         when Ntipus_Param =>
            Tipus_Param: T_Param;
         when Ndecls =>
            Decls_Pcontlista: Pnode;
            Decls_Pdecl: Pnode;
         when Ndecl =>
            Decl_Pdecl_Const: Pnode;
            Decl_Pdecl_var: Pnode;
            Decl_Pdecl_tipus: Pnode;
            Decl_Pdecl_proc: Pnode;
         when Ndecl_Const =>
            Decl_Const_Plistaid: Pnode;
            Decl_Const_Pidtipus: Pnode;
            Decl_Const_Pvalor: Pnode;
         when Ndecl_Var =>
            Decl_Var_Plistaid: Pnode;
            decl_var_pidtipus: pnode;
         when Nvalor =>
            Valor_Lit: Pnode;
            Valor_Lit_Neg: Pnode;
            Valor_id: Pnode;
            Valor_id_neg: Pnode;
         when Nlista_Id =>
            Lista_Id_pContlista: Pnode;
            Lista_Id_Pid: Pnode;
         when Ndecl_Tipus =>
            Decl_Tipus_Pdecl_Subr: Pnode;
            Decl_Tipus_Pdecl_Array: Pnode;
            Decl_Tipus_Pdecl_record: pnode;
         when Ndecl_Subr =>
            Decl_Subr_Pid: Pnode;
            Decl_Subr_Pidtipus: Pnode;
            Decl_Subr_Pvlmin: Pnode;
            Decl_Subr_Pvlmax: Pnode;
         when Ndecl_Array =>
            decl_array_pid: Pnode;
            decl_array_plistaid: Pnode;
            Decl_Array_Pidtipus: Pnode;
         when Ndecl_Record =>
            Decl_Record_Pid: Pnode;
            Decl_Record_Pdecl_Camps: Pnode;
         when Ndecl_Camps =>
            Decl_Camps_Pcontlista: Pnode;
            Decl_Camps_Pdecl_Camp: Pnode;
         when Ndecl_Camp =>
            Decl_Camp_Pid: Pnode;
            Decl_Camp_Pidtipus: Pnode;
         when Nsents =>
            sents_Pcontlista: Pnode;
            sents_Psent: Pnode;
         when Nsent =>
            sent_Pcond: Pnode;
            sent_Pasig: Pnode;
            sent_Piter: Pnode;
            sent_Pllam_proc: Pnode;
         when Ncond =>
            Cond_Pexp: Pnode;
            Cond_Psentsif: Pnode;
            Cond_Psentselse: Pnode;
         when Nasig =>
            Asig_Pref: Pnode;
            Asig_Pexp: Pnode;
         when Nref =>
            Ref_Pid: Pnode;
            Ref_Pcalif: Pnode;
         when Ncalfs =>
            calfs_pcontlista: Pnode;
            Calfs_Pcalif: Pnode;
         when Ncalf =>
            Calf1_Pid: Pnode;
            Calf2_Pexp: Pnode;
         when Niterac =>
            Iterac_Pexp: Pnode;
            Iterac_Psents: Pnode;
         when Nllam_Proc =>
            Llam_Proc_Pref: Pnode;
         when Nlexp =>
            Lexp_Pcontlista: Pnode;
            Lexp_Pexp: Pnode;
         when Nsuma .. Nnot =>
            N_Oper_Exp1: Pnode;
            N_Oper_Exp2: Pnode;
         when Neref | Nelit =>
            n_exp: pnode;
      end case;
   end record;

end d_arbre;
