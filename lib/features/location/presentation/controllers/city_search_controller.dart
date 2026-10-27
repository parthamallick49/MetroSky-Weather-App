import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/location_repository_impl.dart';
import '../../domain/entities/location_item.dart';

/// Riverpod controller managing debounced geocoding search queries.
class CitySearchController extends StateNotifier<AsyncValue<List<LocationItem>>> {
  CitySearchController({required this.ref}) : super(const AsyncValue.data([]));

  final Ref ref;
  Timer? _debounceTimer;

  void onQueryChanged(String query) {
    _debounceTimer?.cancel();

    final trimmed = query.trim();
    if (trimmed.length < 2) {
      state = const AsyncValue.data([]);
      return;
    }

    state = const AsyncValue.loading();

    // 350ms input debouncing
    _debounceTimer = Timer(const Duration(milliseconds: 350), () async {
      final repository = ref.read(locationRepositoryProvider);
      try {
        final results = await repository.searchCities(trimmed);
        state = AsyncValue.data(results);
      } catch (e, st) {
        state = AsyncValue.error(e, st);
      }
    });
  }

  void clearSearch() {
    _debounceTimer?.cancel();
    state = const AsyncValue.data([]);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}

/// Global provider for [CitySearchController].
final citySearchControllerProvider =
    StateNotifierProvider.autoDispose<CitySearchController, AsyncValue<List<LocationItem>>>((ref) {
  return CitySearchController(ref: ref);
});
