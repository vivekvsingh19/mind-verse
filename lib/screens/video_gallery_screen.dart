import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../widgets/video_player_widget.dart';

class VideoGalleryScreen extends StatefulWidget {
  const VideoGalleryScreen({super.key});

  @override
  State<VideoGalleryScreen> createState() => _VideoGalleryScreenState();
}

class _VideoGalleryScreenState extends State<VideoGalleryScreen> {
  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Meditation',
    'Exercise',
    'Educational',
    'Therapy',
    'Relaxation',
  ];

  final List<VideoContent> videoContents = [
    VideoContent(
      title: 'Morning Yoga for Mental Health',
      subtitle: 'Gentle yoga routine to start your day with positive energy',
      videoPath: 'assets/videos/morning_yoga.mp4',
      thumbnailPath: 'assets/images/video.png',
      category: 'Exercise',
      duration: '15:30',
      instructor: 'Dr. Sarah Johnson',
      color: Colors.orange,
    ),
    VideoContent(
      title: 'Understanding Anxiety',
      subtitle: 'Educational video about anxiety symptoms and management',
      videoPath: 'assets/videos/anxiety_education.mp4',
      thumbnailPath: 'assets/images/video_content.png',
      category: 'Educational',
      duration: '22:15',
      instructor: 'Dr. Michael Chen',
      color: Colors.blue,
    ),
    VideoContent(
      title: 'Meditation Session',
      subtitle: 'Calming meditation video for mental wellness',
      videoPath: 'assets/videos/medition.mp4',
      thumbnailPath: 'assets/images/video.png',
      category: 'Meditation',
      duration: 'Variable',
      instructor: 'Mind Verse',
      color: Colors.purple,
    ),
    // Example of online video
    VideoContent(
      title: 'Sample Online Video',
      subtitle: 'Example of streaming video content',
      videoPath: 'https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_1mb.mp4',
      category: 'Educational',
      duration: '0:30',
      instructor: 'Online Content',
      color: Colors.teal,
      isAsset: false,
    ),
  ];

  List<VideoContent> get filteredVideos {
    if (selectedCategory == 'All') {
      return videoContents;
    }
    return videoContents.where((video) => video.category == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Gallery'),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.search_normal),
            onPressed: () {
              // TODO: Implement search functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Search functionality coming soon!')),
              );
            },
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

          // Video grid/list
          Expanded(
            child: filteredVideos.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Iconsax.video_slash,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No videos found',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try selecting a different category',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: filteredVideos.length,
                    itemBuilder: (context, index) {
                      final video = filteredVideos[index];
                      
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullScreenVideoPlayer(video: video),
                            ),
                          );
                        },
                        child: VideoPlayerWidget(
                          title: video.title,
                          subtitle: '${video.subtitle}\n👨‍🏫 ${video.instructor} • ${video.duration}',
                          videoPath: video.videoPath,
                          isAsset: video.isAsset,
                          thumbnailPath: video.thumbnailPath,
                          autoPlay: false,
                          showControls: true,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class FullScreenVideoPlayer extends StatelessWidget {
  final VideoContent video;

  const FullScreenVideoPlayer({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          video.title,
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: VideoPlayerWidget(
          title: video.title,
          subtitle: video.subtitle,
          videoPath: video.videoPath,
          isAsset: video.isAsset,
          thumbnailPath: video.thumbnailPath,
          autoPlay: true,
          showControls: true,
        ),
      ),
    );
  }
}

class VideoContent {
  final String title;
  final String subtitle;
  final String videoPath;
  final String? thumbnailPath;
  final String category;
  final String duration;
  final String instructor;
  final Color color;
  final bool isAsset;

  VideoContent({
    required this.title,
    required this.subtitle,
    required this.videoPath,
    this.thumbnailPath,
    required this.category,
    required this.duration,
    required this.instructor,
    required this.color,
    this.isAsset = true,
  });
}
