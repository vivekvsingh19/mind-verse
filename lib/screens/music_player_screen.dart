import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../widgets/audio_player_widget.dart';
import '../services/audio_service.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  final AudioService _audioService = AudioService();
  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Meditation',
    'Nature Sounds',
    'Breathing',
    'Sleep',
    'Focus',
  ];

  final List<MusicTrack> musicTracks = [
    MusicTrack(
      title: 'Guided Morning Meditation',
      subtitle: 'Start your day with peaceful mindfulness',
      audioPath: 'assets/audio/guided_meditation.mp3',
      category: 'Meditation',
      duration: '10:00',
      color: Colors.orange,
    ),
    MusicTrack(
      title: 'Deep Breathing Exercise',
      subtitle: 'Reduce anxiety with controlled breathing',
      audioPath: 'assets/audio/breathing_exercise.mp3',
      category: 'Breathing',
      duration: '5:00',
      color: Colors.blue,
    ),
    MusicTrack(
      title: 'Forest Rain Sounds',
      subtitle: 'Calming rain in a peaceful forest',
      audioPath: 'assets/audio/nature_sounds.mp3',
      category: 'Nature Sounds',
      duration: '30:00',
      color: Colors.green,
    ),
    // You can add online tracks as well
    MusicTrack(
      title: 'Online Relaxation Music',
      subtitle: 'Streaming relaxation music',
      audioPath: 'https://www.soundjay.com/misc/sounds/birds-19.mp3',
      category: 'Nature Sounds',
      duration: '2:30',
      color: Colors.teal,
      isAsset: false,
    ),
  ];

  List<MusicTrack> get filteredTracks {
    if (selectedCategory == 'All') {
      return musicTracks;
    }
    return musicTracks.where((track) => track.category == selectedCategory).toList();
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
        title: const Text('Music Player'),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.stop),
            onPressed: () => _audioService.stop(),
            tooltip: 'Stop all audio',
          ),
        ],
      ),
      body: Column(
        children: [
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
                    child: Icon(
                      _audioService.isPlaying ? Iconsax.pause : Iconsax.play,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Now Playing',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
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
                  Text(
                    '${_formatDuration(_audioService.position)} / ${_formatDuration(_audioService.duration)}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Music tracks list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 16),
              itemCount: filteredTracks.length,
              itemBuilder: (context, index) {
                final track = filteredTracks[index];
                
                return AudioPlayerWidget(
                  title: track.title,
                  subtitle: '${track.subtitle} • ${track.duration}',
                  audioPath: track.audioPath,
                  isAsset: track.isAsset,
                  primaryColor: track.color,
                  showFullControls: true,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getCurrentTrackTitle() {
    final currentTrack = musicTracks.firstWhere(
      (track) => track.audioPath == _audioService.currentTrack,
      orElse: () => MusicTrack(
        title: 'Unknown Track',
        subtitle: '',
        audioPath: '',
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
}

class MusicTrack {
  final String title;
  final String subtitle;
  final String audioPath;
  final String category;
  final String duration;
  final Color color;
  final bool isAsset;

  MusicTrack({
    required this.title,
    required this.subtitle,
    required this.audioPath,
    required this.category,
    required this.duration,
    required this.color,
    this.isAsset = true,
  });
}
