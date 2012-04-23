with decls.d_generals,decls.d_descripcio,decls.d_taulasimbols;
use decls.d_generals,decls.d_descripcio,decls.d_taulasimbols;

package Decls.d_c3a is
   pragma Pure;
   -- Taula de procediments

   type modproc is (ploc, pext); -- local i extern

   type infoproc(mode: modproc:= pext) is record
      prof: niv_prof;
      ocupvl, ocuppar: desplacament;
      nparam: integer;
      idproc: id_nom;
      case mode is
         when Pext =>
            null;
         when Ploc =>
            e: etiqueta;
      end case;
   end record;

   type Tprocediments is array (Num_Proc'First+1 .. Num_Proc'Last) of Infoproc;

   -- Taula de variables

   type modvar is (mvar, mconst);

   type infovar(mode: ModVar := mvar) is record
      Idvar: Id_Nom;
      espar: boolean; -- ens diu si es un paràmetre o variable
      case mode is
         when mvar =>
            desp: desplacament;
            ocup: desplacament;
            np: num_Proc;
         when mconst =>
            val: Valor;
            Tsub: tipus_subjacent;
            nconst: integer;
      end case;
   end record;

   type Tvariables is array (Num_Var'First+1 .. Num_Var'Last) of Infovar;

   -- Codi 3@
   type RepertoriInstruccions is
     (Suma, Resta, Prod, Div, Mod3, And3, Or3, Not3,                       -- aritmetic-lògiques
      Copia, Asigindex, Consindex,                                       -- còpia
      Etiq, Goto3, Menor, MenorIg, Igual, Diferent, MajorIg, Major, Neg,  -- bot
      Call, Rtn, Pmb, Params, Paramc);                               -- crida procediment

   type ElementC3a(Ti: RepertoriInstruccions := Rtn) is record
      case Ti is
         -- etiq E | goto E
         when Etiq | Goto3 =>
            E: etiqueta;
            -- call Proc
         when Call =>
            CallProc: num_proc;
            -- preamb Proc
         when Pmb =>
            PmbProc: num_proc;
            -- rtn
         when Rtn =>
            RtnProc: num_proc;
            -- param simple A
         when Params  =>
            ParamCampA: num_var;
            -- Param compost A,B
         when Paramc =>
            ParamcCampA, ParamcCampB: num_var;
            -- Operacio E,A,B
         when Menor | MenorIg | Igual | Diferent | MajorIg | Major =>
            IfEtiq: etiqueta;
            IfCampA, IfCampB: num_var;
            -- Copia A,B | Neg A,B | Not A,B
         when Copia | Neg | Not3 =>
            CampA, CampB: num_var;
            -- Assigindex A,B,C
         when Asigindex =>
            AsigCampA, AsigCampB, AsigCampC: num_var;
            -- Consindex A,B,C
         when Consindex =>
            ConsCampA, ConsCampB, ConsCampC: num_var;
            -- Operacio A,B,C
         when Suma | Resta | Prod | Div | Mod3 | And3 | Or3 =>
            ALCampA, ALCampB, ALCampC: num_var;
      end case;
   end record;

   type infoparam is record
      res, des: num_var;
   end record;

end Decls.D_c3a;

