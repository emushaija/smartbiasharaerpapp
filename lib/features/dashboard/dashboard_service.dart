// features/dashboard/dashboard_service.dart
import 'package:your_app/core/services/api_service.dart';

class DashboardService {
  final ApiService _apiService = ApiService();

  Future<List<dynamic>> fetchPaymentRequests() async {
    final result = await _apiService.getRequest('/payment-requests/pending');
    return result['data'];
  }
}
