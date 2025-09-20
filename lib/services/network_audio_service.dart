import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;

class NetworkAudioService extends ChangeNotifier {
  static final NetworkAudioService _instance = NetworkAudioService._internal();
  factory NetworkAudioService() => _instance;
  NetworkAudioService._internal() {
    _init();
  }

  final AudioPlayer _audioPlayer = AudioPlayer();
  
  bool _isPlaying = false;
  bool _isLoading = false;
  bool _isBuffering = false;
  String? _currentTrack;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  Duration _bufferedPosition = Duration.zero;
  double _speed = 1.0;
  double _volume = 1.0;

  // Network status
  bool _hasNetworkError = false;
  String? _errorMessage;

  // Getters
  bool get isPlaying => _isPlaying;
  bool get isLoading => _isLoading;
  bool get isBuffering => _isBuffering;
  String? get currentTrack => _currentTrack;
  Duration get duration => _duration;
  Duration get position => _position;
  Duration get bufferedPosition => _bufferedPosition;
  double get speed => _speed;
  double get volume => _volume;
  bool get hasNetworkError => _hasNetworkError;
  String? get errorMessage => _errorMessage;
  
  double get progress => _duration.inMilliseconds > 0 
      ? _position.inMilliseconds / _duration.inMilliseconds 
      : 0.0;
      
  double get bufferedProgress => _duration.inMilliseconds > 0 
      ? _bufferedPosition.inMilliseconds / _duration.inMilliseconds 
      : 0.0;

