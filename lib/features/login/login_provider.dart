

import 'login_service.dart';  // Import login service to make network calls

class LoginProvider {
  // This method handles login logic
  Future<Map<String, dynamic>> login(String username, String password) async {
    // Call the login service to verify the credentials
    return await LoginService().login(username, password);
  }
}

