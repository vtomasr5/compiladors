package body a_lexic is
function YYLex return Token is
subtype short is integer range -32768..32767;
    yy_act : integer;
    yy_c : short;

-- returned upon end-of-file
YY_END_TOK : constant integer := 0;
YY_END_OF_BUFFER : constant := 51;
subtype yy_state_type is integer;
yy_current_state : yy_state_type;
INITIAL : constant := 0;
yylval : Atribut;
yy_accept : constant array(0..124) of short :=
    (   0,
        0,    0,   51,   49,   47,   47,   49,   49,   27,   28,
       31,   29,   38,   30,   39,   32,   45,   25,   26,   34,
       33,   35,   43,   43,   43,   43,   43,   43,   43,   43,
       43,   43,   43,   43,   43,   43,   47,    0,   44,    0,
       48,   42,   41,   45,   40,   36,   37,   43,   43,   43,
        0,   43,   43,   43,   43,    7,    8,    9,   43,   43,
       43,   43,   43,   15,   16,   43,   43,   43,   43,   43,
       43,   43,   46,   48,    1,   43,   43,   43,   43,    6,
       43,   11,   12,   13,   43,   17,   43,   43,   43,   43,
       43,   43,   43,   43,   43,   43,    5,   10,   14,   43,

       43,   43,   43,   22,   23,   43,    2,    3,   43,   43,
       20,   43,   43,   24,   43,   43,   19,   21,   43,   43,
        4,   43,   18,    0
    ) ;

yy_ec : constant array(ASCII.NUL..ASCII.DEL) of short :=
    (   0,
        1,    1,    1,    1,    1,    1,    1,    1,    2,    3,
        1,    1,    2,    1,    1,    1,    1,    1,    1,    1,
        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
        1,    4,    5,    6,    5,    5,    5,    5,    7,    8,
        9,   10,   11,   12,   13,   14,   15,   16,   16,   16,
       16,   16,   16,   16,   16,   16,   16,   17,   18,   19,
       20,   21,    5,    5,   22,   23,   24,   25,   26,   27,
       28,   29,   30,   31,   31,   32,   33,   34,   35,   36,
       31,   37,   38,   39,   40,   31,   41,   31,   42,   31,
        5,    5,    5,    5,   43,    5,   22,   23,   24,   25,

       26,   27,   28,   29,   30,   31,   31,   32,   33,   34,
       35,   36,   31,   37,   38,   39,   40,   31,   41,   31,
       42,   31,    5,    5,    5,    5,    1
    ) ;

yy_meta : constant array(0..43) of short :=
    (   0,
        1,    1,    2,    3,    3,    3,    3,    3,    3,    3,
        3,    3,    3,    3,    3,    4,    3,    3,    3,    3,
        3,    4,    4,    4,    4,    4,    4,    4,    4,    4,
        4,    4,    4,    4,    4,    4,    4,    4,    4,    4,
        4,    4,    4
    ) ;

yy_base : constant array(0..128) of short :=
    (   0,
        0,    0,  232,  233,   42,   45,  225,    0,  233,  233,
      233,  233,  233,  217,  215,  208,  211,  206,  233,  205,
      233,  204,   16,   25,   17,  180,   22,   28,   26,   29,
       41,   43,   20,   51,   45,   46,   88,  216,  233,  214,
        0,  233,  233,  204,  233,  233,  233,  176,   53,   42,
      175,   54,   59,   57,   73,  174,  173,  172,   64,   76,
       62,   65,   74,  171,  170,   70,   75,   77,   88,   89,
       78,   92,  233,    0,  169,  101,   94,   87,  100,  168,
       93,  167,  166,  165,   96,  164,  109,  106,  103,  102,
      107,  114,  115,  111,  117,  116,  163,  162,  161,  122,

      130,  124,  125,  160,  159,  137,  158,  155,  142,  141,
      148,  144,  136,  147,  138,  131,  146,  145,  139,  140,
      143,  149,  133,  233,  190,  192,   54,  196
    ) ;

