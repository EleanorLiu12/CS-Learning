import java.net.InetSocketAddress;
import com.sun.net.httpserver.HttpServer;
import com.sun.net.httpserver.HttpContext;
import com.sun.net.httpserver.HttpExchange;

import java.io.IOException;
import java.io.OutputStream;
import java.io.File;
import java.util.Scanner;

public class MyWebServer {
    public static void main(String[] args) throws IOException {
	InetSocketAddress address = new InetSocketAddress(80);
	HttpServer server = HttpServer.create(address,8);

	// response with the requested file (when it exists in public/ dir)
	HttpContext wwwContext = server.createContext("/www");
	wwwContext.setHandler( exchange -> {
		System.out.println("WWW Context Request Received.");

		String path = exchange.getRequestURI().getPath();
		File file = new File(path);
		file = new File( "public/" + file.getName() );
		
		String responseString = "";
		Scanner in = new Scanner(file);
		while(in.hasNextLine()) responseString += in.nextLine() + "\n";
		
		byte[] bytes = responseString.getBytes();
		exchange.sendResponseHeaders(200,bytes.length);
		OutputStream out = exchange.getResponseBody();
		out.write(bytes);
		out.close();
		
	    } );

	// responds by saying hello to the name in the query
	HttpContext testContext = server.createContext("/test");
	testContext.setHandler( exchange -> {
		System.out.println("Test Context Request Received.");

		String query = exchange.getRequestURI().getQuery();
		
		String responseString = "Hello "+query+"!!!";
		byte[] bytes = responseString.getBytes();
		exchange.sendResponseHeaders(200,bytes.length);
		OutputStream out = exchange.getResponseBody();
		out.write(bytes);
		out.close();
		
	    } );
	System.out.println("Server Starting...");
	server.start();
    }
}
