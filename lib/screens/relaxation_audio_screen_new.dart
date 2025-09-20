import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../widgets/audio_player_widget.dart';

class RelaxationAudioScreenNew extends StatefulWidget {
  const RelaxationAudioScreenNew({super.key});

  @override
  State<RelaxationAudioScreenNew> createState() => _RelaxationAudioScreenNewState();
}

class _RelaxationAudioScreenNewState extends State<RelaxationAudioScreenNew> {
  String selectedCategory = 'All';

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
      icon: Iconsax.cloud_drizzle,
      color: Colors.green,
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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Relaxation Audio'),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.arrow_down),
            onPressed: () {
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

          // Audio List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 16),
              itemCount: filteredAudioResources.length,
              itemBuilder: (context, index) {
                final audio = filteredAudioResources[index];
                
                return AudioPlayerWidget(
                  title: audio.title,
                  subtitle: '${audio.description} • ${audio.duration}',
                  audioPath: audio.audioFile,
                  primaryColor: audio.color,
                  showFullControls: true,
                );
              },
            ),
          ),
        ],
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