yy_def : constant array(0..128) of short :=
    (   0,
      124,    1,  124,  124,  124,  124,  125,  126,  124,  124,
      124,  124,  124,  124,  124,  124,  124,  124,  124,  124,
      124,  124,  127,  127,  127,  127,  127,  127,  127,  127,
      127,  127,  127,  127,  127,  127,  124,  125,  124,  124,
      128,  124,  124,  124,  124,  124,  124,  127,  127,  127,
      127,  127,  127,  127,  127,  127,  127,  127,  127,  127,
      127,  127,  127,  127,  127,  127,  127,  127,  127,  127,
      127,  127,  124,  128,  127,  127,  127,  127,  127,  127,
      127,  127,  127,  127,  127,  127,  127,  127,  127,  127,
      127,  127,  127,  127,  127,  127,  127,  127,  127,  127,

      127,  127,  127,  127,  127,  127,  127,  127,  127,  127,
      127,  127,  127,  127,  127,  127,  127,  127,  127,  127,
      127,  127,  127,    0,  124,  124,  124,  124
    ) ;

yy_nxt : constant array(0..276) of short :=
    (   0,
        4,    5,    6,    5,    4,    7,    8,    9,   10,   11,
       12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
       22,   23,   24,   25,   26,   27,   26,   26,   26,   28,
       26,   29,   30,   31,   32,   33,   34,   26,   35,   26,
       36,   26,    4,   37,   37,   37,   37,   37,   37,   49,
       52,   53,   50,   54,   56,   55,   67,   48,   51,   51,
       59,   57,   51,   60,   51,   58,   61,   51,   51,   64,
       51,   51,   68,   70,   72,   62,   69,   75,   76,   65,
       63,   77,   66,   51,   51,   51,   71,   51,   51,   37,
       37,   37,   78,   51,   79,   51,   51,   80,   81,   51,

       82,   51,   83,   84,   51,   85,   51,   51,   86,   87,
       88,   89,   51,   92,   91,   51,   51,   51,   51,   51,
       51,   93,   94,   95,   96,   97,   90,   99,   98,   51,
       51,   51,  100,  101,   51,   51,   51,  102,   51,  105,
      104,  103,   51,   51,   51,   51,  106,  110,   51,   51,
      108,   51,  107,   51,  109,  111,   51,   51,   51,   51,
      112,  113,  114,  115,   51,  116,   51,   51,  117,  118,
      120,  119,   51,   51,  123,   51,  122,  121,   51,   51,
       51,   51,   51,   51,   51,   51,   51,   51,   51,   51,
       51,   51,   38,   38,   40,   40,   74,   51,   74,   74,

       51,   51,   51,   51,   51,   51,   51,   51,   51,   51,
       51,   51,   51,   51,   51,   51,   51,  124,   51,   44,
       73,   39,   51,   47,   46,   45,   44,   43,   42,   41,
       39,  124,    3,  124,  124,  124,  124,  124,  124,  124,
      124,  124,  124,  124,  124,  124,  124,  124,  124,  124,
      124,  124,  124,  124,  124,  124,  124,  124,  124,  124,
      124,  124,  124,  124,  124,  124,  124,  124,  124,  124,
      124,  124,  124,  124,  124,  124
    ) ;

yy_chk : constant array(0..276) of short :=
    (   0,
        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
        1,    1,    1,    5,    5,    5,    6,    6,    6,   23,
       24,   25,   23,   27,   28,   27,   33,  127,   23,   25,
       29,   28,   33,   30,   27,   28,   31,   24,   29,   32,
       28,   30,   34,   35,   36,   31,   34,   49,   50,   32,
       31,   52,   32,   31,   50,   32,   35,   35,   36,   37,
       37,   37,   53,   34,   54,   49,   52,   55,   59,   54,

       60,   53,   61,   62,   61,   63,   59,   62,   66,   67,
       68,   69,   66,   71,   70,   55,   63,   67,   60,   68,
       71,   72,   76,   77,   78,   79,   69,   85,   81,   78,
       69,   70,   87,   88,   72,   81,   77,   89,   85,   92,
       91,   90,   79,   76,   90,   89,   93,  100,   88,   91,
       95,   87,   94,   94,   96,  101,   92,   93,   96,   95,
      102,  103,  106,  109,  100,  110,  102,  103,  112,  113,
      116,  115,  101,  116,  122,  123,  120,  119,  113,  106,
      115,  119,  120,  110,  109,  121,  112,  118,  117,  114,
      111,  122,  125,  125,  126,  126,  128,  108,  128,  128,

      107,  105,  104,   99,   98,   97,   86,   84,   83,   82,
       80,   75,   65,   64,   58,   57,   56,   51,   48,   44,
       40,   38,   26,   22,   20,   18,   17,   16,   15,   14,
        7,    3,  124,  124,  124,  124,  124,  124,  124,  124,
      124,  124,  124,  124,  124,  124,  124,  124,  124,  124,
      124,  124,  124,  124,  124,  124,  124,  124,  124,  124,
      124,  124,  124,  124,  124,  124,  124,  124,  124,  124,
      124,  124,  124,  124,  124,  124
    ) ;


