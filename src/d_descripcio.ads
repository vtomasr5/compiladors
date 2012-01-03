with d_generals;
use d_generals;

package d_descripcio is
   --     pragma Pure;

   type tipus_descripcio is (dnul_la, dconst, dvar, dtipus, dproc, dparam, dcamp, dindex);

   type t_descr_tipus is (ts_nul, ts_bool, ts_car, ts_enter, ts_arr, ts_rec, ts_procc, ts_procp);

   type descr_tipus (td: t_descr_tipus := ts_nul) is record
      ocup: despl;
      case td is
         when ts_nul | ts_rec | ts_procc | ts_procp => null;
         when ts_bool | ts_car | ts_enter =>
            li, ls: valor;
         when ts_arr =>
            tcomp: id_nom;
            b: valor;
      end case;
   end record;

   type descripcio (td: tipus_descripcio := dnul_la) is record
      case td is
         when Dnul_La =>
            null;
         when Dconst =>
            Dconst_Tp: Id_Nom;
            Dconst_Vl : Valor;
            dconst_nv : num_var;
         when Dvar =>
            Dvar_Tp : Id_Nom;
            dvar_nv : num_var;
         when Dtipus =>
            dtipus_dt : descr_tipus;
         when Dproc =>
            dproc_np: num_proc;
         when Dparam =>
            Dparam_Tp: Id_Nom;
            dparam_nv: num_var;
         when Dcamp =>
            Dcamp_Ds: Despl;
            dcamp_tp : id_nom;
         when Dindex =>
            dindex_id: id_nom;
      end case;
   end record;

end d_descripcio;
