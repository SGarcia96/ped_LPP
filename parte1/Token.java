/**
 * Clase Token que será el tipo de objeto a devolver por el analizador léxico
 */
public class Token {
	
    private String token;
    private String lexema;

    public Token (String token, String lexema) {
        this.token = token;
        this.lexema = lexema;
    }

    public String getToken(){
        return this.token;
    }

    public String getLexema(){
        return this.lexema;
    }

    public String toString(){
        return "Encontrado " + this.lexema + " " + this.token;
    }
}
