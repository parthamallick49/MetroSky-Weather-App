import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_glass_card.dart';
import '../../../../core/widgets/app_shimmer_placeholder.dart';
import '../../domain/entities/location_item.dart';
import '../controllers/city_search_controller.dart';
import '../controllers/saved_locations_controller.dart';

/// Modal bottom sheet allowing users to search and add global cities.
class CitySearchSheet extends ConsumerStatefulWidget {
  const CitySearchSheet({
    super.key,
    required this.onLocationSelected,
  });

  final ValueChanged<LocationItem> onLocationSelected;

  static Future<void> show(
    BuildContext context, {
    required ValueChanged<LocationItem> onLocationSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CitySearchSheet(onLocationSelected: onLocationSelected),
    );
  }

  @override
  ConsumerState<CitySearchSheet> createState() => _CitySearchSheetState();
}

class _CitySearchSheetState extends ConsumerState<CitySearchSheet> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchAsync = ref.watch(citySearchControllerProvider);

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: AppGlassCard(
        borderRadius: 28.0,
        backgroundColor: const Color(0xE6141828), // 90% opaque dark navy
        padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 24.0),
        child: Column(
          children: [
            // Drag Handle Bar
            Container(
              width: 36.0,
              height: 4.0,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            const SizedBox(height: 16.0),

            // Search Bar Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: const Color(0x26FFFFFF),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: const Color(0x33FFFFFF)),
              ),
              child: Row(
                children: [
                  const Icon(LucideIcons.search, size: 20.0, color: AppColors.textSecondary),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      autofocus: true,
                      style: const TextStyle(color: Colors.white, fontSize: 16.0),
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                        hintText: 'Search city or region...',
                        hintStyle: TextStyle(color: AppColors.textTertiary),
                        border: InputBorder.none,
                      ),
                      onChanged: (val) {
                        ref.read(citySearchControllerProvider.notifier).onQueryChanged(val);
                      },
                    ),
                  ),
                  if (_textController.text.isNotEmpty)
                    IconButton(
                      icon: const Icon(LucideIcons.x, size: 18.0, color: AppColors.textSecondary),
                      onPressed: () {
                        _textController.clear();
                        ref.read(citySearchControllerProvider.notifier).clearSearch();
                      },
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),

            // Search Results List
            Expanded(
              child: searchAsync.when(
                loading: () => ListView.separated(
                  itemCount: 4,
                  separatorBuilder: (_, __) => const SizedBox(height: 12.0),
                  itemBuilder: (_, __) => const AppGlassCard(
                    padding: EdgeInsets.all(14.0),
                    child: Row(
                      children: [
                        AppShimmerPlaceholder.circular(size: 36.0),
                        SizedBox(width: 12.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppShimmerPlaceholder(width: 120.0, height: 16.0),
                            SizedBox(height: 6.0),
                            AppShimmerPlaceholder(width: 80.0, height: 12.0),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                error: (err, _) => Center(
                  child: Text(
                    'Error searching locations: $err',
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                ),
                data: (results) {
                  if (results.isEmpty) {
                    return Center(
                      child: Text(
                        _textController.text.length < 2
                            ? 'Enter at least 2 characters to search'
                            : 'No locations found',
                        style: const TextStyle(color: AppColors.textTertiary),
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: results.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8.0),
                    itemBuilder: (context, index) {
                      final item = results[index];

                      return InkWell(
                        borderRadius: BorderRadius.circular(16.0),
                        onTap: () {
                          // Save to favorites
                          ref.read(savedLocationsControllerProvider.notifier).addLocation(item);
                          widget.onLocationSelected(item);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                          decoration: BoxDecoration(
                            color: const Color(0x1AFFFFFF),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Row(
                            children: [
                              const Icon(LucideIcons.mapPin, size: 20.0, color: Colors.white70),
                              const SizedBox(width: 14.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      item.subtitle,
                                      style: const TextStyle(
                                        fontSize: 13.0,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(LucideIcons.plus, size: 18.0, color: Colors.white54),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
