// features/dashboard/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'dashboard_provider.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<dynamic> _paymentRequests = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPaymentRequests();
  }

  Future<void> _fetchPaymentRequests() async {
    final requests = await DashboardProvider().getPaymentRequests();
    setState(() {
      _paymentRequests = requests;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Payment Requests')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _paymentRequests.length,
              itemBuilder: (context, index) {
                final request = _paymentRequests[index];
                return ListTile(
                  title: Text('Request #${request['id']}'),
                  subtitle: Text('Amount: \$${request['amount']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {
                      // Handle approval action
                    },
                  ),
                );
              },
            ),
    );
  }
}
