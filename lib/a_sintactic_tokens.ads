package A_Sintactic_Tokens is

    YYLVal, YYVal : YYSType; 
    type Token is
        (End_Of_Input, Error, Id, Literal,
         Pc_Procedure, Pc_Is, Pc_Begin,
         Pc_End, Pc_In, Pc_Out,
         Pc_Constant, Pc_Type, Pc_Array,
         Pc_Record, Pc_If, Pc_Then,
         Pc_Else, Pc_While, Pc_Loop,
         Pc_Mod, Pc_And, Pc_Or,
         Pc_New, Pc_Range, Pc_Of,
         Pc_Not, Pc_Null, Pc_Return,
         S_Puntpunt, S_Punticoma, S_Parentesiobert,
         S_Parentesitancat, S_Dospunts, S_Coma,
         S_Punt, S_Mes, S_Menys,
         S_Per, S_Divisio, S_Major,
         S_Menor, S_Majorigual, S_Menorigual,
         S_Diferent, S_Igual, S_Assignacio,
         Menysunitari );

    Syntax_Error : exception;

end A_Sintactic_Tokens;
