import 'dart:convert'; // Import to use jsonEncode
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../api/api_service.dart';

// Model for PaymentRequest
class PaymentRequest {
  final int paymentRequestID;
  final double amount;
  final String status;  // Assuming `status` is part of the response
  final int branchID;   // Assuming `branchID` is part of the response
  final DateTime date;  // Assuming `date` is part of the response

  PaymentRequest({
    required this.paymentRequestID,
    required this.amount,
    required this.status,
    required this.branchID,
    required this.date,
  });

  // Factory method to create PaymentRequest from a map (API response)
  factory PaymentRequest.fromMap(Map<String, dynamic> map) {
    return PaymentRequest(
      paymentRequestID: map['paymentRequestID'],
      amount: map['amount'],
      status: map['status'],
      branchID: map['branchID'],
      date: DateTime.parse(map['date']), // Assuming 'date' is in string format
    );
  }
}

class PaymentRequestsProvider with ChangeNotifier {
  List<PaymentRequest> _paymentRequests = [];
  bool _isLoading = false;
  int _count = 0;  // Variable to store the count of payment requests

  List<PaymentRequest> get paymentRequests => _paymentRequests;
  bool get isLoading => _isLoading;
  int get count => _count;  // Getter for count

  // Fetch payment requests from the API with dynamic parameters
  Future<void> fetchPaymentRequests(String apiUrl, String requestType) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Prepare the body, encode as JSON
      final body = {
        'RequestType': requestType,  // Include the RequestType in the body
      };

      // Retrieve PHPSESSIONID from secure storage
      final storage = FlutterSecureStorage();
      final phpSessionId = await storage.read(key: 'phpsessionid');

      // Prepare the headers, including PHPSESSIONID if it exists
      Map<String, String> headers = {
        'Content-Type': 'application/json',  // Content type for JSON
      };

      if (phpSessionId != null) {
        headers['PHPSESSIONID'] = phpSessionId;  // Add PHPSESSIONID to headers if available
      }

      // Create an instance of ApiService
      final apiService = ApiService();

      // Encode the body to JSON string before sending it
      final jsonBody = jsonEncode(body);

      // Call the postData method, passing the URL, headers, and body
      final data = await apiService.postData(
        apiUrl,
        headers: headers,
        body: jsonBody,  // Send the encoded JSON data in the body
        phpSessionId: phpSessionId!,
      );

      print('Response from server: $data');

      // Extract the count and resultArray from the response data
      // Extract the count from the response data and parse it as an integer
_count = int.tryParse(data['paymentRequestInfo']['count'].toString()) ?? 0;  // Default to 0 if parsing fails


      // Extract the resultArray, which contains the list of payment requests
      final resultArray = data['paymentRequestInfo']['resultArray'];

      // Convert the fetched data to a list of PaymentRequest objects
      _paymentRequests = List<PaymentRequest>.from(
        resultArray.map<PaymentRequest>((item) => PaymentRequest.fromMap(item)),
      );

      print("Payment Requests: $_paymentRequests");
    } catch (e) {
      // Handle error
      print("Error fetching payment requests: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
