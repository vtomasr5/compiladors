package body semantica.missatges is

   procedure missatge_error_comp is
   begin
      new_line;
      Put_Line(" -- S'HA PRODUIT UN ERROR DE COMPILACIO --");
      put_line(" -- Per saber mes informacio consultau el fitxer:  errors/missatges_error.txt");
   end missatge_error_comp;

   procedure missatge_comp_ok is
   begin
      new_line;
      put_line(" -- S'HA COMPILAT CORRECTAMENT");
   end missatge_comp_ok;

   procedure escriure_posicio(lin,col: in integer) is
   begin
      put_line(f,"Error en la línia "&integer'image(lin)&", columna "&integer'image(col));
   end escriure_posicio;

   procedure missatge_errorsintactic(lin,col: in integer) is
   begin
      escriure_posicio(lin,col);
      put_line(f,"Sintaxi errònea");
   end missatge_errorsintactic;

   procedure missatge_nomproc(lin,col: in integer; id1,id2: in id_nom) is
   begin
      escriure_posicio(lin,col);
      put(f,"El nom de de l'inici del procedimient """&consultar_id(tn,id1)&""" no correspon amb ");
      put_line(f,"el nom del final del procedimient """&consultar_id(tn,id2)&"""");
   end missatge_nomproc;

   procedure missatge_nodtipus (lin,col: in integer; id: in id_nom) is
   begin
      escriure_posicio(lin,col);
      put_line(f,""""&consultar_id(tn,id)&""" no és un nom de tipus");
   end missatge_nodtipus;

   procedure missatge_tsbnoescalar(lin,col: in integer; id: in id_nom) is
   begin
      escriure_posicio(lin,col);
      put_line(f,"El tipus """&consultar_id(tn,id)&""" no és escalar");
   end missatge_tsbnoescalar;

   procedure missatge_tsbnoescalarexpr(lin,col: in integer) is
   begin
      escriure_posicio(lin,col);
      put_line(f,"El tipus de l'expressió no és escalar");
   end missatge_tsbnoescalarexpr;

   function convertir_tsub_a_string (tsub: in t_descr_tipus) return String is
   begin
      case tsub is
         when ts_bool => return "booleà";
         when ts_car => return "caràcter";
         when ts_enter => return "enter";
         when ts_arr => return "array";
         when ts_rec => return "record";
         when Ts_Nul => return "tipus nul";
         when others => return "altres tipus";
      end case;
   end convertir_tsub_a_string;

   function convertir_td_a_string (td: in tipus_descripcio) return String is
   begin
      case td is
         when dnul_la => return "nul";
         when Dconst => return "constant";
         when Dvar => return "variable";
         when Dproc => return "procediment";
         when Dparam => return "paràmetre";
         when Dcamp => return "camp";
         when Dindex => return "index";
         when others => return "altres tipus";
      end case;
   end convertir_td_a_string;

   procedure missatge_tsbdifconst(lin,col: in integer; id: in id_nom; tsub: in t_descr_tipus) is
   begin
      escriure_posicio(lin,col);
      put(f,"No es pot assignar un "&convertir_tsub_a_string(tsub)&" a un identificador ");
      put_line(f,"de tipus """&consultar_id(tn,id)&"""");
   end missatge_tsbdifconst;

   procedure missatge_tipusdifvar(lin,col: in integer; tsub1, tsub2: in t_descr_tipus) is
   begin
      escriure_posicio(lin,col);
      put(f,"El tipus "&convertir_tsub_a_string(tsub1)&" de la referència no és compatible amb el tipus ");
      put_line(f,""""&convertir_tsub_a_string(tsub2)&""""&" de l'expressió ");
   end missatge_tipusdifvar;

   procedure missatge_tipusdif(lin,col: in integer; id1,id2: in id_nom) is
   begin
      escriure_posicio(lin,col);
      put(f,"No es pot assignar un element del tipus "&consultar_id(tn,id2)&" a un ");
      put_line(f,"identificador de tipus """&consultar_id(tn,id1)&"""");
   end missatge_tipusdif;

   procedure missatge_tipusnocomp(lin,col: in integer; tsub1, tsub2: in t_descr_tipus) is
   begin
      escriure_posicio(lin,col);
      put(f,"El tipus "&convertir_tsub_a_string(tsub1)&" no és compatible amb el tipus ");
      put_line(f,""""&convertir_tsub_a_string(tsub2)&"""");
   end missatge_tipusnocomp;

   procedure missatge_foraderang(lin,col: in integer; id: in id_nom) is
   begin
      escriure_posicio(lin,col);
      put(f,"El valor de la/les constant/s no es ");
      put_line(f,"troba/en dins el rang del tipus """&consultar_id(tn,id)&"""");
   end missatge_foraderang;

   procedure missatge_noesenter(lin,col: in integer; tsub: in t_descr_tipus) is
   begin
      escriure_posicio(lin,col);
      put_line(f,"S'esperava un enter i no un "&convertir_tsub_a_string(tsub));
   end missatge_noesenter;

   procedure Missatge_Noesconstant (Lin, Col: in Integer; td: in tipus_descripcio) is
   begin
      Escriure_Posicio(Lin,Col);
      Put_Line(F,"S'esperava un tipus constant i no un tipus "&convertir_td_a_string(td));

   end Missatge_Noesconstant;

   procedure missatge_foraderanginf(lin,col: in integer; id: in id_nom) is
   begin
      escriure_posicio(lin,col);
      put_line(f,"El límit inferior està fora del rang del tipus """&consultar_id(tn,id)&"""");
   end missatge_foraderanginf;

   procedure missatge_foraderangsup(lin,col: in integer; id: in id_nom) is
   begin
      escriure_posicio(lin,col);
      put_line(f,"El límit superior està fora del rang del tipus """&consultar_id(tn,id)&"""");
   end missatge_foraderangsup;

   procedure missatge_infmajorsup(lin,col: in integer) is
   begin
      escriure_posicio(lin,col);
      put_line(f,"El límit inferior es major que el superior");
   end missatge_infmajorsup;

   procedure missatge_jaexisteix(lin,col: in integer; id: in id_nom; simb: in string) is
   begin
      escriure_posicio(lin,col);
      put_line(f,"El nom de"&simb&" """&consultar_id(tn,id)&""" ja existeix");
   end missatge_jaexisteix;

   procedure missatge_tsbnorec(lin,col: in integer; id: in id_nom) is
   begin
      escriure_posicio(lin,col);
      put_line(f,"El tipus """&consultar_id(tn,id)&""" no es un record");
   end missatge_tsbnorec;

   procedure Missatge_Campnoexistent(lin,col: in integer; id: in id_nom) is
   begin
      escriure_posicio(lin,col);
      put_line(f,"No existeix el camp """&consultar_id(tn,id)&"""");
   end Missatge_Campnoexistent;

   procedure missatge_elementinexistent(lin,col: in integer; id: in id_nom) is
   begin
      escriure_posicio(lin,col);
      put_line(f,"No existeix cap element amb el nom """&consultar_id(tn,id)&"""");
   end missatge_elementinexistent;

   procedure missatge_faltenindexos(lin,col: in integer) is
   begin
      escriure_posicio(lin,col);
      put_line(f,"Falten índexos");
   end missatge_faltenindexos;

   procedure missatge_sobrenindexos(lin,col: in integer) is
   begin
      escriure_posicio(lin,col);
      put_line(f,"Sobren índexos");
   end missatge_sobrenindexos;

   procedure missatge_faltenparametres(lin,col: in integer) is
   begin
      escriure_posicio(lin,col);
      put_line(f,"Falten paràmetres");
   end missatge_faltenparametres;

   procedure missatge_sobrenparametres(lin,col: in integer) is
   begin
      escriure_posicio(lin,col);
      put_line(f,"Sobren paràmetres");
   end missatge_sobrenparametres;

   procedure missatge_tipusindexdif(lin,col: in integer; id1,id2: in id_nom) is
   begin
      escriure_posicio(lin,col);
      put(f,"El tipus "&consultar_id(tn,id1)&" no es compatible amb el tipus");
      put_line(f,""""&consultar_id(tn,id2)&"""");
   end missatge_tipusindexdif;

   procedure missatge_refnovar(lin,col: in integer) is
   begin
      escriure_posicio(lin,col);
      put_line(f,"La part esquerre de l'assignació ha de ser una variable");
   end missatge_refnovar;

   procedure missatge_paramout(lin,col: in integer) is
   begin
      escriure_posicio(lin,col);
      put_line(f,"El paràmetre de sortida ha de ser una variable");
   end missatge_paramout;

   procedure missatge_noarrniproc(lin,col: in integer) is
   begin
      escriure_posicio(lin,col);
      put_line(f,"L'identificador no fa referència ni a un array ni a un procediment");
   end missatge_noarrniproc;

   procedure missatge_tsbnobool(lin,col: in integer; tsub: in t_descr_tipus) is
   begin
      escriure_posicio(lin,col);
      put_line(f,"S'esperava un booleà i no un "&convertir_tsub_a_string(tsub));
   end missatge_tsbnobool;

   procedure missatge_noproc(lin,col: in integer) is
   begin
      escriure_posicio(lin,col);
      put_line(f,"La referència no és un procedimient");
   end missatge_noproc;

   procedure missatge_tipusoperdif(lin,col: in integer) is
   begin
      escriure_posicio(lin,col);
      put_line(f,"Els operands són de tipus diferents");
   end missatge_tipusoperdif;

   procedure crearFitxerError is
   begin
      create(f, out_file, dirErrors & "/" & nomF);
   end crearFitxerError;

   procedure tancarFitxerError is
   begin
      if is_open(f) then
         close(f);
      end if;
   end tancarFitxerError;

   procedure mostrarFitxerError is
      Mens: String(1..200);
      Long: Integer;
   begin
      Open(F, in_file, DirErrors & "/" & nomF);
      while not end_of_file(f) loop
         get_line(f, mens, long);
         put_line(mens(1..long));
      end loop;
      tancarfitxerError;
   end mostrarFitxerError;

end semantica.missatges;
