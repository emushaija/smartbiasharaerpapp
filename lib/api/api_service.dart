import 'dart:convert';
import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Import secure storage

class ApiService {
  // Function to send a POST request with dynamic headers, body, and optional Basic Authentication
  Future<dynamic> postData(
    String url, {
    required Map<String, String> headers, // Headers passed dynamically
    required String body, // Body passed dynamically
    String? phpSessionId,  // PHPSESSIONID passed dynamically (if available)
    String? username,  // Optional username for Basic Authentication
    String? password,  // Optional password for Basic Authentication
  }) async {
    final Uri apiUrl = Uri.parse(url);

final cookieJar = CookieJar();

    // If PHPSESSIONID is available, add it to the headers
    if(phpSessionId==null)
    {
    phpSessionId = await getPhpSessionId();
      headers['PHPSESSIONID'] = phpSessionId!;
      
    }
    else
    {
      headers['PHPSESSIONID'] = phpSessionId;
    }
    
    

    // If Basic Authentication credentials are provided, add Authorization header
    if (username != null && password != null) {
      String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
      headers['Authorization'] = basicAuth;
    }

    // Sending POST request
   
    final response = await http.post(
      apiUrl,
      headers: {
        'Content-Type': 'application/json',
        'Cookie': 'PHPSESSID=$phpSessionId',  // Send the cookies with the request
      },
      body: body,
    );

    // Check if the response is successful (status code 200)
    if (response.statusCode == 200) {
      return json.decode(response.body);  // Parse response body as JSON
    } else {
      throw Exception('Failed to load data from $url');  // Throw an error if failed
    }
  }

  // Function to retrieve PHPSESSIONID from secure storage (if needed)
  Future<String?> getPhpSessionId() async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: 'phpsessionid');
  }
}
