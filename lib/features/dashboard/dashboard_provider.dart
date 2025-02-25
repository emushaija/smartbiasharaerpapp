// features/dashboard/dashboard_provider.dart
import 'dashboard_service.dart';

class DashboardProvider {
  Future<List<dynamic>> getPaymentRequests() async {
    return await DashboardService().fetchPaymentRequests();
  }
}
