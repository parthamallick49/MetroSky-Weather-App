import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/widgets/app_glass_card.dart';
import '../../../../core/widgets/app_icon_button.dart';
import '../controllers/radar_controller.dart';

/// Glassmorphic time scrubber controls for animated radar playback.
class RadarTimeScrubber extends StatelessWidget {
  const RadarTimeScrubber({
    super.key,
    required this.state,
    required this.onPlayToggle,
    required this.onStepForward,
    required this.onStepBackward,
    required this.onScrub,
  });

  final RadarState state;
  final VoidCallback onPlayToggle;
  final VoidCallback onStepForward;
  final VoidCallback onStepBackward;
  final ValueChanged<int> onScrub;

  @override
  Widget build(BuildContext context) {
    final frame = state.activeFrame;
    final total = state.timeline.frameCount;
    final isNowcast = frame?.isNowcast ?? false;
    final timeString = frame?.dateTime.toTimeString() ?? '--:--';

    return AppGlassCard(
      borderRadius: 24.0,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header Row: Status badge and formatted time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Badge (Past vs Forecast)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: isNowcast
                      ? const Color(0x33AB47BC) // 20% purple
                      : const Color(0x3329B6F6), // 20% blue
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: isNowcast ? const Color(0xFFAB47BC) : const Color(0xFF29B6F6),
                    width: 1.0,
                  ),
                ),
                child: Text(
                  isNowcast ? 'PREDICTIVE NOWCAST' : 'RADAR HISTORY',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: isNowcast ? const Color(0xFFCE93D8) : const Color(0xFF81D4FA),
                  ),
                ),
              ),

              // Frame Time
              Text(
                timeString,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),

          // Slider Scrubber Track
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.white,
              inactiveTrackColor: const Color(0x33FFFFFF),
              thumbColor: Colors.white,
              overlayColor: const Color(0x26FFFFFF),
              trackHeight: 4.0,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7.0),
            ),
            child: Slider(
              value: state.activeFrameIndex.toDouble().clamp(0.0, (total > 1 ? total - 1 : 1).toDouble()),
              min: 0.0,
              max: (total > 1 ? total - 1 : 1).toDouble(),
              divisions: total > 1 ? total - 1 : 1,
              onChanged: (val) => onScrub(val.round()),
            ),
          ),

          // Playback Buttons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppIconButton(
                size: 38.0,
                iconSize: 16.0,
                icon: LucideIcons.skipBack,
                tooltip: 'Previous Frame',
                onPressed: onStepBackward,
              ),
              const SizedBox(width: 16.0),
              AppIconButton(
                size: 52.0,
                iconSize: 24.0,
                icon: state.isPlaying ? LucideIcons.pause : LucideIcons.play,
                iconColor: Colors.white,
                tooltip: state.isPlaying ? 'Pause' : 'Play',
                onPressed: onPlayToggle,
              ),
              const SizedBox(width: 16.0),
              AppIconButton(
                size: 38.0,
                iconSize: 16.0,
                icon: LucideIcons.skipForward,
                tooltip: 'Next Frame',
                onPressed: onStepForward,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
