import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class Main {
	static void main(String args[]) throws IOException{
		BufferedReader in = new BufferedReader(new FileReader("test.pas")); //BufferedReader可以换成Scanner
		BufferedWriter out=new BufferedWriter(new FileWriter("test.dyd"));
		String str;
		String[] word;
	    LexAnalyzer an=new LexAnalyzer();
	    int line_cnt=0;
	    while ((str = in.readLine()) != null) {
	    	// RandomAccessFile 指针读取
	    	// word=str.trim().split(" "); 用空格切分是不行的！
	    	
	        System.out.println(str);
	    }
	    
	}	
}

class LexAnalyzer {
	Map<String, Integer> sym_type=new HashMap<>() {{
	    put("begin", 1);
	    put("end", 2);
	    put("integer", 3);
	    put("if", 4);
	    put("then", 5);
	    put("else", 6);
	    put("function", 7);
	    put("read", 8);
	    put("write", 9);
	    put("标识符", 10);
	    put("常数", 11);
	    put("=", 12);
	    put("<>", 13);
	    put("<=", 14);
	    put("<", 15);
	    put(">=", 16);
	    put(">", 17);
	    put("-", 18);
	    put("*", 19);
	    put(":=", 20);
	    put("(", 21);
	    put(")", 22);
	    put(";", 23);
	}}; 
	
	
	Word_Struct lexAnalyze(){
		String token=new String();
		Scanner sc=new Scanner(System.in);
	    /*读入非空白字符*/ //只有空格吗
	    char ch = ' ';
	    while (ch!=' ') {
	        ch = getchar();
	    }
	    switch (ch)
	    {
	    case 'a':
	    case 'b':
	    case 'c':
	    case 'z':
	    	/*当前字符为字母或数字*/
	        while (Character.isLetter(ch) || Character.isDigit(ch))
	        {
	            token+=ch; // concat
	            ch=getchar();
	        }
	        retract();
	        // 字母和数字的组合串，不是关键字就是标识符
	        Integer num = sym_type.get(token);
	        if (num != null) return new Word_Struct(token, num); /*返回关键字*/
	        else
	        {
	            return new Word_Struct("标识符", sym_type.get("标识符")); /*返回标识符*/
	        }
	        break;
	    case '0':
	    case '1':
	    case '9':
	        while (Character.isDigit(ch))
	        {
	            token+=ch;
	            getchar();
	        }
	        retract();
	        // val = constant();
	        return new Word_Struct("常数", sym_type.get("常数")); /*返回常数*/
	        break; //没有break，case会继续往后执行
	    case '<':
	        getchar();
	        if (ch == '=') 
	        	return new Word_Struct("<=", sym_type.get("<="));/*返回“<=”符号*/
	        else if(ch=='>') 
	        	return new Word_Struct("<>", sym_type.get("<>"));/*返回“<>”符号*/
	        else {
	            retract();
	            return new Word_Struct("<", sym_type.get("<")); /*返回“<”符号*/
	        }
	        break;
	    case '>':
	        getchar();
	        if (ch == '=') return new Word_Struct(">=", sym_type.get(">=")); /*返回“>=”符号*/
	        else
	        {
	            retract();
	            return new Word_Struct(">", sym_type.get(">")); /*返回“>”符号*/
	        }
	        break;
	    case '=':
	        getchar();
	        if (ch == '=') return new Word_Struct("==", sym_type.get("==")); /*返回“==”符号*/
	        else
	        {
	            retract();
	            return new Word_Struct("=", sym_type.get("=")); /*返回“=”符号*/
	        }
	        break;
	    case ':':
	        getchar();
	        if (ch == '=') 
	        	return new Word_Struct(":=", sym_type.get(":=")); /*返回“:=”符号*/
	        else error();
	        break;
	    case '-':
	        return new Word_Struct("-", sym_type.get("-")); /*返回“-”符号*/
	    case '*':
	        return new Word_Struct("*", sym_type.get("*")); /*返回“*”符号*/
	    case ';':
	        return new Word_Struct(";", sym_type.get(";")); /*返回“;”符号*/
	    case '(':
	        return new Word_Struct("(", sym_type.get("(")); /*返回“(”符号*/
	    case ')':
	        return new Word_Struct(")", sym_type.get(")")); /*返回“)”符号*/
	    default:
	        error();
	    }
	}    
}

/* 二元式形式:单词符号(16)种别(2) */
class Word_Struct
{
    String sym;
    int type;
    Word_Struct(String sym, int type){
    	this.type=type;
    	this.sym=sym;
    }
    boolean legal_sym_len() {
    	if(sym.length()<=16)
    		return true;
    	else {
			return false;
		}
    }
    
    boolean legal_type_len() {
    	if(String.valueOf(type).length()<=2)
    		return true;
    	else {
			return false;
		}
    }
}
    

