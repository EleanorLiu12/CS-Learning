import java.net.InetSocketAddress;
import com.sun.net.httpserver.HttpServer;
import com.sun.net.httpserver.HttpContext;
import com.sun.net.httpserver.HttpExchange;

import java.io.IOException;
import java.io.OutputStream;
import java.io.File;
import java.util.Scanner;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;



public class WebServer {

	public static void main(String[] args) throws IOException {
		HttpServer server = HttpServer.create(new InetSocketAddress(8000),0); //ask the server to listen to incoming reuqests on port 8000
		HttpContext context = server.createContext("/");
		context.setHandler( (exchange) -> {
			System.out.print("Request incoming...");
			
			String requestFilePath = exchange.getRequestURI().toString();

			String response = "<p>Hello Web Server...</p>";
			response += "<p>Request resource: " + requestFilePath + "</p";
			
			File inFile = new File(requestFilePath.replace("/", ""));

			if (inFile.exists()) {
				String contentType = "text/html";
				if (requestFilePath.endsWith(".css")) contentType = "text/css";
				if (requestFilePath.endsWith(".png")) contentType = "image/png";
				
				
				exchange.getResponseHeaders().add("Content-type", contentType);
				exchange.sendResponseHeaders(200, inFile.length());

				Files.copy(inFile.toPath(), exchange.getResponseBody());
				exchange.getResponseBody().close();
				

			} else {			
				exchange.getResponseHeaders().add("Content-type", "text/html");

				exchange.sendResponseHeaders(200, response.length());

				OutputStream responseStream = exchange.getResponseBody();

				responseStream.write(response.getBytes());

				responseStream.close();
			}
		} );

		server.start();
		System.out.println("Web server running...");
	
	}

}
