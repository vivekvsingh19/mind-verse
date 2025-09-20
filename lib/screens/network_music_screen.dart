import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../widgets/network_audio_player_widget.dart';
import '../services/network_audio_service.dart';

class NetworkMusicScreen extends StatefulWidget {
  const NetworkMusicScreen({super.key});

  @override
  State<NetworkMusicScreen> createState() => _NetworkMusicScreenState();
}

class _NetworkMusicScreenState extends State<NetworkMusicScreen> {
  final NetworkAudioService _audioService = NetworkAudioService();
  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Nature',
    'Meditation',
    'Focus',
    'Sleep',
    'Relaxation',
  ];

  // Sample network audio streams (replace with your actual streaming URLs)
  final List<NetworkMusicTrack> networkTracks = [
    NetworkMusicTrack(
      title: 'Rain Forest Sounds',
      subtitle: 'Natural rainfall in tropical forest',
      streamUrl: 'https://www.soundjay.com/misc/sounds/rainforest-ambient.mp3',
      category: 'Nature',
      duration: 'Streaming',
      color: Colors.green,
      isLive: false,
    ),
    NetworkMusicTrack(
      title: 'Ocean Waves',
      subtitle: 'Calming ocean waves for relaxation',
      streamUrl: 'https://www.soundjay.com/misc/sounds/ocean-waves.mp3',
      category: 'Nature',
      duration: 'Streaming',
      color: Colors.blue,
      isLive: false,
    ),
    NetworkMusicTrack(
      title: 'Meditation Bell',
      subtitle: 'Tibetan singing bowl meditation',
      streamUrl: 'https://www.soundjay.com/misc/sounds/meditation-bell.mp3',
      category: 'Meditation',
      duration: 'Streaming',
      color: Colors.purple,
      isLive: false,
    ),
    NetworkMusicTrack(
      title: 'White Noise',
      subtitle: 'Focus and concentration sounds',
      streamUrl: 'https://www.soundjay.com/misc/sounds/white-noise.mp3',
      category: 'Focus',
      duration: 'Streaming',
      color: Colors.grey,
      isLive: false,
    ),
    NetworkMusicTrack(
      title: 'Relaxing Piano',
      subtitle: 'Soft piano melodies for sleep',
      streamUrl: 'https://www.soundjay.com/misc/sounds/piano-melody.mp3',
      category: 'Sleep',
      duration: 'Streaming',
      color: Colors.indigo,
      isLive: false,
    ),
    // Live stream example
    NetworkMusicTrack(
      title: 'Live Relaxation Radio',
      subtitle: '24/7 relaxation music stream',
      streamUrl: 'https://streams.relaxationradio.com/live',
      category: 'Relaxation',
      duration: 'Live',
      color: Colors.red,
      isLive: true,
    ),
  ];

  List<NetworkMusicTrack> get filteredTracks {
    if (selectedCategory == 'All') {
      return networkTracks;
    }
    return networkTracks.where((track) => track.category == selectedCategory).toList();
  }

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
        title: const Text('Network Music Streaming'),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.wifi),
            onPressed: () => _showNetworkInfo(),
            tooltip: 'Network info',
          ),
          IconButton(
            icon: const Icon(Iconsax.stop),
            onPressed: () => _audioService.stop(),
            tooltip: 'Stop all streaming',
          ),
        ],
      ),
      body: Column(
        children: [
          // Network status indicator
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: _audioService.hasNetworkError 
                ? Colors.red[50] 
                : Colors.green[50],
            child: Row(
              children: [
                Icon(
                  _audioService.hasNetworkError 
                      ? Iconsax.wifi_square 
                      : Iconsax.wifi,
                  color: _audioService.hasNetworkError 
                      ? Colors.red[600] 
                      : Colors.green[600],
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _audioService.hasNetworkError 
                        ? 'Network connection issues detected'
                        : 'Network streaming available',
                    style: TextStyle(
                      color: _audioService.hasNetworkError 
                          ? Colors.red[700] 
                          : Colors.green[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (_audioService.hasNetworkError)
                  TextButton(
                    onPressed: () => _audioService.clearError(),
                    child: const Text('Retry'),
                  ),
              ],
            ),
          ),

          // Category filters
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category;
                
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    backgroundColor: Colors.white,
                    selectedColor: theme.colorScheme.primary.withOpacity(0.2),
                    checkmarkColor: theme.colorScheme.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? theme.colorScheme.primary : Colors.grey[600],
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                    side: BorderSide(
                      color: isSelected ? theme.colorScheme.primary : Colors.grey[300]!,
                    ),
                  ),
                );
              },
            ),
          ),

          // Now Playing Bar (if something is playing)
          if (_audioService.currentTrack != null) ...[
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: theme.colorScheme.primary.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
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
                          size: 20,
                        ),
                        if (_audioService.isBuffering)
                          CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Iconsax.global,
                              size: 12,
                              color: theme.colorScheme.primary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Now Streaming',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          _getCurrentTrackTitle(),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _audioService.isBuffering ? 'Buffering...' : 'Live',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      if (_audioService.duration.inSeconds > 0)
                        Text(
                          '${_formatDuration(_audioService.position)} / ${_formatDuration(_audioService.duration)}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],

          // Network tracks list
          Expanded(
            child: filteredTracks.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Iconsax.wifi_square,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No network streams found',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Check your internet connection',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: filteredTracks.length,
                    itemBuilder: (context, index) {
                      final track = filteredTracks[index];
                      
                      return NetworkAudioPlayerWidget(
                        title: track.title,
                        subtitle: '${track.subtitle} • ${track.duration}${track.isLive ? ' • LIVE' : ''}',
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddStreamDialog(),
        child: const Icon(Iconsax.add),
        tooltip: 'Add custom stream',
      ),
    );
  }

  String _getCurrentTrackTitle() {
    final currentTrack = networkTracks.firstWhere(
      (track) => track.streamUrl == _audioService.currentTrack || track.title == _audioService.currentTrack,
      orElse: () => NetworkMusicTrack(
        title: 'Unknown Stream',
        subtitle: '',
        streamUrl: '',
        category: '',
        duration: '',
        color: Colors.grey,
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

  void _showNetworkInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Iconsax.info_circle),
            SizedBox(width: 8),
            Text('Network Info'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Network streaming allows you to play audio directly from the internet.'),
            const SizedBox(height: 16),
            const Text('Features:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('• Live radio streams'),
            const Text('• On-demand audio content'),
            const Text('• Background buffering'),
            const Text('• Quality adjustment'),
            const SizedBox(height: 16),
            Text(
              'Note: Streaming requires an active internet connection.',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
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

  void _showAddStreamDialog() {
    final urlController = TextEditingController();
    final titleController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Custom Stream'),
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
                labelText: 'Stream URL',
                hintText: 'https://example.com/stream.mp3',
              ),
              keyboardType: TextInputType.url,
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
}

class NetworkMusicTrack {
  final String title;
  final String subtitle;
  final String streamUrl;
  final String category;
  final String duration;
  final Color color;
  final bool isLive;

  NetworkMusicTrack({
    required this.title,
    required this.subtitle,
    required this.streamUrl,
    required this.category,
    required this.duration,
    required this.color,
    this.isLive = false,
  });
}
