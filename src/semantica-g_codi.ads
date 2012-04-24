--with Ada.Sequential_IO, Ada.Text_IO;
with decls.d_descripcio, decls.d_arbre, decls.d_generals;
use decls.d_descripcio, decls.d_arbre,decls.d_generals;

package Semantica.g_codi is

   procedure Gc_Prepara (Nom: in String);
   procedure Gc_finalitza;
   procedure Gc_Dproc (P: in Pnode);

   --AIXO NO IMPRIMIR PER AQUESTA ENTREGA
   --package fitxers is new Ada.Sequential_IO(ElementC3a);
   --c3a: fitxers.File_Type;
   --c3at: Ada.Text_IO.File_Type;
   --     num_Etiq: integer;

private

   procedure Gc_Lista_Decls (P: in Pnode);
   procedure gc_lista_sents (p: in pnode);
   procedure gc_Sent (p: in pnode);
   procedure Gc_Dencap (P: in Pnode; N_Proc: out Num_Proc);
   procedure Gc_Ref (P: in Pnode; n_proc: out num_proc; r,d: out num_var);
   procedure Gc_Calfs (P: in Pnode; D: in out Num_Var; Idt: in out Id_Nom;
                       Tsb: in out tipus_subjacent);
   procedure gc_Calf (P: in Pnode; d : in out num_var; idt: in out id_nom;
                      tsb: in out tipus_subjacent);
   procedure gc_ref_id (p: in pnode; d,r : out num_var; idt: out id_nom;
                        n_proc: out num_proc; tsb: out tipus_subjacent);
   procedure gc_Ref_Id (P: in Pnode; d: in out num_var; idt: in out id_nom;
                        tsb: out tipus_subjacent);
   procedure Gc_Ref_Listae (P: in Pnode; Idt: in out Id_Nom;
                            tsb: in tipus_subjacent; primer: in out boolean;
                            db: in out num_var; d: in out num_var);
   procedure Gc_Ref_Finlista (Idt: in out Id_Nom; Tsb: in tipus_subjacent;
                              D: in out Num_Var; da: in out num_var;
                              base: in valor; ocup: in desplacament;
                              tipus_comp: in id_nom);
   procedure Gc_E (P: in Pnode; R,D: out Num_Var);
   procedure desreferenciar (d, r: in num_var; x: out num_var);
   procedure Gc_Expr_Arit (P: in Pnode; R1, R2, D1, D2: in Num_Var;
                           R,D: out Num_Var);
   procedure Gc_Expr_Log (P: in Pnode; R1, R2, D1, D2: in Num_Var;
                          R,D: out Num_Var);
   procedure Gc_Expr_Comp (P: in Pnode; R1, R2, D1, D2: in Num_Var;
                           R,D: out Num_Var);
   procedure Gc_Expr_Not (R1, D1: in Num_Var; R,D: out Num_Var);
   procedure Gc_Expr_Neg (R1, D1: in Num_Var; R,D: out Num_Var);
   procedure Gc_Expr_Parent (R1, D1: in Num_Var; R, D: out Num_Var);
   procedure Gc_Expr_Ref (P: in Pnode; R, D: out Num_Var);
   procedure Gc_Expr_Lit (P: in Pnode; R, D: out Num_Var);
   procedure Gc_Ref_E (P: in Pnode; Tsb: in tipus_subjacent;
                       Primer: in out Boolean; D: in out Num_Var);
   procedure gc_m (e: out etiqueta);
   procedure gc_sent_iter (p: in pnode);
   procedure gc_sent_cond (p: in pnode);
   procedure gc_llam_proc (p: in pnode);
   procedure gc_sent_asig (p: in pnode);

end semantica.g_codi;
