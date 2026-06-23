import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skyba_bonus/features/transactions/data/models/receipt.dart';
import 'package:skyba_bonus/features/transactions/data/transactions_repository.dart';

final transactionsDateRangeProvider =
    StateProvider<({DateTime from, DateTime to})>((ref) {
  final now = DateTime.now();
  return (
    from: DateTime(now.year, now.month - 1, now.day),
    to: now,
  );
});

final transactionsProvider =
    AsyncNotifierProvider<TransactionsNotifier, List<Receipt>>(
  TransactionsNotifier.new,
);

class TransactionsNotifier extends AsyncNotifier<List<Receipt>> {
  static const _pageSize = 20;
  bool _hasMore = true;

  bool get hasMore => _hasMore;

  @override
  Future<List<Receipt>> build() async {
    final dateRange = ref.watch(transactionsDateRangeProvider);
    _hasMore = true;
    return _fetchTransactions(dateRange.from, dateRange.to, 0);
  }

  Future<List<Receipt>> _fetchTransactions(
    DateTime from,
    DateTime to,
    int offset,
  ) async {
    final repository = ref.read(transactionsRepositoryProvider);
    final receipts = await repository.getTransactions(
      fromDate: from,
      toDate: to,
      limit: _pageSize,
      offset: offset,
    );
    _hasMore = receipts.length >= _pageSize;
    return receipts;
  }

  Future<void> loadMore() async {
    if (!_hasMore) return;
    final currentData = state.valueOrNull ?? [];
    final dateRange = ref.read(transactionsDateRangeProvider);

    try {
      final moreReceipts = await _fetchTransactions(
        dateRange.from,
        dateRange.to,
        currentData.length,
      );
      state = AsyncValue.data([...currentData, ...moreReceipts]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    _hasMore = true;
    ref.invalidateSelf();
  }
}

final receiptDetailProvider =
    FutureProvider.family<Receipt, String>((ref, id) async {
  final repository = ref.watch(transactionsRepositoryProvider);
  return repository.getTransaction(id);
});
