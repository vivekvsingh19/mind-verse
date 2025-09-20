import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';

class VideoService extends ChangeNotifier {
  static final VideoService _instance = VideoService._internal();
  factory VideoService() => _instance;
  VideoService._internal();

  VideoPlayerController? _controller;
  bool _isPlaying = false;
  bool _isLoading = false;
  String? _currentVideo;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  // Getters
  VideoPlayerController? get controller => _controller;
  bool get isPlaying => _isPlaying;
  bool get isLoading => _isLoading;
  String? get currentVideo => _currentVideo;
  Duration get duration => _duration;
  Duration get position => _position;
  double get progress => _duration.inMilliseconds > 0 
      ? _position.inMilliseconds / _duration.inMilliseconds 
      : 0.0;
  bool get isInitialized => _controller?.value.isInitialized ?? false;

  Future<void> initializeVideo(String videoPath, {bool isAsset = true}) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Dispose previous controller if exists
      await _disposeController();

      // Create new controller
      if (isAsset) {
        _controller = VideoPlayerController.asset(videoPath);
      } else {
        _controller = VideoPlayerController.networkUrl(Uri.parse(videoPath));
      }

      _currentVideo = videoPath;

      // Initialize the controller
      await _controller!.initialize();
      
      _duration = _controller!.value.duration;
      
      // Listen to position changes
      _controller!.addListener(_videoListener);

    } catch (e) {
      if (kDebugMode) {
        print('Error initializing video: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _videoListener() {
    if (_controller != null) {
      _isPlaying = _controller!.value.isPlaying;
      _position = _controller!.value.position;
      _duration = _controller!.value.duration;
      notifyListeners();
    }
  }

  Future<void> play() async {
    if (_controller != null && _controller!.value.isInitialized) {
      await _controller!.play();
    }
  }

  Future<void> pause() async {
    if (_controller != null && _controller!.value.isInitialized) {
      await _controller!.pause();
    }
  }

  Future<void> seekTo(Duration position) async {
    if (_controller != null && _controller!.value.isInitialized) {
      await _controller!.seekTo(position);
    }
  }

  Future<void> setVolume(double volume) async {
    if (_controller != null && _controller!.value.isInitialized) {
      await _controller!.setVolume(volume);
    }
  }

  Future<void> setPlaybackSpeed(double speed) async {
    if (_controller != null && _controller!.value.isInitialized) {
      await _controller!.setPlaybackSpeed(speed);
    }
  }

  Future<void> _disposeController() async {
    if (_controller != null) {
      _controller!.removeListener(_videoListener);
      await _controller!.dispose();
      _controller = null;
    }
  }

  Future<void> stop() async {
    await _disposeController();
    _currentVideo = null;
    _isPlaying = false;
    _position = Duration.zero;
    _duration = Duration.zero;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }
}
