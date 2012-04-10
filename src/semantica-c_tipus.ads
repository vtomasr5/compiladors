with Decls.D_Descripcio, decls.d_arbre,decls.d_generals ;
use Decls.D_Descripcio, decls.d_arbre,decls.d_generals;

package Semantica.c_tipus is

   procedure ct_inic;
   procedure Ct_Declproc (P: in Pnode; Idfinal: in Id_Nom; lin,col: in natural);
   procedure Ct_Conclueix;

   error: exception;

private

   procedure ct_decl_var (p: in pnode);
   procedure ct_decl_var (plid: in pnode; idt: in id_nom);
   procedure ct_val_lit (p: in pnode; idt: out id_nom; tsb: out T_Descr_Tipus; val: out valor; lin, col: out natural);
   procedure ct_val_lit_neg (p: in pnode; idt: out id_nom; tsb: out T_Descr_Tipus; val: out valor; lin, col: out natural);
   procedure ct_val_id (p: in pnode; idt: out id_nom; tsb: out T_Descr_Tipus; val: out valor; lin, col: out natural);
   procedure ct_val_id_neg (p: in pnode; idt: out id_nom; tsb: out T_Descr_Tipus; val: out valor; lin, col: out natural);
   procedure ct_decl_const (p: in pnode);
   procedure ct_decl_const (plid: in pnode; idt: in id_nom; val: in valor);
   procedure ct_decl_subrang (p: in pnode);
   procedure ct_decl_array (p: in pnode);
   procedure ct_decl_array (p: in pnode; idt: in id_nom; id: in id_nom; nc: in out valor);
   procedure ct_decl_record (p: in pnode);
   procedure ct_dcamps (p: in pnode; id: in id_nom; ocup: in out despl);
   procedure Ct_Listasents (P: in Pnode);
   procedure Ct_Listadecls (P: in Pnode);
   procedure Ct_Decls (P: in Pnode);
   procedure ct_declencap (p: in pnode; id: out id_nom);
   procedure ct_declencap2 (p: in pnode; id: in id_nom; np: in num_proc);
   procedure Ct_Expr_Lit (P: in Pnode; Tsb: out T_Descr_Tipus; Idt: out Id_Nom; lin, col: out natural);
   procedure Ct_E (P: in Pnode; Idte: out Id_Nom; Tsbe: out T_Descr_Tipus; Mde : out Mode; lin, col: out natural);
   procedure Ct_Expr_Arit (Idte1, Idte2: in Id_Nom; Idter: out Id_Nom; Tsbe1, Tsbe2: in T_Descr_Tipus; Tsber: out T_Descr_Tipus; lin1, col1, lin2, col2: in natural);
   procedure Ct_Expr_Neg (Idte1: in Id_Nom; Idter: out Id_Nom; Tsbe1: in T_Descr_Tipus; Tsber: out T_Descr_Tipus; lin, col : in natural);
   procedure Ct_Expr_Log (Idte1, Idte2: in Id_Nom; Idter: out Id_Nom; Tsbe1, Tsbe2: in T_Descr_Tipus; Tsber: out T_Descr_Tipus; lin1, col1, lin2, col2: in natural);
   procedure Ct_Expr_Not (Idte1: in Id_Nom; Idter: out Id_Nom; Tsbe1: in T_Descr_Tipus; Tsber: out T_Descr_Tipus; lin, col : in natural);
   procedure Ct_Expr_Comp (Idte1, Idte2: in Id_Nom; Idter: out Id_Nom; Tsbe1, Tsbe2: in T_Descr_Tipus; Tsber: out T_Descr_Tipus; lin1, col1, lin2, col2: in natural);
   procedure Ct_Exp_Parent (Idte1: in Id_Nom; Idter: out Id_Nom; Tsbe1: in T_Descr_Tipus; Tsber: out T_Descr_Tipus);
   procedure ct_exp_ref (p: in pnode; Idtr, idter: out Id_Nom; Tsbr, tsber: out T_Descr_Tipus; mdr, mder: out mode; lin, col: out natural);
   procedure Ct_Ref (P: in Pnode; Idt: out Id_Nom; Tsb: out T_Descr_Tipus; Md: out Mode; lin, col: out natural);
   procedure Ct_Ref_Id (P: in Pnode; Idt: out Id_Nom; Tsb: out T_Descr_Tipus; Md: out Mode; lin, col: out natural);
   procedure Ct_Calfs (P: in Pnode; Idt: in out Id_Nom; Tsb: in out T_Descr_Tipus; Md: in out Mode; lin, col: in out natural);
   procedure Ct_Calf (P: in Pnode; Idt: in out Id_Nom; Tsb: in out T_Descr_Tipus; lin, col: in out natural);
   procedure Ct_Ref_Id (P: in Pnode; Idt: in out Id_Nom; Tsb: in out T_Descr_Tipus; lin, col: in out natural);
   procedure Ct_Ref_Listae (P: in Pnode; Idt: in out Id_Nom; Tsb: in out T_Descr_Tipus; Pos: in out Index_Expansio; primer: in out boolean; lin, col: in out natural);
   procedure Ct_Ref_Finlista (It: in out Index_Expansio; Idt: in out Id_Nom; Tsb: in out T_Descr_Tipus; lin, col: in natural);
   procedure Ct_Ref_E (P: in Pnode; It: in out Index_Expansio; Tsb: in T_Descr_Tipus; idt: in id_nom; primer: in out boolean; lin, col: in out natural);
   procedure Ct_Sent (P: in Pnode);
   procedure Ct_Sent_Cond_It (P: in Pnode);
   procedure Ct_Sent_Asig (P: in Pnode);
   procedure Ct_Sent_Llam_Proc (P: in Pnode);

end semantica.c_tipus;
