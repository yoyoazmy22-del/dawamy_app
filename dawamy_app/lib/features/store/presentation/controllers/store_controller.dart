import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../domain/models/store_data.dart';
import '../../data/repositories/store_repository_impl.dart';

class StoreState {
  final StoreLink? storeLink;
  final bool isLoading;
  final String? error;
  final bool showWebView;

  const StoreState({
    this.storeLink,
    this.isLoading = false,
    this.error,
    this.showWebView = false,
  });

  StoreState copyWith({
    StoreLink? storeLink,
    bool? isLoading,
    String? error,
    bool? showWebView,
  }) {
    return StoreState(
      storeLink: storeLink ?? this.storeLink,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      showWebView: showWebView ?? this.showWebView,
    );
  }
}

class StoreNotifier extends StateNotifier<StoreState> {
  final StoreRepository _repository;

  StoreNotifier(this._repository) : super(const StoreState());

  Future<void> loadStoreLink() async {
    state = state.copyWith(isLoading: true);
    try {
      final link = await _repository.getStoreLink();
      state = state.copyWith(storeLink: link, isLoading: false);
    } catch (_) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> saveStoreLink(String url, {String? name}) async {
    final link = StoreLink(
      id: const Uuid().v4(),
      url: url,
      name: name,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await _repository.saveStoreLink(link);
    state = state.copyWith(storeLink: link, error: null);
  }

  Future<void> removeStoreLink() async {
    await _repository.removeStoreLink();
    state = state.copyWith(storeLink: null);
  }

  void openWebView() {
    state = state.copyWith(showWebView: true);
  }

  void closeWebView() {
    state = state.copyWith(showWebView: false);
  }
}

final storeProvider = StateNotifierProvider<StoreNotifier, StoreState>((ref) {
  return StoreNotifier(ref.read(storeRepositoryProvider));
});