-- copy whatever the last rule matched to the standard output

procedure ECHO is
begin
   if (text_io.is_open(user_output_file)) then
     text_io.put( user_output_file, yytext );
   else
     text_io.put( yytext );
   end if;
end ECHO;

-- enter a start condition.
-- Using procedure requires a () after the ENTER, but makes everything
-- much neater.

procedure ENTER( state : integer ) is
begin
     yy_start := 1 + 2 * state;
end ENTER;

-- action number for EOF rule of a given start state
function YY_STATE_EOF(state : integer) return integer is
begin
     return YY_END_OF_BUFFER + state + 1;
end YY_STATE_EOF;

-- return all but the first 'n' matched characters back to the input stream
procedure yyless(n : integer) is
begin
        yy_ch_buf(yy_cp) := yy_hold_char; -- undo effects of setting up yytext
        yy_cp := yy_bp + n;
        yy_c_buf_p := yy_cp;
        YY_DO_BEFORE_ACTION; -- set up yytext again
end yyless;

-- redefine this if you have something you want each time.
procedure YY_USER_ACTION is
begin
        null;
end;

-- yy_get_previous_state - get the state just before the EOB char was reached

function yy_get_previous_state return yy_state_type is
    yy_current_state : yy_state_type;
    yy_c : short;
begin
    yy_current_state := yy_start;

    for yy_cp in yytext_ptr..yy_c_buf_p - 1 loop
	yy_c := yy_ec(yy_ch_buf(yy_cp));
	if ( yy_accept(yy_current_state) /= 0 ) then
	    yy_last_accepting_state := yy_current_state;
	    yy_last_accepting_cpos := yy_cp;
	end if;
	while ( yy_chk(yy_base(yy_current_state) + yy_c) /= yy_current_state ) loop
	    yy_current_state := yy_def(yy_current_state);
	    if ( yy_current_state >= 125 ) then
		yy_c := yy_meta(yy_c);
	    end if;
	end loop;
	yy_current_state := yy_nxt(yy_base(yy_current_state) + yy_c);
    end loop;

    return yy_current_state;
end yy_get_previous_state;

procedure yyrestart( input_file : file_type ) is
begin
   open_input(text_io.name(input_file));
end yyrestart;

begin -- of YYLex
<<new_file>>
        -- this is where we enter upon encountering an end-of-file and
        -- yywrap() indicating that we should continue processing

    if ( yy_init ) then
        if ( yy_start = 0 ) then
            yy_start := 1;      -- first start state
        end if;

        -- we put in the '\n' and start reading from [1] so that an
        -- initial match-at-newline will be true.

        yy_ch_buf(0) := ASCII.LF;
        yy_n_chars := 1;

        -- we always need two end-of-buffer characters. The first causes
        -- a transition to the end-of-buffer state. The second causes
        -- a jam in that state.

        yy_ch_buf(yy_n_chars) := YY_END_OF_BUFFER_CHAR;
        yy_ch_buf(yy_n_chars + 1) := YY_END_OF_BUFFER_CHAR;

        yy_eof_has_been_seen := false;

        yytext_ptr := 1;
        yy_c_buf_p := yytext_ptr;
        yy_hold_char := yy_ch_buf(yy_c_buf_p);
        yy_init := false;
-- UMASS CODES :
--   Initialization
        tok_begin_line := 1;
        tok_end_line := 1;
        tok_begin_col := 0;
        tok_end_col := 0;
        token_at_end_of_line := false;
        line_number_of_saved_tok_line1 := 0;
        line_number_of_saved_tok_line2 := 0;
