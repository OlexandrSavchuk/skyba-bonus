import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skyba_bonus/core/network/api_client.dart';

final bonusRepositoryProvider = Provider<BonusRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return BonusRepository(apiClient: apiClient);
});

class BonusRepository {
  final ApiClient _apiClient;

  BonusRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<Map<String, dynamic>> getBalance() async {
    final response = await _apiClient.get('/client/bonus');
    return response.data as Map<String, dynamic>;
  }

  Future<String> getQrData(String barcode) async {
    // The QR code is generated from the barcode directly.
    // For EAN-13, we just return the barcode string.
    return barcode;
  }
}
