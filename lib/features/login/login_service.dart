import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  final String _apiUrl = 'https://smartbiasharaerp.joehsolutions.com/mobileAppApi.php'; // Correct API URL

  Future<Map<String, dynamic>> login(String username, String password) async {
    String credentials = '$username:$password';
    String base64Credentials = base64Encode(utf8.encode(credentials));

    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json', // Set content type as JSON
          'Authorization': 'Basic $base64Credentials',
        },
      );

      

      if (response.statusCode == 200) {
        try {
          // Parse the response body as JSON
          final Map<String, dynamic> responseData = json.decode(response.body);

          // Safely check if 'success' is available and is a boolean
         return responseData;
        } catch (e) {
          print('Error decoding JSON: $e');
          return {'error': 'Invalid JSON response'};  // Handle JSON parsing errors
        }
      } else {
        // Handle non-200 responses
        print('Login failed with status code: ${response.statusCode}');
        return {'error': 'Login failed', 'statusCode': response.statusCode};
      }
    } catch (e) {
      print('Error during login request: $e');
      return {'error': 'Request failed', 'exception': e.toString()};  // Catch network or other errors
    }
  }
}
