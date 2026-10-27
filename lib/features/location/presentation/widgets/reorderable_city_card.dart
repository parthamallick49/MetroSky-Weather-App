import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_glass_card.dart';
import '../../domain/entities/location_item.dart';

/// Reorderable glass card representing a saved city with drag handle and tap selection.
class ReorderableCityCard extends StatelessWidget {
  const ReorderableCityCard({
    super.key,
    required this.location,
    required this.index,
    required this.onTap,
    required this.onDelete,
  });

  final LocationItem location;
  final int index;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('${location.name}_${location.latitude}_${location.longitude}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24.0),
        margin: const EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          color: Colors.redAccent.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: const Icon(LucideIcons.trash2, color: Colors.white, size: 24.0),
      ),
      onDismissed: (_) => onDelete(),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: AppGlassCard(
          borderRadius: 20.0,
          onTap: onTap,
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
          child: Row(
            children: [
              // Icon Badge (GPS icon for current, MapPin for saved)
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: location.isCurrentLocation
                      ? const Color(0x3329B6F6)
                      : const Color(0x26FFFFFF),
                ),
                child: Icon(
                  location.isCurrentLocation ? LucideIcons.locateFixed : LucideIcons.mapPin,
                  size: 20.0,
                  color: location.isCurrentLocation ? const Color(0xFF29B6F6) : Colors.white,
                ),
              ),
              const SizedBox(width: 14.0),

              // City Name & Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      location.name,
                      style: const TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      location.subtitle,
                      style: const TextStyle(
                        fontSize: 13.0,
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Reorder Drag Handle
              ReorderableDragStartListener(
                index: index,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    LucideIcons.gripVertical,
                    size: 20.0,
                    color: AppColors.textTertiary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
