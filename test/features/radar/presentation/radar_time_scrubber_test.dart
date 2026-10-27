import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/theme/app_theme.dart';
import 'package:weather_app/features/radar/domain/entities/radar_frame.dart';
import 'package:weather_app/features/radar/presentation/controllers/radar_controller.dart';
import 'package:weather_app/features/radar/presentation/widgets/radar_time_scrubber.dart';

void main() {
  testWidgets('RadarTimeScrubber renders frame details and triggers playback controls', (tester) async {
    final timeline = RadarTimeline(
      host: 'https://tilecache.rainviewer.com',
      pastFrames: const [
        RadarFrame(timestamp: 1728994000, path: '/v2/radar/1728994000', isNowcast: false),
        RadarFrame(timestamp: 1728994600, path: '/v2/radar/1728994600', isNowcast: false),
      ],
      nowcastFrames: const [
        RadarFrame(timestamp: 1729001200, path: '/v2/radar/1729001200', isNowcast: true),
      ],
      generatedAt: DateTime.now(),
    );

    final radarState = RadarState(
      timeline: timeline,
      activeFrameIndex: 1,
      isPlaying: false,
    );

    var playToggled = false;
    var stepForwardClicked = false;
    var stepBackwardClicked = false;
    int? scrubbedIndex;

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.darkTheme,
        home: Scaffold(
          body: RadarTimeScrubber(
            state: radarState,
            onPlayToggle: () => playToggled = true,
            onStepForward: () => stepForwardClicked = true,
            onStepBackward: () => stepBackwardClicked = true,
            onScrub: (idx) => scrubbedIndex = idx,
          ),
        ),
      ),
    );

    await tester.pump();

    // Verify radar history badge is shown for past frame
    expect(find.text('RADAR HISTORY'), findsOneWidget);

    // Tap play button
    await tester.tap(find.byTooltip('Play'));
    expect(playToggled, isTrue);

    // Tap skip forward
    await tester.tap(find.byTooltip('Next Frame'));
    expect(stepForwardClicked, isTrue);

    // Tap skip backward
    await tester.tap(find.byTooltip('Previous Frame'));
    expect(stepBackwardClicked, isTrue);

    expect(scrubbedIndex, isNull);
  });
}
