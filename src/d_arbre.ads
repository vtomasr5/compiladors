with d_generals, d_descripcio;
use d_generals, d_descripcio;

package d_arbre is
   type node;
   type pnode is access node;
   type tnode is (nprog, ndproc, nident, nlit, natom, nencap, nparams, nl_param,
                  nparam, ntipus_param, ndecls, ndecl, ndecl_const, ndecl_var,
                  nvalor, nlista_id, ndecl_tipus, ndecl_subrang, ndecl_array,
                  ndecl_record, ndecl_camps, ndecl_camp, ncond, nsents, nsent,
                  nassig, nref, nqualifs, nqualif, niter, ncrida_proc, nl_exp, nsuma,
                  nresta, nmult, ndiv, nmod, nand, nor, nmajor, nmenor,
                  nmajorigual, nmenorigual, ndif, nigual, nneg, nparent, nnot,
                  neref, nelit);

   type t_param is (p_in, p_in_out);

   type mode is (mdvar, mdconst, mdproc, mdresult);

   type posicio is record
      lin, col: natural;
   end record;

   type node (tnd: tnode) is record
      case tnd is
         when nident =>
            id: id_nom;
            pos1: posicio;
         when nlit =>
            tsubj: tipus_subjacent;
            vl: valor; pos2: posicio;
         when natom =>
            pos3: posicio;
         when nprog =>
            prog_pproc: pnode;
         when ndproc =>
            dproc_pencap: pnode;
            dproc_pdecls: pnode;
            dproc_psents: pnode;
            dproc_pidfinal: pnode;
         when nencap =>
            encap_pidproc: pnode;
            encap_pcenc: pnode;
         when nparams =>
            params_plpar: pnode;
         when nl_param =>
            l_param_pl_param: pnode;
            l_param_pparam: pnode;
         when nparam =>
            param_pidparam: pnode;
            param_ptipusparam: pnode;
            param_pidtipusparam: pnode;
         when ntipus_param =>
            tipus_param: t_param;
         when ndecls =>
            decls_pcontlista: pnode;
            decls_pdecl: pnode;
         when ndecl =>
            decl_pdecl_const: pnode;
            decl_pdecl_var: pnode;
            decl_pdecl_tipus: pnode;
            decl_pdecl_proc: pnode;
         when ndecl_const =>
            decl_const_plistaid: pnode;
            decl_const_pidtipus: pnode;
            decl_const_pvalor: pnode;
         when ndecl_var =>
            decl_var_plistaid: pnode;
            decl_var_pidtipus: pnode;
         when nvalor =>
            valor_lit: pnode;
            valor_lit_neg: pnode;
            valor_id: pnode;
            valor_id_neg: pnode;
         when nlista_id =>
            lista_id_pcontlista: pnode;
            lista_id_pid: pnode;
         when ndecl_tipus =>
            decl_tipus_pdecl_subr: pnode;
            decl_tipus_pdecl_array: pnode;
            decl_tipus_pdecl_record: pnode;
         when ndecl_subrang =>
            decl_subrang_pid: pnode;
            decl_subrang_pidtipus: pnode;
            decl_subrang_pvlmin: pnode;
            decl_subrang_pvlmax: pnode;
         when ndecl_array =>
            decl_array_pid: pnode;
            decl_array_plistaid: pnode;
            decl_array_pidtipus: pnode;
         when ndecl_record =>
            decl_record_pid: pnode;
            decl_record_pdecl_camps: pnode;
         when ndecl_camps =>
            decl_camps_pcontlista: pnode;
            decl_camps_pdecl_camp: pnode;
         when ndecl_camp =>
            decl_camp_pid: pnode;
            decl_camp_pidtipus: pnode;
         when nsents =>
            sents_pcontlista: pnode;
            sents_psent: pnode;
         when nsent =>
            sent_pcond: pnode;
            sent_pasig: pnode;
            sent_piter: pnode;
            sent_pllam_proc: pnode;
         when ncond =>
            cond_pexp: pnode;
            cond_psentsif: pnode;
            cond_psentselse: pnode;
         when nassig =>
            asig_pref: pnode;
            asig_pexp: pnode;
         when nref =>
            ref_pid: pnode;
            ref_pcalif: pnode;
         when nqualifs =>
            calfs_pcontlista: pnode;
            calfs_pcalif: pnode;
         when nqualif =>
            calf1_pid: pnode;
            calf2_pexp: pnode;
         when niter =>
            iterac_pexp: pnode;
            iterac_psents: pnode;
         when ncrida_proc =>
            crida_proc_pref: pnode;
         when nl_exp =>
            l_exp_pcontlista: pnode;
            l_exp_pexp: pnode;
         when nsuma..nnot =>
            n_oper_exp1: pnode;
            n_oper_exp2: pnode;
         when neref | nelit =>
            n_exp: pnode;
      end case;
   end record;

end d_arbre;
