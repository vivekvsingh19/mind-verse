import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../widgets/audio_player_widget.dart';

class RelaxationAudioScreen extends StatefulWidget {
  const RelaxationAudioScreen({super.key});

  @override
  State<RelaxationAudioScreen> createState() => _RelaxationAudioScreenState();
}

class _RelaxationAudioScreenState extends State<RelaxationAudioScreen> {
  String selectedCategory = 'All';
  bool isPlaying = false;
  String? currentlyPlaying;
  double playbackPosition = 0.0;
  double totalDuration = 1.0;

  final List<String> categories = [
    'All',
    'Meditation',
    'Nature Sounds',
    'Breathing',
    'Sleep',
    'Focus',
  ];

  final List<AudioResource> audioResources = [
    AudioResource(
      title: 'Guided Morning Meditation',
      description: 'Start your day with peaceful mindfulness',
      duration: '10:00',
      category: 'Meditation',
      audioFile: 'assets/audio/guided_meditation.mp3',
      icon: Iconsax.sun_1,
      color: Colors.orange,
    ),
    AudioResource(
      title: 'Deep Breathing Exercise',
      description: 'Reduce anxiety with controlled breathing',
      duration: '5:00',
      category: 'Breathing',
      audioFile: 'assets/audio/breathing_exercise.mp3',
      icon: Iconsax.heart,
      color: Colors.blue,
    ),
    AudioResource(
      title: 'Forest Rain Sounds',
      description: 'Calming rain in a peaceful forest',
      duration: '30:00',
      category: 'Nature Sounds',
      audioFile: 'assets/audio/nature_sounds.mp3',
      icon: Iconsax.tree,
      color: Colors.green,
    ),
    AudioResource(
      title: 'Ocean Waves',
      description: 'Gentle waves for relaxation and sleep',
      duration: '45:00',
      category: 'Nature Sounds',
      audioFile: 'assets/audio/ocean_waves.mp3',
      icon: Iconsax.drop,
      color: Colors.cyan,
    ),
    AudioResource(
      title: 'Sleep Meditation',
      description: 'Drift off to peaceful sleep',
      duration: '20:00',
      category: 'Sleep',
      audioFile: 'assets/audio/sleep_meditation.mp3',
      icon: Iconsax.moon,
      color: Colors.indigo,
    ),
    AudioResource(
      title: 'Focus Music',
      description: 'Instrumental music for concentration',
      duration: '60:00',
      category: 'Focus',
      audioFile: 'assets/audio/focus_music.mp3',
      icon: Iconsax.headphone,
      color: Colors.purple,
    ),
    AudioResource(
      title: 'Anxiety Relief Meditation',
      description: 'Calm your mind and reduce worry',
      duration: '15:00',
      category: 'Meditation',
      audioFile: 'assets/audio/anxiety_relief.mp3',
      icon: Iconsax.shield_tick,
      color: Colors.teal,
    ),
    AudioResource(
      title: 'Body Scan Relaxation',
      description: 'Progressive muscle relaxation guide',
      duration: '25:00',
      category: 'Meditation',
      audioFile: 'assets/audio/body_scan.mp3',
      icon: Iconsax.scan_barcode,
      color: Colors.amber,
    ),
  ];

  List<AudioResource> get filteredAudioResources {
    if (selectedCategory == 'All') {
      return audioResources;
    }
    return audioResources.where((audio) => audio.category == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Relaxation Audio',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.download_outlined, color: Colors.black),
            onPressed: () {
              // Download functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Audio downloaded for offline use!')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Filter
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
                    selectedColor: const Color(0xFF00898C).withOpacity(0.2),
                    labelStyle: TextStyle(
                      color: isSelected ? const Color(0xFF00898C) : Colors.grey[600],
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                    side: BorderSide(
                      color: isSelected ? const Color(0xFF00898C) : Colors.grey[300]!,
                    ),
                  ),
                );
              },
            ),
          ),

          // Audio List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredAudioResources.length,
              itemBuilder: (context, index) {
                final audio = filteredAudioResources[index];
                return AudioCard(
                  audio: audio,
                  isPlaying: currentlyPlaying == audio.title && isPlaying,
                  onPlayPause: () => _togglePlayPause(audio),
                  onTap: () => _showAudioPlayer(audio),
                );
              },
            ),
          ),
        ],
      ),
      
      // Mini Player (when audio is playing)
      bottomSheet: currentlyPlaying != null
          ? Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: _buildMiniPlayer(),
            )
          : null,
    );
  }

  Widget _buildMiniPlayer() {
    final currentAudio = audioResources.firstWhere(
      (audio) => audio.title == currentlyPlaying,
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: currentAudio.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              currentAudio.icon,
              color: currentAudio.color,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  currentAudio.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  currentAudio.duration,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          
          // Play/Pause button
          IconButton(
            onPressed: () => _togglePlayPause(currentAudio),
            icon: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: currentAudio.color,
              size: 28,
            ),
          ),
          
          // Expand button
          IconButton(
            onPressed: () => _showAudioPlayer(currentAudio),
            icon: const Icon(
              Icons.expand_less,
              color: Colors.grey,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  void _togglePlayPause(AudioResource audio) {
    setState(() {
      if (currentlyPlaying == audio.title) {
        isPlaying = !isPlaying;
      } else {
        currentlyPlaying = audio.title;
        isPlaying = true;
        playbackPosition = 0.0;
      }
    });

    // Show feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isPlaying ? 'Playing ${audio.title}' : 'Paused'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _showAudioPlayer(AudioResource audio) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullAudioPlayerScreen(
          audio: audio,
          isPlaying: currentlyPlaying == audio.title && isPlaying,
          onPlayPause: () => _togglePlayPause(audio),
        ),
      ),
    );
  }
}

