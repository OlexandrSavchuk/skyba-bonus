import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skyba_bonus/features/notifications/data/models/app_notification.dart';
import 'package:skyba_bonus/features/notifications/data/notifications_repository.dart';

final notificationsProvider =
    AsyncNotifierProvider<NotificationsNotifier, List<AppNotification>>(
  NotificationsNotifier.new,
);

class NotificationsNotifier extends AsyncNotifier<List<AppNotification>> {
  @override
  Future<List<AppNotification>> build() async {
    return _fetchNotifications();
  }

  Future<List<AppNotification>> _fetchNotifications() async {
    final repository = ref.read(notificationsRepositoryProvider);
    return repository.getNotifications();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchNotifications());
  }

  Future<void> markAsRead(String id) async {
    final repository = ref.read(notificationsRepositoryProvider);
    await repository.markAsRead(id);

    // Update local state
    final current = state.valueOrNull ?? [];
    state = AsyncValue.data(
      current.map((n) {
        if (n.id == id) {
          return n.copyWith(isRead: true);
        }
        return n;
      }).toList(),
    );
  }
}

final unreadNotificationsCountProvider = Provider<int>((ref) {
  final notifications = ref.watch(notificationsProvider);
  return notifications.when(
    data: (list) => list.where((n) => !n.isRead).length,
    loading: () => 0,
    error: (_, __) => 0,
  );
});
