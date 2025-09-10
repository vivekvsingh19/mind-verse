import 'package:flutter/material.dart';

class PeerSupportScreen extends StatefulWidget {
  const PeerSupportScreen({super.key});

  @override
  State<PeerSupportScreen> createState() => _PeerSupportScreenState();
}

class _PeerSupportScreenState extends State<PeerSupportScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<CommunityPost> posts = [
    CommunityPost(
      id: '1',
      content: 'Started my final exams today and feeling really overwhelmed. Any tips for managing exam stress? 😰',
      authorName: 'Anonymous Student',
      timeAgo: '2h ago',
      likes: 12,
      comments: 8,
      tags: ['exam-stress', 'anxiety'],
      isLiked: false,
    ),
    CommunityPost(
      id: '2',
      content: 'Just wanted to share that meditation has been helping me so much with my anxiety. Started with just 5 minutes a day and now up to 20! Small steps count 💪',
      authorName: 'MindfulStudent',
      timeAgo: '4h ago',
      likes: 28,
      comments: 15,
      tags: ['meditation', 'progress', 'anxiety'],
      isLiked: true,
    ),
    CommunityPost(
      id: '3',
      content: 'Having trouble sleeping before important interviews. Anyone else experience this? How do you calm your mind?',
      authorName: 'NightOwl23',
      timeAgo: '6h ago',
      likes: 9,
      comments: 12,
      tags: ['sleep', 'interviews', 'anxiety'],
      isLiked: false,
    ),
    CommunityPost(
      id: '4',
      content: 'Reminder: It\'s okay to not be okay sometimes. Reached out for help today and feeling proud of myself for taking that step! 🌱',
      authorName: 'BraveHeart',
      timeAgo: '1d ago',
      likes: 45,
      comments: 22,
      tags: ['mental-health', 'support', 'positivity'],
      isLiked: true,
    ),
  ];

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
          'Peer Support',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () {
              // Add new post
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Quick mood check
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'How are you feeling today?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildMoodButton('😊', 'Great', const Color(0xFF00898C)),
                    _buildMoodButton('😌', 'Good', const Color(0xFF6BCF7F)),
                    _buildMoodButton('😐', 'Okay', const Color(0xFFFFE66D)),
                    _buildMoodButton('😔', 'Low', const Color(0xFFFF8A80)),
                    _buildMoodButton('😢', 'Bad', const Color(0xFFFF6B6B)),
                  ],
                ),
              ],
            ),
          ),

          // Community Posts
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 3, // Sample posts
              itemBuilder: (context, index) {
                return _buildPostCard(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodButton(String emoji, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: color.withOpacity(0.3), width: 1),
          ),
          child: Center(
            child: Text(
              emoji,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildPostCard(int index) {
    final postData = [
      {
        'user': 'Anonymous Student',
        'time': '2 hours ago',
        'content': 'Feeling overwhelmed with assignments lately. Anyone else struggling with time management?',
        'likes': 12,
        'comments': 5,
        'mood': '😔',
      },
      {
        'user': 'Peer Supporter',
        'time': '4 hours ago',
        'content': 'Remember: It\'s okay to take breaks. Your mental health is just as important as your grades. 💚',
        'likes': 24,
        'comments': 8,
        'mood': '😊',
      },
      {
        'user': 'Anonymous Student',
        'time': '6 hours ago',
        'content': 'Had my first counseling session today. Taking that first step was scary but worth it!',
        'likes': 18,
        'comments': 12,
        'mood': '😌',
      },
    ];

    final post = postData[index % postData.length];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User info and mood
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF00898C).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.person,
                  color: Color(0xFF00898C),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post['user'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      post['time'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                post['mood'] as String,
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Post content
          Text(
            post['content'] as String,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          
          // Interaction buttons
          Row(
            children: [
              _buildInteractionButton(
                Icons.favorite_border,
                post['likes'] as int,
                Colors.red,
              ),
              const SizedBox(width: 24),
              _buildInteractionButton(
                Icons.chat_bubble_outline,
                post['comments'] as int,
                Colors.blue,
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.more_horiz),
                onPressed: () {},
                color: Colors.grey[600],
                iconSize: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionButton(IconData icon, int count, Color color) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildFeedTab() {
    return RefreshIndicator(
      onRefresh: () async {
        // Implement refresh logic
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: posts.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildWelcomeCard();
          }
          return PostCard(
            post: posts[index - 1],
            onLike: (postId) => _toggleLike(postId),
            onComment: (postId) => _showCommentsDialog(context, postId),
          );
        },
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.1),
            Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.people,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Safe Space Guidelines',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '• All interactions are anonymous\n• Be kind and supportive\n• Respect others\' experiences\n• No medical advice or diagnosis',
            style: TextStyle(
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportGroupsTab() {
    final groups = [
      {
        'name': 'Exam Stress Support',
        'members': 234,
        'description': 'A community for students dealing with exam anxiety and academic pressure',
        'isJoined': true,
      },
      {
        'name': 'Sleep & Wellness',
        'members': 156,
        'description': 'Sharing tips and experiences about improving sleep and overall wellness',
        'isJoined': false,
      },
      {
        'name': 'Social Anxiety Circle',
        'members': 89,
        'description': 'Support for students facing challenges with social interactions',
        'isJoined': true,
      },
      {
        'name': 'Mindfulness Practice',
        'members': 312,
        'description': 'Daily mindfulness and meditation practice group',
        'isJoined': false,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final group = groups[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              child: Icon(
                Icons.group,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            title: Text(
              group['name'] as String,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(group['description'] as String),
                const SizedBox(height: 4),
                Text(
                  '${group['members']} members',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            trailing: ElevatedButton(
              onPressed: () {
                // Toggle join/leave
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: group['isJoined'] as bool
                    ? Colors.grey[300]
                    : Theme.of(context).colorScheme.primary,
                foregroundColor: group['isJoined'] as bool
                    ? Colors.grey[700]
                    : Colors.white,
                minimumSize: const Size(80, 32),
              ),
              child: Text(
                group['isJoined'] as bool ? 'Joined' : 'Join',
                style: const TextStyle(fontSize: 12),
              ),
            ),
            isThreeLine: true,
          ),
        );
      },
    );
  }

  Widget _buildPeerResourcesTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildResourceSection(
          'Peer Success Stories',
          Icons.star,
          [
            'How I overcame social anxiety in college',
            'My journey with depression and recovery',
            'Building confidence through small wins',
          ],
        ),
        const SizedBox(height: 16),
        _buildResourceSection(
          'Community Tips',
          Icons.lightbulb,
          [
            'Study techniques that reduced my stress',
            'Healthy coping mechanisms for bad days',
            'Building a support network in college',
          ],
        ),
        const SizedBox(height: 16),
        _buildResourceSection(
          'Helpful Links',
          Icons.link,
          [
            'Mental health hotlines and resources',
            'Campus counseling services',
            'Online therapy platforms for students',
          ],
        ),
      ],
    );
  }

  Widget _buildResourceSection(String title, IconData icon, List<String> items) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  void _toggleLike(String postId) {
    setState(() {
      final postIndex = posts.indexWhere((post) => post.id == postId);
      if (postIndex != -1) {
        posts[postIndex].isLiked = !posts[postIndex].isLiked;
        posts[postIndex].likes += posts[postIndex].isLiked ? 1 : -1;
      }
    });
  }

  void _showCommentsDialog(BuildContext context, String postId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => CommentsSheet(
          postId: postId,
          scrollController: scrollController,
        ),
      ),
    );
  }

  void _showCreatePostDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const CreatePostDialog(),
    );
  }
}

class CommunityPost {
  final String id;
  final String content;
  final String authorName;
  final String timeAgo;
  int likes;
  final int comments;
  final List<String> tags;
  bool isLiked;

  CommunityPost({
    required this.id,
    required this.content,
    required this.authorName,
    required this.timeAgo,
    required this.likes,
    required this.comments,
    required this.tags,
    required this.isLiked,
  });
}

class PostCard extends StatelessWidget {
  final CommunityPost post;
  final Function(String) onLike;
  final Function(String) onComment;

  const PostCard({
    super.key,
    required this.post,
    required this.onLike,
    required this.onComment,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  child: Text(
                    post.authorName[0],
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.authorName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        post.timeAgo,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert, size: 20),
                  onPressed: () {
                    // Show options
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Content
            Text(
              post.content,
              style: const TextStyle(
                fontSize: 15,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
            
            // Tags
            if (post.tags.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: post.tags.map((tag) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '#$tag',
                    style: TextStyle(
                      fontSize: 11,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )).toList(),
              ),
            const SizedBox(height: 12),
            
            // Actions
            Row(
              children: [
                InkWell(
                  onTap: () => onLike(post.id),
                  child: Row(
                    children: [
                      Icon(
                        post.isLiked ? Icons.favorite : Icons.favorite_border,
                        size: 20,
                        color: post.isLiked ? Colors.red : Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${post.likes}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                InkWell(
                  onTap: () => onComment(post.id),
                  child: Row(
                    children: [
                      Icon(
                        Icons.comment_outlined,
                        size: 20,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${post.comments}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.share_outlined,
                  size: 20,
                  color: Colors.grey[600],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CommentsSheet extends StatelessWidget {
  final String postId;
  final ScrollController scrollController;

  const CommentsSheet({
    super.key,
    required this.postId,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Comments',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              controller: scrollController,
              children: [
                // Sample comments
                _buildComment('SupportiveFriend', 'You\'ve got this! Remember to take breaks and breathe. 💙', '1h ago'),
                _buildComment('StudyBuddy', 'Try the 25-5 study technique - 25 min study, 5 min break. It really helps!', '45m ago'),
                _buildComment('AnonymousHelper', 'I felt the same way last semester. It gets better, hang in there!', '30m ago'),
              ],
            ),
          ),
          // Comment input
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Add a supportive comment...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComment(String author, String content, String timeAgo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.grey[200],
            child: Text(
              author[0],
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      author,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      timeAgo,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CreatePostDialog extends StatefulWidget {
  const CreatePostDialog({super.key});

  @override
  State<CreatePostDialog> createState() => _CreatePostDialogState();
}

class _CreatePostDialogState extends State<CreatePostDialog> {
  final TextEditingController _contentController = TextEditingController();
  final List<String> _selectedTags = [];

  final List<String> _availableTags = [
    'anxiety',
    'depression',
    'stress',
    'study-tips',
    'sleep',
    'relationships',
    'motivation',
    'self-care',
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Share with Community',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contentController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'What\'s on your mind? Share your thoughts, experiences, or ask for support...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Add tags (optional):',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: _availableTags.map((tag) {
                final isSelected = _selectedTags.contains(tag);
                return FilterChip(
                  label: Text('#$tag'),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedTags.add(tag);
                      } else {
                        _selectedTags.remove(tag);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Create post logic
                    Navigator.pop(context);
                  },
                  child: const Text('Post'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
