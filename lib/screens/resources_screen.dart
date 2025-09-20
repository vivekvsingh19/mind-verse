import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'breathing_exercise_screen.dart';
import 'wellness_guide_screen.dart';
import 'relaxation_audio_screen.dart';
import 'video_content_screen.dart';
import 'motivational_stories_screen.dart';

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({super.key});

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  String selectedCategory = 'All';
  String selectedLanguage = 'English';

  final List<String> categories = [
    'All',
    'Anxiety',
    'Depression',
    'Stress',
    'Sleep',
    'Relationships',
    'Self-Care',
  ];

  final List<String> languages = [
    'English',
    'Hindi',
    'Tamil',
    'Telugu',
    'Bengali',
    'Marathi',
  ];

  final List<Resource> resources = [
    Resource(
      title: 'Managing Anxiety in College',
      description: 'Learn practical techniques to handle anxiety during your studies',
      type: ResourceType.guide,
      duration: '15 min read',
      language: 'English',
      category: 'Anxiety',
      thumbnail: Icons.article,
    ),
    Resource(
      title: 'Guided Meditation for Sleep',
      description: 'A calming meditation to help you fall asleep peacefully',
      type: ResourceType.audio,
      duration: '20 min',
      language: 'Hindi',
      category: 'Sleep',
      thumbnail: Icons.bedtime,
    ),
    Resource(
      title: 'Stress Management Workshop',
      description: 'Interactive workshop on managing academic stress',
      type: ResourceType.video,
      duration: '45 min',
      language: 'English',
      category: 'Stress',
      thumbnail: Icons.play_circle,
    ),
    Resource(
      title: 'Building Healthy Relationships',
      description: 'Tips for maintaining good relationships in college',
      type: ResourceType.guide,
      duration: '12 min read',
      language: 'Tamil',
      category: 'Relationships',
      thumbnail: Icons.favorite,
    ),
    Resource(
      title: 'Daily Self-Care Routine',
      description: 'Simple self-care practices for busy students',
      type: ResourceType.video,
      duration: '25 min',
      language: 'English',
      category: 'Self-Care',
      thumbnail: Icons.self_improvement,
    ),
    Resource(
      title: 'Understanding Depression',
      description: 'Comprehensive guide to recognizing and managing depression',
      type: ResourceType.guide,
      duration: '20 min read',
      language: 'Bengali',
      category: 'Depression',
      thumbnail: Icons.psychology,
    ),
    Resource(
      title: 'The Power of Small Steps',
      description: 'Inspiring story about overcoming challenges one step at a time',
      type: ResourceType.guide,
      duration: '5 min read',
      language: 'English',
      category: 'Motivation',
      thumbnail: Icons.auto_awesome,
    ),
    Resource(
      title: 'Student Success Stories',
      description: 'Real stories of students who overcame mental health challenges',
      type: ResourceType.audio,
      duration: '10 min',
      language: 'Hindi',
      category: 'Motivation',
      thumbnail: Icons.campaign,
    ),
    Resource(
      title: 'Daily Motivation Quotes',
      description: 'Uplifting quotes and short stories to brighten your day',
      type: ResourceType.guide,
      duration: '3 min read',
      language: 'English',
      category: 'Motivation',
      thumbnail: Icons.format_quote,
    ),
  ];

  List<Resource> get filteredResources {
    return resources.where((resource) {
      final categoryMatch = selectedCategory == 'All' || resource.category == selectedCategory;
      final languageMatch = selectedLanguage == 'English' || resource.language == selectedLanguage;
      return categoryMatch && languageMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        //backgroundColor: const Color(0xFF009f53),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Resources',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
           
            // Wellness Guide Card
            _buildResourceCard(
              title: 'Wellness Guide',
              subtitle: 'Mental health tips and resources',
              color: const Color(0xFFE0F7FA), // Very light teal
              imageAsset: 'assets/images/wellness.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WellnessGuideScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

             // Motivational Stories Card
            _buildResourceCard(
              title: 'Motivational Stories',
              subtitle: 'Inspiring failure-to-success stories',
              color: const Color(0xFFFFF3E0), // Very light orange
              imageAsset: 'assets/images/motivate.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MotivationalStoriesScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            // Relaxation Audio Card
            _buildResourceCard(
              title: 'Relaxation Audio',
              subtitle: 'Calming sounds and meditations',
              color: const Color(0xFFE3F2FD), // Very light blue
              imageAsset: 'assets/images/music.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RelaxationAudioScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            // Video Content Card
            _buildResourceCard(
              title: 'Video',
              subtitle: 'Visual guides and exercises',
              color: const Color(0xFFE8F5E9), // Very light green
              imageAsset: 'assets/images/video.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VideoContentScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            
            
          ],
        ),
      ),
    );
  }

  Widget _buildResourceCard({
    required String title,
    required String subtitle,
    required Color color,
    required String imageAsset,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 220,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: color.withOpacity(0.25), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.18),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
          gradient: LinearGradient(
            colors: [color.withOpacity(0.98), color.withOpacity(0.85)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      child: Row(
        children: [
          // Content side
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.4,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 18),
                 
                ],
              ),
            ),
          ),
          
          // Image/Illustration side
          Container(
            width: 140,
            height: 220,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: title == 'Wellness Guide'
                  ? Image.asset(
                      'assets/images/wellness.png',
                      width: 140,
                      height: 220,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback to icon if image fails to load
                        return Center(
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            
                          ),
                        );
                      },
                    )
                  : title == 'Relaxation Audio'
                      ? Image.asset(
                          'assets/images/music.png',
                          width: 140,
                          height: 220,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            // Fallback to icon if image fails to load
                            return Center(
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: color.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                
                              ),
                            );
                          },
                        )
                      : title == 'Video'
                          ? Image.asset(
                              'assets/images/video.png',
                              width: 140,
                              height: 220,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                // Fallback to icon if image fails to load
                                return Center(
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: color.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    
                                  ),
                                );
                              },
                            )
                          : title == 'Motivational Stories'
                              ? Image.asset(
                                  'assets/images/motivate.png',
                                  width: 140,
                                  height: 220,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    // Fallback to icon if image fails to load
                                    return Center(
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: color.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                       
                                      ),
                                    );
                                  },
                                )
                              : title == 'Breathing Exercise'
                                  ? Image.asset(
                                      'assets/images/relaxation_audio.png',
                                      width: 140,
                                      height: 220,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        // Fallback to icon if image fails to load
                                        return Center(
                                          child: Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              color: color.withOpacity(0.2),
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            
                                          ),
                                        );
                                      },
                                    )
                                  : Center(
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        
                        
                      ),
                    ),
            ),
          ),
        ],
      ),
      ),
    );
  }
}

