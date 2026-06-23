import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final localStorageProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

class LocalStorageService {
  static const String _cacheBoxName = 'skyba_cache';
  static const String _settingsBoxName = 'skyba_settings';

  Future<Box<dynamic>> get _cacheBox async =>
      Hive.isBoxOpen(_cacheBoxName)
          ? Hive.box(_cacheBoxName)
          : await Hive.openBox(_cacheBoxName);

  Future<Box<dynamic>> get _settingsBox async =>
      Hive.isBoxOpen(_settingsBoxName)
          ? Hive.box(_settingsBoxName)
          : await Hive.openBox(_settingsBoxName);

  Future<void> cacheData(String key, dynamic data) async {
    final box = await _cacheBox;
    await box.put(key, {
      'data': data,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<T?> getCachedData<T>(String key, {Duration? maxAge}) async {
    final box = await _cacheBox;
    final cached = box.get(key);

    if (cached == null) return null;

    if (maxAge != null) {
      final timestamp = cached['timestamp'] as int;
      final cachedAt = DateTime.fromMillisecondsSinceEpoch(timestamp);
      if (DateTime.now().difference(cachedAt) > maxAge) {
        await box.delete(key);
        return null;
      }
    }

    return cached['data'] as T?;
  }

  Future<void> removeCachedData(String key) async {
    final box = await _cacheBox;
    await box.delete(key);
  }

  Future<void> clearCache() async {
    final box = await _cacheBox;
    await box.clear();
  }

  Future<void> setSetting(String key, dynamic value) async {
    final box = await _settingsBox;
    await box.put(key, value);
  }

  Future<T?> getSetting<T>(String key) async {
    final box = await _settingsBox;
    return box.get(key) as T?;
  }
}
