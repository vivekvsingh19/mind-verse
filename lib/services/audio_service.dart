import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

class AudioService extends ChangeNotifier {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal() {
    _init();
  }

  final AudioPlayer _audioPlayer = AudioPlayer();
  
  bool _isPlaying = false;
  bool _isLoading = false;
  String? _currentTrack;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  double _speed = 1.0;

  // Getters
  bool get isPlaying => _isPlaying;
  bool get isLoading => _isLoading;
  String? get currentTrack => _currentTrack;
  Duration get duration => _duration;
  Duration get position => _position;
  double get speed => _speed;
  double get progress => _duration.inMilliseconds > 0 
      ? _position.inMilliseconds / _duration.inMilliseconds 
      : 0.0;

  void _init() {
    // Listen to player state changes
    _audioPlayer.playerStateStream.listen((state) {
      _isPlaying = state.playing;
      _isLoading = state.processingState == ProcessingState.loading ||
                   state.processingState == ProcessingState.buffering;
      notifyListeners();
    });

    // Listen to position changes
    _audioPlayer.positionStream.listen((position) {
      _position = position;
      notifyListeners();
    });

    // Listen to duration changes
    _audioPlayer.durationStream.listen((duration) {
      _duration = duration ?? Duration.zero;
      notifyListeners();
    });

    // Listen to playback completion
    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _isPlaying = false;
        _position = Duration.zero;
        notifyListeners();
      }
    });
  }

  Future<void> playAsset(String assetPath) async {
    try {
      _isLoading = true;
      notifyListeners();
      
      await _audioPlayer.setAsset(assetPath);
      _currentTrack = assetPath;
      await _audioPlayer.play();
    } catch (e) {
      if (kDebugMode) {
        print('Error playing audio: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> playUrl(String url) async {
    try {
      _isLoading = true;
      notifyListeners();
      
      await _audioPlayer.setUrl(url);
      _currentTrack = url;
      await _audioPlayer.play();
    } catch (e) {
      if (kDebugMode) {
        print('Error playing audio: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> play() async {
    await _audioPlayer.play();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    _currentTrack = null;
    _position = Duration.zero;
    notifyListeners();
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  Future<void> setSpeed(double speed) async {
    _speed = speed;
    await _audioPlayer.setSpeed(speed);
    notifyListeners();
  }

  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
