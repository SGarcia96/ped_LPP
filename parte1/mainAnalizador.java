/**
 * Clase para leer el contenido de un fichero .txt y pasar la información
 * a JFlex para su análisis léxico
 */
import java.io.BufferedReader;
import java.io.FileReader;

public class mainAnalizador {
    public static void main(String[] args) {
 
        try{
			// Asignación del nombre de archivo por defecto que usará la aplicación
			String archivo = "prueba.txt";
       
			// Se trata de leer el archivo y analizarlo en la clase que se ha creado con JFlex
			BufferedReader buffer = new BufferedReader(new FileReader(archivo));
			AnalizadorLexico analizadorJFlex = new AnalizadorLexico(buffer);
       
			while(true){
				// Obtener el token analizado y mostrar su información
				Token token = analizadorJFlex.yylex();
       
				if (!analizadorJFlex.getExisteToken()){
					break;
				}
       
				System.out.println(token.toString());
			}
		}
		catch (Exception e){
			System.out.println(e.toString());
		}
	}
}