-- END OF UMASS CODES.
    end if; -- yy_init

    loop                -- loops until end-of-file is reached

-- UMASS CODES :
--    if last matched token is end_of_line, we must
--    update the token_end_line and reset tok_end_col.
    if Token_At_End_Of_Line then
      Tok_End_Line := Tok_End_Line + 1;
      Tok_End_Col := 0;
      Token_At_End_Of_Line := False;
    end if;
-- END OF UMASS CODES.

        yy_cp := yy_c_buf_p;

        -- support of yytext
        yy_ch_buf(yy_cp) := yy_hold_char;

        -- yy_bp points to the position in yy_ch_buf of the start of the
        -- current run.
	yy_bp := yy_cp;
	yy_current_state := yy_start;
	loop
		yy_c := yy_ec(yy_ch_buf(yy_cp));
		if ( yy_accept(yy_current_state) /= 0 ) then
		    yy_last_accepting_state := yy_current_state;
		    yy_last_accepting_cpos := yy_cp;
		end if;
		while ( yy_chk(yy_base(yy_current_state) + yy_c) /= yy_current_state ) loop
		    yy_current_state := yy_def(yy_current_state);
		    if ( yy_current_state >= 125 ) then
			yy_c := yy_meta(yy_c);
		    end if;
		end loop;
		yy_current_state := yy_nxt(yy_base(yy_current_state) + yy_c);
	    yy_cp := yy_cp + 1;
if ( yy_current_state = 124 ) then
    exit;
end if;
	end loop;
	yy_cp := yy_last_accepting_cpos;
	yy_current_state := yy_last_accepting_state;

