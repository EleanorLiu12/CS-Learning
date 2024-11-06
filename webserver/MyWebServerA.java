import java.net.InetSocketAddress;
import com.sun.net.httpserver.HttpServer;
import com.sun.net.httpserver.HttpContext;
import com.sun.net.httpserver.HttpExchange;

import java.io.IOException;
import java.io.OutputStream;
import java.io.File;
import java.util.Scanner;

public class MyWebServerA {
    public static void main(String[] args) throws IOException {
	InetSocketAddress address = new InetSocketAddress(80);
	HttpServer server = HttpServer.create(address,8);
	HttpContext testContext = server.createContext("/test");
	testContext.setHandler(exchange -> {
		System.out.println("Test context request received.");

		String responseString = "Hello Curler!";
		byte[] responseBytes = responseString.getBytes();

		exchange.sendResponseHeaders(200, -1);
		OutputStream os = exchange.getResponseBody();
		os.write(responseBytes);
		os.close();	
	});
	System.out.println("Server is starting.");
	server.start();
	}
}