enum ResourceType { guide, audio, video }

class Resource {
  final String title;
  final String description;
  final ResourceType type;
  final String duration;
  final String language;
  final String category;
  final IconData thumbnail;

  Resource({
    required this.title,
    required this.description,
    required this.type,
    required this.duration,
    required this.language,
    required this.category,
    required this.thumbnail,
  });
}

class ResourceCard extends StatelessWidget {
  final Resource resource;

  const ResourceCard({super.key, required this.resource});

  String get typeLabel {
    switch (resource.type) {
      case ResourceType.guide:
        return 'Guide';
      case ResourceType.audio:
        return 'Audio';
      case ResourceType.video:
        return 'Video';
    }
  }

  Color getTypeColor(BuildContext context) {
    switch (resource.type) {
      case ResourceType.guide:
        return Colors.blue;
      case ResourceType.audio:
        return Colors.green;
      case ResourceType.video:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to resource details
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Thumbnail
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: getTypeColor(context).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  resource.thumbnail,
                  color: getTypeColor(context),
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      resource.title,
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
                      resource.description,
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
                            color: getTypeColor(context).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            typeLabel,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: getTypeColor(context),
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
                          resource.duration,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[500],
                          ),
                        ),
                        const Spacer(),
                        Text(
                          resource.language,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Action button
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
