import 'package:flutter/material.dart';
import 'login_provider.dart';  // Import the provider to handle login logic

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();  // Key to validate the form

  // Instance of the LoginProvider
  final LoginProvider _loginProvider = LoginProvider();

  // Method to handle login when the button is pressed
  void _login() async {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text;
      String password = _passwordController.text;

      // Call the LoginProvider to check credentials
      var response = await _loginProvider.login(username, password);

      if (response['statusCode']==200) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Successful')));

           // Navigate to the Main page (Dashboard) after login
        Navigator.pushReplacementNamed(context, '/dashboard'); 
      } else {
        // Show error message if login failed
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Failed')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Image at the top
                Image.asset(
                  'assets/images/SmartBiasharaLogoNew.png',  // Update this to your logo path
                  height: 300,  // Adjust the height of the logo
                  width: 150,   // Adjust the width of the logo
                ),
                SizedBox(height: 40),
                
                // Login Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Username text field
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a username';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      // Password text field
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true, // Hide the password text
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      // Login button
                      ElevatedButton(
                        onPressed: _login,
                        child: Text('Login'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),  // Full-width button
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
