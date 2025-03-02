import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartbiasharaerp_app/providers/payment_requests_provider.dart';  // Import provider

class PaymentRequestsPage extends StatefulWidget {
  const PaymentRequestsPage({super.key});

  @override
  _PaymentRequestsPageState createState() => _PaymentRequestsPageState();
}

class _PaymentRequestsPageState extends State<PaymentRequestsPage> {
  @override
  void initState() {
    super.initState();
    // Fetch payment requests when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Call the fetch method from the provider
      Provider.of<PaymentRequestsProvider>(context, listen: false)
          .fetchPaymentRequests(
            'https://smartbiasharaerp.joehsolutions.com/applicationsAPI.php',
            'UnauthorisedPaymentRequests',
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use Consumer to listen to the changes in the PaymentRequestsProvider
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Requests'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Consumer<PaymentRequestsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            // Show loading indicator if the provider is still loading
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.paymentRequests.isEmpty) {
            // Show a message if no payment requests are available
            return const Center(child: Text('No payment requests available.'));
          }

          // Using ListView to create a list of cards
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: provider.paymentRequests.length,
              itemBuilder: (context, index) {
                final request = provider.paymentRequests[index];

                return Card(
                  elevation: 5,  // Adding shadow to the card
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),  // Rounded corners
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Payment Request ID
                        Text(
                          'Request ID: ${request.paymentRequestID}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                        const SizedBox(height: 8),
                        
                        // Amount
                        Row(
                          children: [
                            Text(
                              'Amount: ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              '${request.amount.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Date of Request
                        Text(
                          'Date: ${request.date.toLocal()}'.split(' ')[0],  // Format date
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
