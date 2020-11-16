
import java.lang.*;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.IOException;
import java.io.FileNotFoundException;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;

%%
%line 
%column
%unicode
%type int 

%xstate comentario

%{
	public static final int IMAGINARIO = 4;
	public static final int DECIMAL = 3;
	public static final int CONSTBOOL = 6;
	public static final int NUMERO = 2;
	public static final int CADENAS = 5;
	public static final int OPERADORCRUZ = 7;
	public static final int OPERADORMENOS = 8;
	public static final int ASTERISCO = 9;
	public static final int DIAGONAL = 10;
	public static final int PORCENTAJE = 11;
	public static final int UINT8 = 12;
	public static final int UINT16 = 13;
	public static final int CONST = 14;
	public static final int INT8 = 15;
	public static final int INT16 = 16;
	public static final int INT32 = 17;
	public static final int COMPLEX64= 18;
	public static final int BYTE = 19;
	public static final int FLOAT32 = 20;
	public static final int FLOAT64 = 21;
	public static final int STRING = 22;
	public static final int BOOL = 23;
	public static final int STRUCT = 24;
	public static final int FUNC = 25;
	public static final int DEFER = 26;
	public static final int IF = 27;
	public static final int ELSE = 28;
	public static final int SWITCH = 29;
	public static final int CASE = 30;
	public static final int DEFAULT = 31;
	public static final int FOR = 32;
	public static final int RETURN = 33;
	public static final int BREAK = 34;
	public static final int CONTINUE = 35;
	public static final int PAR_L = 36;
	public static final int PAR_R = 37;
	public static final int COR_L = 38;
	public static final int COR_R = 39;
	public static final int LLA_L = 40;
	public static final int LLA_R = 41;
	public static final int REL_OP_1 = 42;
	public static final int REL_OP_2 = 43;
	public static final int REL_OP_3 = 44;
	public static final int REL_OP_4 = 45;
	public static final int REL_OP_5 = 46;
	public static final int REL_OP_6 = 47;
	public static final int UNARY_OP1 = 48;
	public static final int UNARY_OP2 = 49;
	public static final int AND = 50;
	public static final int OR = 51;
	public static final int VAR = 52;
	public static final int PACK = 53;
	public static final int ID = 1;
	public static final int EOF = 0;
	public static File archivo = null;
	public static void main(String[] args) {
        try {
        archivo = new File(args[0]);
	 			Yylex lexer = new Yylex (new BufferedReader(new FileReader(archivo)));
				lexer.yylex();
	 			}catch (IOException e){
	 			System.out.println("Ocurrio un error al intentar acceder al archivo");
	 	}
	}

%}

%eofval{
            return EOF;
%eofval}

digito = [0-9]
enteros = {digito}+(_{digito}+)*               	//Segundo punto
letras = [a-zA-Z]
ex=[Ee]([+-])?{enteros}+
dec= {enteros}*"."{enteros}+|{enteros}+"."{enteros}*
decex=({dec}{ex}?|{enteros}{ex})											//Tercer punto
imaginario=({dec}{ex}?("i")|{enteros}{ex}?("i"))
espacios = [\n\t ]+
cadenas=  ( (\") ( [^(\")\n]  | \\(\") )* (\") |  (\')([^(\')])*(\') ) //Quinto punto
constbool = ("true" | "false") // Sexto punto

//Operadores
//add_op = (+|-)
//mul_op = (*|/| %)
//unary_op = (+|-|*|&| !)
//rel_op = ( ==|!=| < | <= | > | >= )
//binary_op = ( "||" | && | rel_op | mul_op )
add_op1  = "+"
add_op2  = "-"
mul_op1 = "*"
mul_op2 = "/"
mul_op3 = "%"
//unary_op = "+"
unary_op1 = "&"
unary_op2 = "!"
or = "||"
and = "&&"
par_L = "("
par_R = ")"
cor_L = "[" 
cor_R = "]"
lla_L = "{"
lla_R = "}"

rel_op_1 = "=="
rel_op_2 = "!="
rel_op_3 = "<"
rel_op_4 = "<="
rel_op_5 = ">"
rel_op_6 = ">="

//Palabras reservadas
pack = package
var = var
const = const
uint8 = uint8
uint16 = uint16
int8 = int8
int16 = int16
int32 = int32
float32 = float32
float64 = float64
complex64 = complex64
byte = byte
string = string
bool = bool
struct = struct
func = func
defer = defer
if = if
else = else
switch = switch
case = case
default = default
for = for
return = return
break = break
continue = continue

id = ({letras}|_) (_{digito}| {letras}|_) *    // Primer punto
 
%%

{espacios} {}

{imaginario} {return IMAGINARIO; }
{decex} {return DECIMAL;  }
{constbool} {return CONSTBOOL; }


{enteros} {return NUMERO; }
{cadenas} {return CADENAS; }
{add_op1} {return OPERADORCRUZ; }
{add_op2} {return OPERADORMENOS; }
{mul_op1} {return ASTERISCO; }
{mul_op2} {return DIAGONAL; }
{mul_op3} {return PORCENTAJE; }
{uint8} {return UINT8; }
{uint16} {return UINT16;  }
{const} {return CONST; }
{int8} {return INT8;  }
{int16} {return INT16;  }
{int32} {return INT32;  }
{complex64} {return COMPLEX64;  }
{byte} {return BYTE;  }
{float32} {return FLOAT32; }
{float64} {return FLOAT64; }
{string} {return STRING;  }
{bool} {return BOOL;  }
{struct} {return STRUCT; }
{func} {return FUNC; }
{defer} {return DEFER; }
{if} {return IF; }
{else} {return ELSE; }
{switch} {return SWITCH;  }
{case} {return CASE; }
{default} {return DEFAULT;  }
{for} {return FOR; }
{return } {return RETURN;  }
{break} {return BREAK; }
{continue} {return CONTINUE;  }
{par_L} {return PAR_L; }
{par_R} {return PAR_R; }
{cor_L} {return COR_L;  }
{cor_R} {return COR_R;  }
{lla_L} {return LLA_L;  }
{lla_R} {return LLA_R; }
{rel_op_1} {return REL_OP_1;  }
{rel_op_2} {return REL_OP_2;  }
{rel_op_3} {return REL_OP_3;  }
{rel_op_4} {return REL_OP_4;  }
{rel_op_5} {return REL_OP_5;  }
{rel_op_6} {return REL_OP_6; }
{unary_op1} {return UNARY_OP1;  }
{unary_op2} {return UNARY_OP2;  }
{and} {return AND;  }
{or} {return OR;  }
{var} {return VAR;  }
{pack} {return PACK; }
{id} {return ID;  }