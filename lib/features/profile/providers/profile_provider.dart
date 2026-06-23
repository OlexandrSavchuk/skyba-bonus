import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skyba_bonus/features/profile/data/models/client_profile.dart';
import 'package:skyba_bonus/features/profile/data/profile_repository.dart';

final profileProvider =
    AsyncNotifierProvider<ProfileNotifier, ClientProfile?>(
  ProfileNotifier.new,
);

class ProfileNotifier extends AsyncNotifier<ClientProfile?> {
  @override
  Future<ClientProfile?> build() async {
    return _fetchProfile();
  }

  Future<ClientProfile?> _fetchProfile() async {
    try {
      final repository = ref.read(profileRepositoryProvider);
      return await repository.getProfile();
    } catch (e) {
      return null;
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchProfile());
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(profileRepositoryProvider);
      final updated = await repository.updateProfile(data);
      state = AsyncValue.data(updated);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
