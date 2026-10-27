import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/radar_repository_impl.dart';
import '../../domain/entities/radar_frame.dart';

/// State representation for radar map animation playback.
class RadarState {
  const RadarState({
    required this.timeline,
    required this.activeFrameIndex,
    this.isPlaying = false,
  });

  final RadarTimeline timeline;
  final int activeFrameIndex;
  final bool isPlaying;

  RadarFrame? get activeFrame {
    final frames = timeline.allFrames;
    if (activeFrameIndex >= 0 && activeFrameIndex < frames.length) {
      return frames[activeFrameIndex];
    }
    return frames.isNotEmpty ? frames.last : null;
  }

  String? get activeTileUrlTemplate {
    final frame = activeFrame;
    if (frame == null) return null;
    return frame.getTileUrlTemplate(timeline.host);
  }

  RadarState copyWith({
    RadarTimeline? timeline,
    int? activeFrameIndex,
    bool? isPlaying,
  }) {
    return RadarState(
      timeline: timeline ?? this.timeline,
      activeFrameIndex: activeFrameIndex ?? this.activeFrameIndex,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}

/// Riverpod AsyncNotifier managing radar frames and loop playback timer.
class RadarController extends AsyncNotifier<RadarState> {
  Timer? _playbackTimer;

  @override
  FutureOr<RadarState> build() async {
    final repository = ref.watch(radarRepositoryProvider);
    final timeline = await repository.getRadarTimeline();

    // Default to the latest past radar scan (most current real-time frame)
    final initialIndex = timeline.pastFrames.isNotEmpty
        ? timeline.pastFrames.length - 1
        : 0;

    ref.onDispose(() {
      _playbackTimer?.cancel();
    });

    return RadarState(
      timeline: timeline,
      activeFrameIndex: initialIndex,
      isPlaying: false,
    );
  }

  /// Toggles automated playback loop.
  void togglePlay() {
    final current = state.valueOrNull;
    if (current == null) return;

    if (current.isPlaying) {
      pause();
    } else {
      play();
    }
  }

  void play() {
    final current = state.valueOrNull;
    if (current == null) return;

    _playbackTimer?.cancel();
    state = AsyncValue.data(current.copyWith(isPlaying: true));

    _playbackTimer = Timer.periodic(const Duration(milliseconds: 550), (_) {
      stepForward();
    });
  }

  void pause() {
    _playbackTimer?.cancel();
    final current = state.valueOrNull;
    if (current != null) {
      state = AsyncValue.data(current.copyWith(isPlaying: false));
    }
  }

  void stepForward() {
    final current = state.valueOrNull;
    if (current == null) return;

    final total = current.timeline.frameCount;
    if (total == 0) return;

    final nextIndex = (current.activeFrameIndex + 1) % total;
    state = AsyncValue.data(current.copyWith(activeFrameIndex: nextIndex));
  }

  void stepBackward() {
    final current = state.valueOrNull;
    if (current == null) return;

    final total = current.timeline.frameCount;
    if (total == 0) return;

    final prevIndex = (current.activeFrameIndex - 1 + total) % total;
    state = AsyncValue.data(current.copyWith(activeFrameIndex: prevIndex));
  }

  void setFrameIndex(int index) {
    final current = state.valueOrNull;
    if (current == null) return;

    final total = current.timeline.frameCount;
    if (index >= 0 && index < total) {
      state = AsyncValue.data(current.copyWith(activeFrameIndex: index));
    }
  }
}

/// Global provider for [RadarController].
final radarControllerProvider =
    AsyncNotifierProvider<RadarController, RadarState>(RadarController.new);
