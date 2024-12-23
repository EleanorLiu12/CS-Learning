import java.net.InetSocketAddress;
import com.sun.net.httpserver.HttpServer;
import com.sun.net.httpserver.HttpContext;
import com.sun.net.httpserver.HttpExchange;

import java.io.IOException;
import java.io.OutputStream;
import java.io.File;
import java.util.Scanner;

public class WebServer {

	public static void main(String[] args) throws IOException {
		HttpServer server = HttpServer.create(new InetSocketAddress(8000),0); //ask the server to listen to incoming reuqests on port 8000
		HttpContext context = server.createContext("/");
		context.setHandler( (exchange) -> {
			System.out.print("Request incoming...");
		} );

		server.start();
		System.out.println("Web server running...");
	}

}
