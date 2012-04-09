with decls.d_generals, decls.d_descripcio;
use decls.d_generals, decls.d_descripcio;

package decls.d_arbre is
   pragma pure;

   type node;
   type pnode is access node;
   type tnode is (nprograma, ndproc, nidentificador, nlit, nencap, nparams, nl_param,
                  nparam, ntipus_param, ndecls, ndecl, ndecl_const, ndecl_var,
                  nvalor, nl_id, ndecl_tipus, ndecl_subrang, ndecl_array,
                  ndecl_record, ndecl_camps, ndecl_camp, ncond, nsents, nsent,
                  nassig, nref, nqualifs, nqualif, niteracio, ncrida_proc, nl_exp, nsuma,
                  nresta, nmult, ndiv, nmod, nand, nor, nmajor, nmenor,
                  nmajorigual, nmenorigual, ndif, nigual, nneg, nparent, nnot,
                  neref, nelit);

   type t_param is (p_in, p_in_out);

   type mode is (mdvar, mdconst, mdproc, mdresult);

   type node (tnd: tnode) is record
      case tnd is
         when nidentificador =>
            id: id_nom;
         when nlit =>
            tsubj: tipus_subjacent;
            vl: valor;
         when nprograma =>
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
            decls_pcontllista: pnode;
            decls_pdecl: pnode;
         when ndecl =>
            decl_pdecl_const: pnode;
            decl_pdecl_var: pnode;
            decl_pdecl_tipus: pnode;
            decl_pdecl_proc: pnode;
         when ndecl_const =>
            decl_const_pl_id: pnode;
            decl_const_pidtipus: pnode;
            decl_const_pvalor: pnode;
         when ndecl_var =>
            decl_var_pl_id: pnode;
            decl_var_pidtipus: pnode;
         when nvalor =>
            valor_lit: pnode;
            valor_lit_neg: pnode;
            valor_id: pnode;
            valor_id_neg: pnode;
         when nl_id =>
            l_id_pcontllista: pnode;
            l_id_pid: pnode;
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
            decl_array_pl_id: pnode;
            decl_array_pidtipus: pnode;
         when ndecl_record =>
            decl_record_pid: pnode;
            decl_record_pdecl_camps: pnode;
         when ndecl_camps =>
            decl_camps_pcontllista: pnode;
            decl_camps_pdecl_camp: pnode;
         when ndecl_camp =>
            decl_camp_pid: pnode;
            decl_camp_pidtipus: pnode;
         when nsents =>
            sents_pcontllista: pnode;
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
            assig_pref: pnode;
            assig_pexp: pnode;
         when nref =>
            ref_pid: pnode;
            ref_pcalif: pnode;
         when nqualifs =>
            qualifs_pcontllista: pnode;
            qualifs_pcalif: pnode;
         when nqualif =>
            qualif_pid: pnode;
            qualif_pexp: pnode;
         when niteracio =>
            iter_pexp: pnode;
            iter_psents: pnode;
         when ncrida_proc =>
            crida_proc_pref: pnode;
         when nl_exp =>
            l_exp_pcontllista: pnode;
            l_exp_pexp: pnode;
         when nsuma..nnot =>
            n_oper_exp1: pnode; --CANVIAR
            n_oper_exp2: pnode; --CANVIAR
         when neref | nelit =>
            n_exp: pnode;
      end case;
   end record;

end decls.d_arbre;
