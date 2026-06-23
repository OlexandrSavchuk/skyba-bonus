import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skyba_bonus/core/storage/secure_storage.dart';
import 'package:skyba_bonus/features/auth/data/auth_repository.dart';
import 'package:skyba_bonus/features/auth/data/models/login_request.dart';
import 'package:skyba_bonus/features/auth/data/models/register_request.dart';
import 'package:skyba_bonus/features/auth/domain/auth_state.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final secureStorage = ref.watch(secureStorageProvider);
  return AuthNotifier(
    authRepository: authRepository,
    secureStorage: secureStorage,
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  final SecureStorageService _secureStorage;

  AuthNotifier({
    required AuthRepository authRepository,
    required SecureStorageService secureStorage,
  })  : _authRepository = authRepository,
        _secureStorage = secureStorage,
        super(const AuthState.unauthenticated()) {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    state = const AuthState.loading();
    try {
      final token = await _secureStorage.getAccessToken();
      final clientId = await _secureStorage.getClientId();

      if (token != null && clientId != null) {
        state = AuthState.authenticated(token: token, clientId: clientId);
      } else {
        state = const AuthState.unauthenticated();
      }
    } catch (_) {
      state = const AuthState.unauthenticated();
    }
  }

  Future<void> login(
    String companyId,
    String clientname,
    String password,
  ) async {
    state = const AuthState.loading();
    try {
      final response = await _authRepository.login(
        LoginRequest(
          companyId: companyId,
          clientname: clientname,
          password: password,
        ),
      );

      await _secureStorage.setAccessToken(response.accessToken);
      await _secureStorage.setClientId(response.client!.id);
      await _secureStorage.setCompanyId(companyId);

      state = AuthState.authenticated(
        token: response.accessToken,
        clientId: response.client!.id,
      );
    } catch (e) {
      state = AuthState.error(message: e.toString());
    }
  }

  Future<void> register(RegisterRequest request) async {
    state = const AuthState.loading();
    try {
      final response = await _authRepository.register(request);

      await _secureStorage.setAccessToken(response.accessToken);
      await _secureStorage.setClientId(response.client!.id);
      await _secureStorage.setCompanyId(request.companyId);
      // no refreshToken in current API response

      state = AuthState.authenticated(
        token: response.accessToken,
        clientId: response.client!.id,
      );
    } catch (e) {
      state = AuthState.error(message: e.toString());
    }
  }

  Future<void> resetPassword(String identifier) async {
    await _authRepository.resetPassword(identifier);
  }

  Future<void> logout() async {
    await _authRepository.logout();
    await _secureStorage.clearTokens();
    state = const AuthState.unauthenticated();
  }
}
