import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../widgets/network_audio_player_widget.dart';
import '../services/network_audio_service.dart';

class StreamingAudioDemo extends StatefulWidget {
  const StreamingAudioDemo({super.key});

  @override
  State<StreamingAudioDemo> createState() => _StreamingAudioDemoState();
}

class _StreamingAudioDemoState extends State<StreamingAudioDemo> {
  final NetworkAudioService _audioService = NetworkAudioService();
  
  // Free audio streaming URLs for demonstration
  final List<DemoAudioTrack> demoTracks = [
    DemoAudioTrack(
      title: 'NASA Audio - Sounds of Earth',
      subtitle: 'Nature sounds from NASA archives',
      streamUrl: 'https://www.nasa.gov/wp-content/uploads/2015/01/apollo_11_launch.mp3',
      category: 'Educational',
      color: Colors.blue,
      description: 'Historic audio from NASA missions',
    ),
    DemoAudioTrack(
      title: 'Internet Archive - Classical Music',
      subtitle: 'Public domain classical compositions',
      streamUrl: 'https://archive.org/download/MusOpen_-_Pachelbel_-_Canon_in_D/Pachelbel_-_Canon_in_D.mp3',
      category: 'Classical',
      color: Colors.purple,
      description: 'Classical music from Internet Archive',
    ),
    DemoAudioTrack(
      title: 'Freesound - Rain Ambience',
      subtitle: 'Atmospheric rain sounds',
      streamUrl: 'https://freesound.org/data/previews/316/316847_5515105-lq.mp3',
      category: 'Nature',
      color: Colors.green,
      description: 'High-quality nature sounds',
    ),
    DemoAudioTrack(
      title: 'BBC Test Audio',
      subtitle: 'Audio quality test file',
      streamUrl: 'http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio1xtra_mf_p',
      category: 'Test',
      color: Colors.orange,
      description: 'Audio streaming test',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _audioService.addListener(_onAudioStateChanged);
  }

  @override
  void dispose() {
    _audioService.removeListener(_onAudioStateChanged);
    super.dispose();
  }

  void _onAudioStateChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Streaming Demo'),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.info_circle),
            onPressed: () => _showInfoDialog(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Header info
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: theme.colorScheme.primary.withOpacity(0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Iconsax.global,
                      color: theme.colorScheme.primary,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Network Audio Streaming',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'These are example streaming audio sources. Replace with your own URLs for production use.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          // Network status
          if (_audioService.hasNetworkError) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.red[50],
              child: Row(
                children: [
                  Icon(
                    Iconsax.warning_2,
                    color: Colors.red[600],
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _audioService.errorMessage ?? 'Network error occurred',
                      style: TextStyle(
                        color: Colors.red[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _audioService.clearError(),
                    child: const Text('Clear'),
                  ),
                ],
              ),
            ),
          ],

          // Currently playing
          if (_audioService.currentTrack != null) ...[
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary.withOpacity(0.1),
                    theme.colorScheme.primary.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: theme.colorScheme.primary.withOpacity(0.3),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              _audioService.isPlaying ? Iconsax.pause : Iconsax.play,
                              color: Colors.white,
                              size: 24,
                            ),
                            if (_audioService.isBuffering)
                              CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Now Streaming',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              _getCurrentTrackTitle(),
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (_audioService.isBuffering)
                              Text(
                                'Buffering...',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.orange[600],
                                ),
                              )
                            else if (_audioService.duration.inSeconds > 0)
                              Text(
                                '${_formatDuration(_audioService.position)} / ${_formatDuration(_audioService.duration)}',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.grey[600],
                                ),
                              ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => _audioService.stop(),
                        icon: const Icon(Iconsax.stop),
                      ),
                    ],
                  ),
                  if (_audioService.duration.inSeconds > 0) ...[
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: _audioService.progress,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],

          // Demo tracks list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 16),
              itemCount: demoTracks.length,
              itemBuilder: (context, index) {
                final track = demoTracks[index];
                
                return NetworkAudioPlayerWidget(
                  title: track.title,
                  subtitle: '${track.subtitle} • ${track.category}',
                  audioUrl: track.streamUrl,
                  primaryColor: track.color,
                  showFullControls: true,
                  isNetworkStream: true,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            heroTag: 'test',
            onPressed: () => _testCustomUrl(),
            child: const Icon(Iconsax.link),
            tooltip: 'Test custom URL',
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'add',
            onPressed: () => _showAddUrlDialog(),
            child: const Icon(Iconsax.add),
            tooltip: 'Add custom stream',
          ),
        ],
      ),
    );
  }

  String _getCurrentTrackTitle() {
    final currentTrack = demoTracks.firstWhere(
      (track) => track.streamUrl == _audioService.currentTrack || track.title == _audioService.currentTrack,
      orElse: () => DemoAudioTrack(
        title: 'Custom Stream',
        subtitle: '',
        streamUrl: '',
        category: '',
        color: Colors.grey,
        description: '',
      ),
    );
    return currentTrack.title;
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  void _testCustomUrl() {
    // Test with a known working audio URL
    const testUrl = 'https://www.soundjay.com/misc/sounds/bell-ringing-05.mp3';
    _audioService.playFromUrl(testUrl, title: 'Test Audio');
  }

  void _showAddUrlDialog() {
    final urlController = TextEditingController();
    final titleController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Custom Audio Stream'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Stream Title',
                hintText: 'Enter a name for this stream',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: urlController,
              decoration: const InputDecoration(
                labelText: 'Audio URL',
                hintText: 'https://example.com/audio.mp3',
              ),
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 16),
            Text(
              'Note: Only publicly accessible audio URLs will work.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (urlController.text.isNotEmpty && titleController.text.isNotEmpty) {
                _audioService.playFromUrl(
                  urlController.text,
                  title: titleController.text,
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Play'),
          ),
        ],
      ),
    );
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Iconsax.info_circle),
            SizedBox(width: 8),
            Text('Audio Streaming Info'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('This demo shows network audio streaming capabilities:'),
            SizedBox(height: 16),
            Text('Features:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('• Stream audio from URLs'),
            Text('• Background buffering'),
            Text('• Progress tracking'),
            Text('• Error handling'),
            Text('• Volume & speed controls'),
            SizedBox(height: 16),
            Text(
              'Note: Some URLs may not work due to CORS policies or server restrictions.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class DemoAudioTrack {
  final String title;
  final String subtitle;
  final String streamUrl;
  final String category;
  final Color color;
  final String description;

  DemoAudioTrack({
    required this.title,
    required this.subtitle,
    required this.streamUrl,
    required this.category,
    required this.color,
    required this.description,
  });
}
