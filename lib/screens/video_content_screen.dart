import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class VideoContentScreen extends StatefulWidget {
  const VideoContentScreen({super.key});

  @override
  State<VideoContentScreen> createState() => _VideoContentScreenState();
}

class _VideoContentScreenState extends State<VideoContentScreen> {
  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Meditation',
    'Exercise',
    'Educational',
    'Therapy',
    'Relaxation',
  ];

  final List<VideoResource> videoResources = [
    VideoResource(
      title: 'Morning Yoga for Mental Health',
      description: 'Gentle yoga routine to start your day with positive energy',
      duration: '15:30',
      category: 'Exercise',
      thumbnail: 'assets/images/yoga_thumbnail.jpg',
      videoFile: 'assets/videos/medition.mp4',
      instructor: 'Dr. Sarah Johnson',
      views: '12.5K',
      icon: Iconsax.activity,
      color: Colors.orange,
    ),
    VideoResource(
      title: 'Understanding Anxiety',
      description: 'Educational video about anxiety symptoms and management',
      duration: '22:15',
      category: 'Educational',
      thumbnail: 'assets/images/anxiety_education.jpg',
      videoFile: 'assets/videos/anxiety_education.mp4',
      instructor: 'Dr. Michael Chen',
      views: '25.8K',
      icon: Iconsax.book_1,
      color: Colors.blue,
    ),
    VideoResource(
      title: 'Guided Meditation Session',
      description: 'Complete meditation video for mental wellness and relaxation',
      duration: 'Variable',
      category: 'Meditation',
      thumbnail: 'assets/images/video.png',
      videoFile: 'assets/videos/medition.mp4',
      instructor: 'Mind Verse',
      views: 'New',
      icon: Iconsax.heart,
      color: Colors.deepPurple,
    ),
    VideoResource(
      title: 'Guided Meditation: Body Scan',
      description: 'Deep relaxation through progressive body awareness',
      duration: '18:45',
      category: 'Meditation',
      thumbnail: 'assets/images/meditation_thumbnail.jpg',
      videoFile: 'assets/videos/body_scan_meditation.mp4',
      instructor: 'Lisa Rodriguez',
      views: '18.2K',
      icon: Iconsax.heart,
      color: Colors.purple,
    ),
    VideoResource(
      title: 'Breathing Techniques for Stress',
      description: 'Learn effective breathing exercises to manage stress',
      duration: '8:20',
      category: 'Therapy',
      thumbnail: 'assets/images/breathing_thumbnail.jpg',
      videoFile: 'assets/videos/breathing_techniques.mp4',
      instructor: 'Dr. Emma Wilson',
      views: '9.1K',
      icon: Iconsax.wind,
      color: Colors.cyan,
    ),
    VideoResource(
      title: 'Progressive Muscle Relaxation',
      description: 'Step-by-step guide to release physical tension',
      duration: '25:10',
      category: 'Relaxation',
      thumbnail: 'assets/images/relaxation_thumbnail.jpg',
      videoFile: 'assets/videos/muscle_relaxation.mp4',
      instructor: 'Dr. James Park',
      views: '14.7K',
      icon: Iconsax.hospital,
      color: Colors.green,
    ),
    VideoResource(
      title: 'Mindful Walking Exercise',
      description: 'Transform your daily walk into a mindfulness practice',
      duration: '12:55',
      category: 'Exercise',
      thumbnail: 'assets/images/walking_thumbnail.jpg',
      videoFile: 'assets/videos/mindful_walking.mp4',
      instructor: 'Maria Garcia',
      views: '7.3K',
      icon: Iconsax.location,
      color: Colors.teal,
    ),
    VideoResource(
      title: 'Sleep Hygiene Tips',
      description: 'Improve your sleep quality with proven techniques',
      duration: '16:30',
      category: 'Educational',
      thumbnail: 'assets/images/sleep_thumbnail.jpg',
      videoFile: 'assets/videos/sleep_hygiene.mp4',
      instructor: 'Dr. Anna Roberts',
      views: '20.4K',
      icon: Iconsax.moon,
      color: Colors.indigo,
    ),
    VideoResource(
      title: 'Gratitude Meditation',
      description: 'Cultivate appreciation and positive mindset',
      duration: '10:15',
      category: 'Meditation',
      thumbnail: 'assets/images/gratitude_thumbnail.jpg',
      videoFile: 'assets/videos/gratitude_meditation.mp4',
      instructor: 'David Thompson',
      views: '11.9K',
      icon: Iconsax.heart_circle,
      color: Colors.amber,
    ),
  ];

  List<VideoResource> get filteredVideoResources {
    if (selectedCategory == 'All') {
      return videoResources;
    }
    return videoResources.where((video) => video.category == selectedCategory).toList();
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
          'Video Content',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              _showSearchDialog();
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

          // Video List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredVideoResources.length,
              itemBuilder: (context, index) {
                final video = filteredVideoResources[index];
                return VideoCard(
                  video: video,
                  onTap: () => _showVideoPlayer(video),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Videos'),
        content: TextField(
          decoration: const InputDecoration(
            hintText: 'Enter search terms...',
            border: OutlineInputBorder(),
          ),
          onSubmitted: (value) {
            Navigator.pop(context);
            // Implement search functionality
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Searching for: $value')),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showVideoPlayer(VideoResource video) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(video: video),
      ),
    );
  }
}

class VideoResource {
  final String title;
  final String description;
  final String duration;
  final String category;
  final String thumbnail;
  final String videoFile;
  final String instructor;
  final String views;
  final IconData icon;
  final Color color;

  VideoResource({
    required this.title,
    required this.description,
    required this.duration,
    required this.category,
    required this.thumbnail,
    required this.videoFile,
    required this.instructor,
    required this.views,
    required this.icon,
    required this.color,
  });
}

class VideoCard extends StatelessWidget {
  final VideoResource video;
  final VoidCallback onTap;

  const VideoCard({
    super.key,
    required this.video,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: video.color.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Stack(
                children: [
                  // Placeholder for video thumbnail
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          video.color.withOpacity(0.3),
                          video.color.withOpacity(0.1),
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Icon(
                      video.icon,
                      size: 60,
                      color: video.color.withOpacity(0.7),
                    ),
                  ),
                  
                  // Play button overlay
                  Center(
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  
                  // Duration badge
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        video.duration,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Video Info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    video.description,
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
                          color: video.color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          video.category,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: video.color,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.person,
                        size: 12,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        video.instructor,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[500],
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.visibility,
                        size: 12,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        video.views,
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
          ],
        ),
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final VideoResource video;

  const VideoPlayerScreen({super.key, required this.video});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  bool isPlaying = false;
  bool showControls = true;
  double progress = 0.0;
  double volume = 0.7;
  double playbackSpeed = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Video Player Area
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    widget.video.color.withOpacity(0.3),
                    widget.video.color.withOpacity(0.1),
                  ],
                ),
              ),
              child: Center(
                child: Icon(
                  widget.video.icon,
                  size: 100,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ),
            
            // Video Controls Overlay
            if (showControls)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: MediaQuery.of(context).size.height * 0.7,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            // Share functionality
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Video shared!')),
                            );
                          },
                          icon: const Icon(
                            Icons.share,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Download functionality
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Video downloaded!')),
                            );
                          },
                          icon: const Icon(
                            Icons.download,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            
            // Center Play Button
            if (showControls && !isPlaying)
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isPlaying = !isPlaying;
                      });
                    },
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ),
            
            // Bottom Controls
            if (showControls)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Progress bar
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: widget.video.color,
                            inactiveTrackColor: Colors.white.withOpacity(0.3),
                            thumbColor: widget.video.color,
                            overlayColor: widget.video.color.withOpacity(0.2),
                            trackHeight: 3,
                            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                          ),
                          child: Slider(
                            value: progress,
                            onChanged: (value) {
                              setState(() {
                                progress = value;
                              });
                            },
                          ),
                        ),
                        
                        // Time and controls
                        Row(
                          children: [
                            Text(
                              '${(progress * 22).toInt()}:${((progress * 22 % 1) * 60).toInt().toString().padLeft(2, '0')}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 16),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  progress = (progress - 0.05).clamp(0.0, 1.0);
                                });
                              },
                              icon: const Icon(
                                Icons.replay_10,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  isPlaying = !isPlaying;
                                });
                              },
                              icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  progress = (progress + 0.05).clamp(0.0, 1.0);
                                });
                              },
                              icon: const Icon(
                                Icons.forward_10,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              widget.video.duration,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              onPressed: () => _showSettingsModal(),
                              icon: const Icon(
                                Icons.settings,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            
            // Video Info (when not in fullscreen)
            Positioned(
              top: MediaQuery.of(context).size.height * 0.3,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and basic info
                      Text(
                        widget.video.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            '${widget.video.views} views',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: widget.video.color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              widget.video.category,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: widget.video.color,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Description
                      Text(
                        widget.video.description,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                          height: 1.5,
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Instructor info
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: widget.video.color.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Icon(
                                Icons.person,
                                color: widget.video.color,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Instructor',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Text(
                                    widget.video.instructor,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Action buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Added to favorites!')),
                                );
                              },
                              icon: const Icon(Icons.favorite_border, size: 18),
                              label: const Text('Save'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[100],
                                foregroundColor: Colors.black87,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Video shared!')),
                                );
                              },
                              icon: const Icon(Icons.share, size: 18),
                              label: const Text('Share'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: widget.video.color,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSettingsModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Video Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            
            // Playback Speed
            ListTile(
              leading: const Icon(Icons.speed),
              title: const Text('Playback Speed'),
              subtitle: Text('${playbackSpeed}x'),
              onTap: () {
                Navigator.pop(context);
                _showSpeedSelector();
              },
            ),
            
            // Volume
            ListTile(
              leading: const Icon(Icons.volume_up),
              title: const Text('Volume'),
              subtitle: Slider(
                value: volume,
                onChanged: (value) {
                  setState(() {
                    volume = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSpeedSelector() {
    final speeds = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Playback Speed'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: speeds.map((speed) => RadioListTile<double>(
            title: Text('${speed}x'),
            value: speed,
            groupValue: playbackSpeed,
            onChanged: (value) {
              setState(() {
                playbackSpeed = value!;
              });
              Navigator.pop(context);
            },
          )).toList(),
        ),
      ),
    );
  }
}