  void _init() {
    // Listen to player state changes
    _audioPlayer.playerStateStream.listen((state) {
      _isPlaying = state.playing;
      _isLoading = state.processingState == ProcessingState.loading;
      _isBuffering = state.processingState == ProcessingState.buffering;
      
      // Handle completion
      if (state.processingState == ProcessingState.completed) {
        _isPlaying = false;
        _position = Duration.zero;
      }
      
      notifyListeners();
    });

    // Listen to position changes
    _audioPlayer.positionStream.listen((position) {
      _position = position;
      notifyListeners();
    });

    // Listen to buffered position changes
    _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
      _bufferedPosition = bufferedPosition;
      notifyListeners();
    });

    // Listen to duration changes
    _audioPlayer.durationStream.listen((duration) {
      _duration = duration ?? Duration.zero;
      notifyListeners();
    });
  }

  // Check if URL is valid and accessible
  Future<bool> _validateUrl(String url) async {
    try {
      final response = await http.head(Uri.parse(url));
      return response.statusCode == 200;
    } catch (e) {
      if (kDebugMode) {
        print('URL validation error: $e');
      }
      return false;
    }
  }

  // Play from asset
  Future<void> playAsset(String assetPath) async {
    try {
      _clearError();
      _isLoading = true;
      notifyListeners();
      
      await _audioPlayer.setAsset(assetPath);
      _currentTrack = assetPath;
      await _audioPlayer.play();
    } catch (e) {
      _handleError('Error playing asset: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Play from network URL
  Future<void> playFromUrl(String url, {String? title}) async {
    try {
      _clearError();
      _isLoading = true;
      notifyListeners();

      // Validate URL first
      if (!await _validateUrl(url)) {
        throw Exception('Invalid or inaccessible URL');
      }

      await _audioPlayer.setUrl(url);
      _currentTrack = title ?? url;
      await _audioPlayer.play();
    } catch (e) {
      _handleError('Error streaming audio: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Create a playlist from URLs
  Future<void> playPlaylist(List<AudioSource> sources) async {
    try {
      _clearError();
      _isLoading = true;
      notifyListeners();

      final playlist = ConcatenatingAudioSource(children: sources);
      await _audioPlayer.setAudioSource(playlist);
      await _audioPlayer.play();
    } catch (e) {
      _handleError('Error playing playlist: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Play/pause controls
  Future<void> play() async {
    try {
      await _audioPlayer.play();
    } catch (e) {
      _handleError('Error playing: $e');
    }
  }

  Future<void> pause() async {
    try {
      await _audioPlayer.pause();
    } catch (e) {
      _handleError('Error pausing: $e');
    }
  }

  Future<void> stop() async {
    try {
      await _audioPlayer.stop();
      _currentTrack = null;
      _position = Duration.zero;
      _clearError();
      notifyListeners();
    } catch (e) {
      _handleError('Error stopping: $e');
    }
  }

  // Seek to position
  Future<void> seek(Duration position) async {
    try {
      await _audioPlayer.seek(position);
    } catch (e) {
      _handleError('Error seeking: $e');
    }
  }

  // Set playback speed
  Future<void> setSpeed(double speed) async {
    try {
      _speed = speed;
      await _audioPlayer.setSpeed(speed);
      notifyListeners();
    } catch (e) {
      _handleError('Error setting speed: $e');
    }
  }

  // Set volume
  Future<void> setVolume(double volume) async {
    try {
      _volume = volume.clamp(0.0, 1.0);
      await _audioPlayer.setVolume(_volume);
      notifyListeners();
    } catch (e) {
      _handleError('Error setting volume: $e');
    }
  }

  // Skip to next track (if playlist)
  Future<void> skipToNext() async {
    try {
      if (_audioPlayer.hasNext) {
        await _audioPlayer.seekToNext();
      }
    } catch (e) {
      _handleError('Error skipping to next: $e');
    }
  }

  // Skip to previous track (if playlist)
  Future<void> skipToPrevious() async {
    try {
      if (_audioPlayer.hasPrevious) {
        await _audioPlayer.seekToPrevious();
      }
    } catch (e) {
      _handleError('Error skipping to previous: $e');
    }
  }

  // Set loop mode
  Future<void> setLoopMode(LoopMode loopMode) async {
    try {
      await _audioPlayer.setLoopMode(loopMode);
    } catch (e) {
      _handleError('Error setting loop mode: $e');
    }
  }

  // Set shuffle mode
  Future<void> setShuffleMode(bool enabled) async {
    try {
      await _audioPlayer.setShuffleModeEnabled(enabled);
    } catch (e) {
      _handleError('Error setting shuffle mode: $e');
    }
  }

  void _handleError(String message) {
    _hasNetworkError = true;
    _errorMessage = message;
    if (kDebugMode) {
      print(message);
    }
    notifyListeners();
  }

  void _clearError() {
    _hasNetworkError = false;
    _errorMessage = null;
  }

  void clearError() {
    _clearError();
    notifyListeners();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}

// Helper class for network audio sources
class NetworkAudioSource {
  static AudioSource fromUrl(String url, {String? tag, Map<String, String>? headers}) {
    return AudioSource.uri(
      Uri.parse(url),
      headers: headers,
    );
  }

  static AudioSource fromAsset(String assetPath, {String? tag}) {
    return AudioSource.asset(assetPath);
  }
}

// Common streaming audio URLs for testing
class StreamingAudioUrls {
  static const List<Map<String, String>> relaxationStreams = [
    {
      'title': 'Nature Sounds - Rain Forest',
      'url': 'https://www.soundjay.com/misc/sounds/rainforest-ambient.mp3',
      'category': 'Nature',
    },
    {
      'title': 'Ocean Waves',
      'url': 'https://www.soundjay.com/misc/sounds/ocean-waves.mp3',
      'category': 'Nature',
    },
    {
      'title': 'White Noise',
      'url': 'https://www.soundjay.com/misc/sounds/white-noise.mp3',
      'category': 'Focus',
    },
  ];

  static const List<Map<String, String>> meditationStreams = [
    {
      'title': 'Guided Meditation',
      'url': 'https://www.soundjay.com/misc/sounds/meditation-bell.mp3',
      'category': 'Meditation',
    },
    {
      'title': 'Tibetan Singing Bowls',
      'url': 'https://www.soundjay.com/misc/sounds/tibetan-bowl.mp3',
      'category': 'Meditation',
    },
  ];
}