class AudioResource {
  final String title;
  final String description;
  final String duration;
  final String category;
  final String audioFile;
  final IconData icon;
  final Color color;

  AudioResource({
    required this.title,
    required this.description,
    required this.duration,
    required this.category,
    required this.audioFile,
    required this.icon,
    required this.color,
  });
}

class AudioCard extends StatelessWidget {
  final AudioResource audio;
  final bool isPlaying;
  final VoidCallback onPlayPause;
  final VoidCallback onTap;

  const AudioCard({
    super.key,
    required this.audio,
    required this.isPlaying,
    required this.onPlayPause,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: audio.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  audio.icon,
                  color: audio.color,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      audio.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      audio.description,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: audio.color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            audio.category,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: audio.color,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.access_time,
                          size: 12,
                          color: Colors.grey[500],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          audio.duration,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Play/Pause button
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: audio.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: IconButton(
                  onPressed: onPlayPause,
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: audio.color,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FullAudioPlayerScreen extends StatefulWidget {
  final AudioResource audio;
  final bool isPlaying;
  final VoidCallback onPlayPause;

  const FullAudioPlayerScreen({
    super.key,
    required this.audio,
    required this.isPlaying,
    required this.onPlayPause,
  });

  @override
  State<FullAudioPlayerScreen> createState() => _FullAudioPlayerScreenState();
}

class _FullAudioPlayerScreenState extends State<FullAudioPlayerScreen> {
  double playbackPosition = 0.3;
  double volume = 0.7;
  bool isLooping = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.audio.color.withOpacity(0.05),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.expand_more, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download_outlined, color: Colors.black),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Audio downloaded!')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.black),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Audio shared!')),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Spacer(),
            
            // Album Art
            Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                color: widget.audio.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: widget.audio.color.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(
                widget.audio.icon,
                color: widget.audio.color,
                size: 120,
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Title and Description
            Text(
              widget.audio.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              widget.audio.description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 40),
            
            // Progress bar
            Column(
              children: [
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: widget.audio.color,
                    inactiveTrackColor: widget.audio.color.withOpacity(0.3),
                    thumbColor: widget.audio.color,
                    overlayColor: widget.audio.color.withOpacity(0.2),
                    trackHeight: 4,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                  ),
                  child: Slider(
                    value: playbackPosition,
                    onChanged: (value) {
                      setState(() {
                        playbackPosition = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${(playbackPosition * 25).toInt()}:${((playbackPosition * 25 % 1) * 60).toInt().toString().padLeft(2, '0')}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        widget.audio.duration,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 40),
            
            // Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      isLooping = !isLooping;
                    });
                  },
                  icon: Icon(
                    Icons.repeat,
                    color: isLooping ? widget.audio.color : Colors.grey,
                    size: 28,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      playbackPosition = (playbackPosition - 0.1).clamp(0.0, 1.0);
                    });
                  },
                  icon: const Icon(
                    Icons.skip_previous,
                    color: Colors.grey,
                    size: 36,
                  ),
                ),
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: widget.audio.color,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: widget.audio.color.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: widget.onPlayPause,
                    icon: Icon(
                      widget.isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      playbackPosition = (playbackPosition + 0.1).clamp(0.0, 1.0);
                    });
                  },
                  icon: const Icon(
                    Icons.skip_next,
                    color: Colors.grey,
                    size: 36,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Show volume control
                    _showVolumeControl();
                  },
                  icon: Icon(
                    volume > 0.5 ? Icons.volume_up : volume > 0 ? Icons.volume_down : Icons.volume_off,
                    color: Colors.grey,
                    size: 28,
                  ),
                ),
              ],
            ),
            
            const Spacer(),
          ],
        ),
      ),
    );
  }

  void _showVolumeControl() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Volume'),
        content: StatefulBuilder(
          builder: (context, setStateDialog) => SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: widget.audio.color,
              inactiveTrackColor: widget.audio.color.withOpacity(0.3),
              thumbColor: widget.audio.color,
            ),
            child: Slider(
              value: volume,
              onChanged: (value) {
                setStateDialog(() {
                  volume = value;
                });
                setState(() {
                  volume = value;
                });
              },
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}