<<next_action>>
	    yy_act := yy_accept(yy_current_state);
            YY_DO_BEFORE_ACTION;
            YY_USER_ACTION;

        if aflex_debug then  -- output acceptance info. for (-d) debug mode
            text_io.put( Standard_Error, "--accepting rule #" );
            text_io.put( Standard_Error, INTEGER'IMAGE(yy_act) );
            text_io.put_line( Standard_Error, "(""" & yytext & """)");
        end if;

-- UMASS CODES :
--   Update tok_begin_line, tok_end_line, tok_begin_col and tok_end_col
--   after matching the token.
        if yy_act /= YY_END_OF_BUFFER and then yy_act /= 0 then
-- Token are matched only when yy_act is not yy_end_of_buffer or 0.
          Tok_Begin_Line := Tok_End_Line;
          Tok_Begin_Col := Tok_End_Col + 1;
          Tok_End_Col := Tok_Begin_Col + yy_cp - yy_bp - 1;
          if yy_ch_buf ( yy_bp ) = ASCII.LF then
            Token_At_End_Of_Line := True;
          end if;
        end if;
-- END OF UMASS CODES.

<<do_action>>   -- this label is used only to access EOF actions
            case yy_act is
		when 0 => -- must backtrack
		-- undo the effects of YY_DO_BEFORE_ACTION
		yy_ch_buf(yy_cp) := yy_hold_char;
		yy_cp := yy_last_accepting_cpos;
		yy_current_state := yy_last_accepting_state;
		goto next_action;



-- paraules reservades (en ordre alfabetic)
when 1 =>
--# line 41 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return pc_and;

when 2 =>
--# line 42 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return pc_array;

when 3 =>
--# line 43 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return pc_begin;

when 4 =>
--# line 44 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return pc_constant;

when 5 =>
--# line 45 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return pc_else;

when 6 =>
--# line 46 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return pc_end;



when 8 =>
--# line 48 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return pc_in;

when 9 =>
--# line 49 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return pc_is;

when 10 =>
--# line 50 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return pc_loop;

when 11 =>
--# line 51 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return pc_mod;

when 12 =>
--# line 52 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return pc_new;

when 13 =>
--# line 53 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return pc_not;

when 14 =>
--# line 54 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return pc_null;

when 15 =>
--# line 55 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return pc_of;

when 16 =>
--# line 56 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return pc_or;

when 17 =>
--# line 57 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return pc_out;

when 18 =>
--# line 58 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return pc_procedure;

when 19 =>
--# line 59 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return pc_record;

when 20 =>
--# line 60 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return pc_range;

when 21 =>
--# line 61 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return pc_return;

when 22 =>
--# line 62 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return pc_then;

when 23 =>
--# line 63 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return pc_type;

when 24 =>
--# line 64 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return pc_while;

-- simbols
when 25 =>
--# line 67 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return s_dospunts;

when 26 =>
--# line 68 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return s_punticoma;



when 28 =>
--# line 70 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return s_parentesitancat;

when 29 =>
--# line 71 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return s_mes;

when 30 =>
--# line 72 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return s_menys;

when 31 =>
--# line 73 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return s_per;

when 32 =>
--# line 74 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return s_divisio;

when 33 =>
--# line 75 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return s_igual;

when 34 =>
--# line 76 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return s_menor;

when 35 =>
--# line 77 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return s_major;

when 36 =>
--# line 78 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return s_menorigual;

when 37 =>
--# line 79 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return s_majorigual;

when 38 =>
--# line 80 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return s_coma;

when 39 =>
--# line 81 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return s_punt;

when 40 =>
--# line 82 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return s_assignacio;

when 41 =>
--# line 83 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return s_diferent;

when 42 =>
--# line 84 "lexic.l"
rl_atom (yylval, yy_line_number, yy_begin_column); return s_puntpunt;

-- Expressions regulars reconegudes. Ex: sumar_parells2
when 43 =>
--# line 87 "lexic.l"
rl_identificador (yylval, yytext, yy_line_number, yy_begin_column); return id;

when 44 =>
--# line 89 "lexic.l"
rl_literal_string (yylval, yytext, yy_line_number, yy_begin_column); return literal;

when 45 =>
--# line 91 "lexic.l"
rl_literal_enter (yylval, yytext, yy_line_number, yy_begin_column); return literal;

when 46 =>
--# line 93 "lexic.l"
rl_literal_caracter (yylval, yytext, yy_line_number, yy_begin_column); return literal;

-- caracters no representables
when 47 =>
--# line 96 "lexic.l"
null;

-- comentari
when 48 =>
--# line 99 "lexic.l"
null;

-- qualsevol altra cosa
when 49 =>
--# line 102 "lexic.l"
return Error;

when 50 =>
--# line 104 "lexic.l"
ECHO;
when YY_END_OF_BUFFER + INITIAL + 1 =>
    return End_Of_Input;
                when YY_END_OF_BUFFER =>
                    -- undo the effects of YY_DO_BEFORE_ACTION
                    yy_ch_buf(yy_cp) := yy_hold_char;

                    yytext_ptr := yy_bp;

                    case yy_get_next_buffer is
                        when EOB_ACT_END_OF_FILE =>
                            begin
                            if ( yywrap ) then
                                -- note: because we've taken care in
                                -- yy_get_next_buffer() to have set up yytext,
                                -- we can now set up yy_c_buf_p so that if some
                                -- total hoser (like aflex itself) wants
                                -- to call the scanner after we return the
                                -- End_Of_Input, it'll still work - another
                                -- End_Of_Input will get returned.

                                yy_c_buf_p := yytext_ptr;

                                yy_act := YY_STATE_EOF((yy_start - 1) / 2);

                                goto do_action;
                            else
                                --  start processing a new file
                                yy_init := true;
                                goto new_file;
                            end if;
                            end;
                        when EOB_ACT_RESTART_SCAN =>
                            yy_c_buf_p := yytext_ptr;
                            yy_hold_char := yy_ch_buf(yy_c_buf_p);
                        when EOB_ACT_LAST_MATCH =>
                            yy_c_buf_p := yy_n_chars;
                            yy_current_state := yy_get_previous_state;

                            yy_cp := yy_c_buf_p;
                            yy_bp := yytext_ptr;
                            goto next_action;
                        when others => null;
                        end case; -- case yy_get_next_buffer()
                when others =>
                    text_io.put( "action # " );
                    text_io.put( INTEGER'IMAGE(yy_act) );
                    text_io.new_line;
                    raise AFLEX_INTERNAL_ERROR;
            end case; -- case (yy_act)
        end loop; -- end of loop waiting for end of file
end YYLex;
--# line 104 "lexic.l"
end a_lexic;
