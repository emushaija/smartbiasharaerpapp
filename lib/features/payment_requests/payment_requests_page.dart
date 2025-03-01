import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Import Flutter Secure Storage
import '../../api/api_service.dart'; // Import the API service

class PaymentRequestsPage extends StatefulWidget {
  const PaymentRequestsPage({super.key});

  @override
  _PaymentRequestsPageState createState() => _PaymentRequestsPageState();
}

class _PaymentRequestsPageState extends State<PaymentRequestsPage> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _paymentRequests = [];
  final String paymentRequestsUrl = 'https://smartbiasharaerp.joehsolutions.com/applicationsAPI.php';

  // Function to fetch payment requests
  void _fetchPaymentRequests() async {
    try {
      // Create an instance of ApiService
      var apiService = ApiService();

      // Read the PHPSESSIONID from secure storage
      final storage = FlutterSecureStorage();
      String? phpSessionId = await storage.read(key: 'phpsessionid');

      if (phpSessionId != null) {
        // Define headers with session ID
        final headers = {
          'Content-Type': 'application/x-www-form-urlencoded',  // Content type for form data
          'PHPSESSID': phpSessionId,
        };
       
        // Define body with request type
        /*
        final body = {
          'RequestType': 'UnauthorisedPaymentRequests',  // Request body for POST request
        };
        */
        String jsonBody = jsonEncode({
  'RequestType': 'UnauthorisedPaymentRequests',  // Request body for POST request
});
        // Send POST request with PHPSESSIONID in headers
        final requests = await apiService.postData(
          paymentRequestsUrl,
          headers: headers,
          body: jsonBody,
        );

        setState(() {
          _paymentRequests = List<Map<String, dynamic>>.from(requests);
          _isLoading = false;
        });
      } else {
        // If session ID is not available, show error
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PHP session ID is missing')),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Show an error message if fetching fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load payment requests')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPaymentRequests(); // Fetch data when page loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Requests'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())  // Show loading indicator
          : ListView.builder(
              itemCount: _paymentRequests.length,
              itemBuilder: (context, index) {
                final request = _paymentRequests[index];
                return ListTile(
                  title: Text('Request ID: ${request['paymentRequestID']}'),
                  subtitle: Text(
                    'Amount: ${request['amount']} ${request['currency']}\nRequested By: ${request['requestedBy']}\nDate: ${request['dateOfRequest']}\nRemarks: ${request['remarks']}',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    // You can navigate to more details if needed
                  },
                );
              },
            ),
    );
  }
}
