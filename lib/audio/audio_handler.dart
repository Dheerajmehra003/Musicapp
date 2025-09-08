import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class MyAudioHandler extends BaseAudioHandler with SeekHandler {
  final _player = AudioPlayer();

  // Internal queue
  final _queue = <MediaItem>[];

  MyAudioHandler() {
    // Update playback state when the player changes
    _player.playbackEventStream.listen((event) {
      playbackState.add(
        playbackState.value.copyWith(
          controls: [MediaControl.play, MediaControl.pause, MediaControl.stop],
          systemActions: const {MediaAction.seek},
          playing: _player.playing,
          processingState: _transformProcessingState(_player.processingState),
          bufferedPosition: _player.bufferedPosition,
          speed: _player.speed,
        ),
      );
    });
  }

  // Convert just_audio's ProcessingState to AudioService's
  AudioProcessingState _transformProcessingState(ProcessingState state) {
    switch (state) {
      case ProcessingState.idle:
        return AudioProcessingState.idle;
      case ProcessingState.loading:
        return AudioProcessingState.loading;
      case ProcessingState.buffering:
        return AudioProcessingState.buffering;
      case ProcessingState.ready:
        return AudioProcessingState.ready;
      case ProcessingState.completed:
        return AudioProcessingState.completed;
    }
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() => _player.stop();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    _queue.add(mediaItem);
    queue.add(_queue); // update queue stream

    // If this is the first song, start playing
    if (_queue.length == 1) {
      await _player.setAudioSource(AudioSource.uri(Uri.parse(mediaItem.id)));
    }
  }

  @override
  Future<void> skipToNext() async {
    final currentIndex = _player.currentIndex ?? 0;
    if (currentIndex + 1 < _queue.length) {
      final nextItem = _queue[currentIndex + 1];
      await _player.setAudioSource(AudioSource.uri(Uri.parse(nextItem.id)));
      playbackState.add(playbackState.value.copyWith(playing: true));
      await play();
    }
  }
}
