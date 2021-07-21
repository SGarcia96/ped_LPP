/** Analizador léxico para lenguaje HAda. ped LPP2020-2021
por Steven García 
**/

/** Sección de declaraciones de JFlex **/
%%
%public
%class AnalizadorLexico
%ignorecase

%{
    /* Codigo Java */
    //Atributo para verificar que existen tokens pendientes
    private boolean existeToken = false;

    public boolean getExisteToken(){
        return this.existeToken;
    }
%}

//con %type se le indica a JFlex que devuelva objetos de tipo Token
%type Token

%init{
    //con %init código que se ejecutará en el constructor de la clase
%init}

%eof{
    //con %eof código que se ejecutará al finalizar el análisis, cambiaremos el valor de existeToken() a false
    this.existeToken = false;
	System.out.println("FIN DE ANALISIS");
%eof}

/* Inicio de declaraciones de expresiones regulares */
Digito = [0-9]
Entero = {Digito} {Digito}* 
ValorLogico = "true"|"false"
Letra = [A-Za-z]
Cadena = '"'{Letra} (Letra | Digito)*'"'
OParitmetico = "+"|"-"
OPrelacional = "<"|">"|"=="|"/="
OPlogico = "and"|"or"
OPasignacion = ":="
OPacceso = "."
Espacio = " "
SaltoDeLinea = \n|\r|\r\n|\t
EntradaCaracteres = [^\r\n]

/* Expresiones Clave */
Comentario = "--" {EntradaCaracteres}* {SaltoDeLinea}
Constante = {Entero}|{ValorLogico}|{Cadena}
Identificador = {Letra} (Letra | Digito)* 
PalabraReservada = "and"|"array"|"begin"|"Boolean"|"constant"|"else"|"end"|"False"|"for"|"function"|"if"|"in"|"Integer"|"is"|"loop"|"of"|"or"|"out"|"procedure"|"Put_line"|"record"|"return"|"then"|"True"|"type"|"while"
Delimitador = "'" | "'" | "(" | ")" | ".." | "--" {SaltoDeLinea} | "," | ";" | ":"
Operador = {OParitmetico} | {OPrelacional} | {OPlogico} | {OPasignacion} | {OPacceso}

%%

/** Sección de reglas **/
//Cada regla está formada por una {expresion} espacio {codigo java}

{Comentario} { System.out.println("Encontrado COMENTARIO"); }

{Constante} {
 Token token = new Token(yytext(), "CONSTANTE");
 this.existeToken = true;
 return token;
}

{Identificador} {
 Token token = new Token(yytext(), "IDENTIFICADOR");
 this.existeToken = true;
 return token;
}

{PalabraReservada} {
 Token token = new Token(yytext(), "PALABRA RESERVADA");
 this.existeToken = true;
 return token;
}

{Delimitador} {
 Token token = new Token(yytext(), "DELIMITADOR");
 this.existeToken = true;
 return token;
}

{Operador} {
 Token token = new Token(yytext(), "OPERADOR");
 this.existeToken = true;
 return token;
}

{Espacio} { 
 // Ignorar cuando se ingrese un espacio
 }
 
{SaltoDeLinea} {
 // Ignorar cuando se ingrese un salto de linea o tabulado
}