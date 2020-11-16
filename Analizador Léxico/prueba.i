
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
	public static final int BOOL = 32;
	public static final int STRUCT = 24;
	public static final int FUNC = 25;
	public static final int DEFER = 26;
	public static final int IF = 27;
	public static final int ELSE = 28;
	public static final int SWITCH = 29;
	public static final int CASE = 30:
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
	public static File token =null;
	public static BufferedWriter bw ;
	public static File archivo = null;
	public static int suma = 0;
	public static String cadena = "";
	public static void main(String[] args) {
        
        try {
        token= new File("resultado.tokens");
        bw = new BufferedWriter(new FileWriter(token));
        archivo = new File(args[0]);
	 			Yylex lexer = new Yylex (new BufferedReader(new FileReader(archivo+".art")));
	 			lexer.yylex();
        
	 			}catch (IOException e){
	 			System.out.println("Ocurrio un error al intentar acceder al archivo");
	 	}
	}

%}

%eofval{
		   bw.close(); 
            return 0;
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

{imaginario} {bw.write("4 imaginario:"+yytext()+"\n");  }
{decex} {bw.write("3 decimal: "+yytext()+"\n");  }
{constbool} {bw.write("6 constbool:"+yytext()+"\n");  }


{enteros} {bw.write("2 numero:"+yytext()+"\n");  }
{cadenas} {bw.write("5 cadenas:"+yytext()+"\n");  }
{add_op1} {bw.write("7 Operador cruz:"+yytext()+"\n");  }
{add_op2} {bw.write("8 operador menos:"+yytext()+"\n");  }
{mul_op1} {bw.write("9 * es :"+yytext()+"\n");  }
{mul_op2} {bw.write("10 / es :"+yytext()+"\n");  }
{mul_op3} {bw.write("11 % es :"+yytext()+"\n");  }
{uint8} {bw.write("12  uint8: "+yytext()+"\n");  }
{uint16} {bw.write("13 uint16 :"+yytext()+"\n");  }
{const} {bw.write("14 const :"+yytext()+"\n");  }
{int8} {bw.write("15 int8 :"+yytext()+"\n");  }
{int16} {bw.write("16 int16 :"+yytext()+"\n");  }
{int32} {bw.write("17 int32 :"+yytext()+"\n");  }
{complex64} {bw.write("18 complex64 : "+yytext()+"\n");  }
{byte} {bw.write("19 byte : "+yytext()+"\n");  }
{float32} {bw.write("20 float32 : "+yytext()+"\n");  }
{float64} {bw.write("21 float64 : "+yytext()+"\n");  }
{string} {bw.write("22 string : "+yytext()+"\n");  }
{bool} {bw.write("23 bool : "+yytext()+"\n");  }
{struct} {bw.write("24 struct : "+yytext()+"\n");  }
{func} {bw.write("25 func : "+yytext()+"\n");  }
{defer} {bw.write("26 defer : "+yytext()+"\n");  }
{if} {bw.write("27 if : "+yytext()+"\n");  }
{else} {bw.write("28 else : "+yytext()+"\n");  }
{switch} {bw.write("29 switch : "+yytext()+"\n");  }
{case} {bw.write("30 case : "+yytext()+"\n");  }
{default} {bw.write("31 default : "+yytext()+"\n");  }
{for} {bw.write("32 for : "+yytext()+"\n");  }
{return } {bw.write("33 return : "+yytext()+"\n");  }
{break} {bw.write("34 break : "+yytext()+"\n");  }
{continue} {bw.write("35 continue : "+yytext()+"\n");  }
{par_L} {bw.write("36 par_L : "+yytext()+"\n");  }
{par_R} {bw.write("37 par_R : "+yytext()+"\n");  }
{cor_L} {bw.write("38 cor_L : "+yytext()+"\n");  }
{cor_R} {bw.write("39 cor_R : "+yytext()+"\n");  }
{lla_L} {bw.write("40 lla_L : "+yytext()+"\n");  }
{lla_R} {bw.write("41 lla_R : "+yytext()+"\n");  }
{rel_op_1} {bw.write("42 rel_op_1 : "+yytext()+"\n");  }
{rel_op_2} {bw.write("43 rel_op_2 : "+yytext()+"\n");  }
{rel_op_3} {bw.write("44 rel_op_3 : "+yytext()+"\n");  }
{rel_op_4} {bw.write("45 rel_op_4 : "+yytext()+"\n");  }
{rel_op_5} {bw.write("46 rel_op_5 : "+yytext()+"\n");  }
{rel_op_6} {bw.write("47 rel_op_6 : "+yytext()+"\n");  }
{unary_op1} {bw.write("48 unary_op1 : "+yytext()+"\n");  }
{unary_op2} {bw.write("49 unary_op2 : "+yytext()+"\n");  }
{and} {bw.write("50 and : "+yytext()+"\n");  }
{or} {bw.write("51 or : "+yytext()+"\n");  }
{var} {bw.write("52 var : "+yytext()+"\n");  }
{pack} {bw.write("53 pack : "+yytext()+"\n");  }
{id} {bw.write("1 id: "+yytext()+"\n");  }