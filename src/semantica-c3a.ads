with decls.d_descripcio, decls.d_c3a_fitxer_text, semantica.gcodi, decls.dtaula_de_simbols;
use decls.d_descripcio, decls.d_c3a_fitxer_text, semantica.gcodi, decls.dtaula_de_simbols;

package semantica.c3a is

   procedure tancarC3a;

   procedure preparaC3a(nom: in string);

   procedure genera(c: in elementc3a);

   function novaEtiqueta return etiqueta;

   function novaConst(val: in valor; tsub: in t_descr_tipus) return num_Var;

   function novaVar return num_Var;

end semantica.c3a;
