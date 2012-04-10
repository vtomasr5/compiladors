with ada.Text_IO;
use ada.Text_IO;

package semantica.missatges is

   procedure missatge_error_comp;
   procedure missatge_comp_ok;
   procedure missatge_errorsintactic(lin,col: in integer);
   procedure missatge_nomproc(lin,col: in integer; id1,id2: in id_nom);
   procedure missatge_nodtipus(lin,col: in integer; id: in id_nom);
   procedure Missatge_Tsbnoescalar(Lin,Col: in Integer; Id: in Id_Nom);
   procedure missatge_tsbnoescalarexpr(lin,col: in integer);
   procedure missatge_tsbdifconst(lin,col: in integer; id: in id_nom; tsub: in tipus_subjacent);
   procedure missatge_tipusdifvar(lin,col: in integer; tsub1, tsub2: in tipus_subjacent);
   procedure missatge_tipusdif(lin,col: in integer; id1,id2: in id_nom);
   procedure missatge_tipusnocomp(lin,col: in integer; tsub1, tsub2: in tipus_subjacent);
   procedure missatge_foraderang(lin,col: in integer; id: in id_nom);
   procedure Missatge_Noesenter(Lin,Col: in Integer; Tsub: in tipus_subjacent);
   procedure Missatge_Noesconstant (Lin, Col: in Integer; td: in tipus_descripcio);
   procedure missatge_foraderanginf(lin,col: in integer; id: in id_nom);
   procedure missatge_foraderangsup(lin,col: in integer; id: in id_nom);
   procedure missatge_infmajorsup(lin,col: in integer);
   procedure missatge_jaexisteix(lin,col: in integer; id: in id_nom; simb: in string);
   procedure missatge_tsbnorec(lin,col: in integer; id: in id_nom);
   procedure Missatge_Campnoexistent(lin,col: in integer; id: in id_nom);
   procedure missatge_elementinexistent(lin,col: in integer; id: in id_nom);
   procedure Missatge_Faltenindexos(Lin,Col: in Integer);
   procedure missatge_sobrenindexos(lin,col: in integer);
   procedure Missatge_Faltenparametres(Lin,Col: in Integer);
   procedure missatge_sobrenparametres(lin,col: in integer);
   procedure Missatge_Tipusindexdif(Lin,Col: in Integer; Id1,Id2: in Id_Nom);
   procedure missatge_refnovar(lin,col: in integer);
   procedure missatge_paramout(lin,col: in integer);
   procedure missatge_noarrniproc(lin,col: in integer);
   procedure missatge_tsbnobool(lin,col: in integer; tsub: in tipus_subjacent);
   procedure missatge_noproc(lin,col: in integer);
   procedure missatge_tipusoperdif(lin,col: in integer);

   procedure crearFitxerError;
   procedure tancarFitxerError;
   procedure mostrarFitxerError;

private

   f : Ada.Text_IO.File_Type;
   nomF : constant string (1..19) := "missatges_error.txt";

end semantica.missatges;
