import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:google_fonts/google_fonts.dart';
import 'breathing_exercise_screen.dart';
import 'quick_mood_check_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Gratitude feature state
  final TextEditingController _gratitudeController = TextEditingController();
  bool _hasWrittenGratitudeToday = false;
  String _todaysGratitude = '';
  Map<String, String> _gratitudeHistory = {}; // Date -> Gratitude mapping

  // Daily Challenges feature state
  int _currentChallengeIndex = 0;
  bool _hasDoneChallengeToday = false;
  Map<String, bool> _challengeHistory = {}; // Date -> Completion status
  List<Map<String, dynamic>> _dailyChallenges = [
    {
      'title': 'Mindful Walking',
      'description': 'Take a 10-minute walk while paying attention to your breathing and surroundings. Notice 3 things you haven\'t observed before.',
      'icon': Iconsax.location,
      'color': Colors.green,
      'duration': '10 min',
      'category': 'Mindfulness'
    },
    {
      'title': 'Gratitude Letter',
      'description': 'Write a short thank-you note to someone who made a positive impact on your life recently. You don\'t have to send it.',
      'icon': Iconsax.note_1,
      'color': Colors.orange,
      'duration': '15 min',
      'category': 'Gratitude'
    },
    {
      'title': 'Digital Detox Hour',
      'description': 'Spend one hour without any digital devices. Read a book, meditate, or have a conversation with someone.',
      'icon': Iconsax.mobile,
      'color': Colors.purple,
      'duration': '60 min',
      'category': 'Balance'
    },
    {
      'title': 'Random Act of Kindness',
      'description': 'Do something kind for someone else - hold a door, compliment a stranger, help a classmate with homework.',
      'icon': Iconsax.heart,
      'color': Colors.pink,
      'duration': '5 min',
      'category': 'Connection'
    },
    {
      'title': 'Breathing Break',
      'description': 'Practice the 4-7-8 breathing technique: Inhale for 4, hold for 7, exhale for 8. Repeat 4 times.',
      'icon': Iconsax.wind_2,
      'color': Colors.blue,
      'duration': '5 min',
      'category': 'Relaxation'
    },
    {
      'title': 'Positive Affirmations',
      'description': 'Look in the mirror and say 3 positive things about yourself. Focus on your strengths and achievements.',
      'icon': Iconsax.star_1,
      'color': Colors.amber,
      'duration': '5 min',
      'category': 'Self-Love'
    },
    {
      'title': 'Nature Connection',
      'description': 'Spend 15 minutes in nature. Sit under a tree, watch clouds, or listen to birds. Leave your phone inside.',
      'icon': Iconsax.tree,
      'color': Colors.teal,
      'duration': '15 min',
      'category': 'Nature'
    },
    {
      'title': 'Creative Expression',
      'description': 'Express yourself creatively for 20 minutes - draw, write, sing, dance, or play an instrument.',
      'icon': Iconsax.brush_2,
      'color': Colors.indigo,
      'duration': '20 min',
      'category': 'Creativity'
    },
    {
      'title': 'Social Check-in',
      'description': 'Reach out to a friend or family member you haven\'t spoken to in a while. Ask how they\'re doing.',
      'icon': Iconsax.message_circle,
      'color': Colors.cyan,
      'duration': '10 min',
      'category': 'Connection'
    },
    {
      'title': 'Learning Moment',
      'description': 'Learn one new thing today - a word, fact, skill, or hobby. Share it with someone else.',
      'icon': Iconsax.book_1,
      'color': Colors.deepPurple,
      'duration': '15 min',
      'category': 'Growth'
    }
  ];

  @override
  void initState() {
    super.initState();
    _loadGratitudeHistory();
    _loadDailyChallengeStatus();
  }

  @override
  void dispose() {
    _gratitudeController.dispose();
    super.dispose();
  }

  String _getTodayKey() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  void _loadGratitudeHistory() {
    // In a real app, you would load this from SharedPreferences or database
    // For demo purposes, we'll use local state with sample data
    // Example implementation with SharedPreferences:
    // final prefs = await SharedPreferences.getInstance();
    // final gratitudeJson = prefs.getString('gratitude_history') ?? '{}';
    // _gratitudeHistory = Map<String, String>.from(jsonDecode(gratitudeJson));
    
    // Add some sample data for demonstration (remove this in production)
    _gratitudeHistory = {
      // Uncomment these lines to add sample data for testing
      // '2025-09-16': 'Had a wonderful coffee with my friend and we talked for hours. It felt so good to reconnect!',
      // '2025-09-14': 'Got a good grade on my exam that I studied really hard for. All the effort was worth it!',
    };
    
    final todayKey = _getTodayKey();
    setState(() {
      _hasWrittenGratitudeToday = _gratitudeHistory.containsKey(todayKey);
      _todaysGratitude = _gratitudeHistory[todayKey] ?? '';
    });
  }

  Future<void> _saveGratitudeHistory() async {
    // In a real app, save to SharedPreferences or database
    // Example implementation:
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('gratitude_history', jsonEncode(_gratitudeHistory));
  }

  void _saveGratitude() {
    if (_gratitudeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please write something you\'re grateful for'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final todayKey = _getTodayKey();
    setState(() {
      _todaysGratitude = _gratitudeController.text.trim();
      _hasWrittenGratitudeToday = true;
      _gratitudeHistory[todayKey] = _todaysGratitude;
    });

    // Save to persistent storage
    _saveGratitudeHistory();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✨ Gratitude saved! Thank you for sharing'),
        backgroundColor: Colors.green,
      ),
    );

    _gratitudeController.clear();
  }

  void _editGratitude() {
    setState(() {
      _gratitudeController.text = _todaysGratitude;
      _hasWrittenGratitudeToday = false;
    });
  }

  void _showGratitudeHistoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final sortedEntries = _gratitudeHistory.entries.toList()
          ..sort((a, b) => b.key.compareTo(a.key)); // Most recent first

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Iconsax.book,
                  color: Colors.amber,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text('Gratitude History'),
            ],
          ),
          content: Container(
            width: double.maxFinite,
            height: 400,
            child: Column(
              children: [
                Text(
                  '${_gratitudeHistory.length} days of gratitude recorded',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: sortedEntries.length,
                    itemBuilder: (context, index) {
                      final entry = sortedEntries[index];
                      final date = entry.key;
                      final gratitude = entry.value;
                      final isToday = date == _getTodayKey();
                      
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    isToday ? Iconsax.calendar_1 : Iconsax.calendar,
                                    size: 16,
                                    color: isToday ? Colors.amber : Colors.blue,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _formatDate(date),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: isToday ? Colors.amber[700] : Colors.blue[700],
                                    ),
                                  ),
                                  if (isToday) ...[
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.amber.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Text(
                                        'Today',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.amber,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                gratitude,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  height: 1.3,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.white,
              ),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  String _formatDate(String dateKey) {
    try {
      final date = DateTime.parse(dateKey);
      final now = DateTime.now();
      final difference = now.difference(date).inDays;
      
      if (difference == 0) {
        return 'Today';
      } else if (difference == 1) {
        return 'Yesterday';
      } else if (difference < 7) {
        return '${difference} days ago';
      } else {
        final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        return '${months[date.month - 1]} ${date.day}, ${date.year}';
      }
    } catch (e) {
      return dateKey;
    }
  }

  void _showGratitudeDialog() {
    final todayFormatted = DateTime.now().toLocal().toString().split(' ')[0];
    
    if (_hasWrittenGratitudeToday && _todaysGratitude.isNotEmpty) {
      // Show today's gratitude
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Iconsax.heart,
                    color: Colors.amber,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Today\'s Gratitude'),
                      Text(
                        todayFormatted,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.withOpacity(0.2)),
                  ),
                  child: Text(
                    _todaysGratitude,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Thank you for practicing gratitude today! 🌟',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 12),
                if (_gratitudeHistory.length > 1)
                  Row(
                    children: [
                      const Icon(Iconsax.calendar, size: 16, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(
                        '${_gratitudeHistory.length} days of gratitude recorded',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            actions: [
              if (_gratitudeHistory.length > 1)
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showGratitudeHistoryDialog();
                  },
                  icon: const Icon(Iconsax.book, size: 16),
                  label: const Text('History'),
                ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _editGratitude();
                  _showGratitudeDialog();
                },
                child: const Text('Edit'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    } else {
      // Show input dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Iconsax.heart,
                    color: Colors.amber,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Daily Gratitude'),
                      Text(
                        todayFormatted,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'What made you happy today?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _gratitudeController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Write about something that made you smile today...',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF055d69)),
                    ),
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Daily gratitude practice helps improve mental well-being and positive mindset.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
                if (_gratitudeHistory.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Iconsax.calendar, size: 16, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(
                        '${_gratitudeHistory.length} days of gratitude recorded',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
            actions: [
              if (_gratitudeHistory.isNotEmpty)
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showGratitudeHistoryDialog();
                  },
                  icon: const Icon(Iconsax.book, size: 16),
                  label: const Text('History'),
                ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  _saveGratitude();
                  Navigator.of(context).pop();
                },
                icon: const Icon(Iconsax.heart, size: 16),
                label: const Text('Save'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          );
        },
      );
    }
  }

  // Daily Challenges Methods
  void _loadDailyChallengeStatus() {
    // In a real app, you would load this from SharedPreferences or database
    // For demo purposes, we'll use local state
    final todayKey = _getTodayKey();
    setState(() {
      _hasDoneChallengeToday = _challengeHistory[todayKey] ?? false;
      // Set a different challenge each day based on the day of year
      final dayOfYear = DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays;
      _currentChallengeIndex = dayOfYear % _dailyChallenges.length;
    });
  }

  Future<void> _saveChallengeStatus() async {
    // In a real app, save to SharedPreferences or database
    // Example implementation:
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('challenge_history', jsonEncode(_challengeHistory));
  }

  void _markChallengeComplete() {
    final todayKey = _getTodayKey();
    setState(() {
      _hasDoneChallengeToday = true;
      _challengeHistory[todayKey] = true;
    });
    
    _saveChallengeStatus();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.celebration, color: Colors.white),
            const SizedBox(width: 8),
            const Text('🎉 Challenge completed! Great job!'),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showDailyChallengeDialog() {
    final challenge = _dailyChallenges[_currentChallengeIndex];
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: (challenge['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  challenge['icon'] as IconData,
                  color: challenge['color'] as Color,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Today\'s Challenge'),
                    Text(
                      challenge['category'],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: challenge['color'] as Color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      challenge['title'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: (challenge['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      challenge['duration'],
                      style: TextStyle(
                        fontSize: 12,
                        color: challenge['color'] as Color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                challenge['description'],
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),
              if (_hasDoneChallengeToday)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green.withOpacity(0.3)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Challenge completed for today! 🎉',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    '💡 Tip: Start small and be kind to yourself. Even attempting the challenge is a victory!',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
            ],
          ),
          actions: [
            if (!_hasDoneChallengeToday) ...[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Maybe Later'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _markChallengeComplete();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: challenge['color'] as Color,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Mark Complete'),
              ),
            ] else ...[
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Close'),
              ),
            ],
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mind Verse',
          style: GoogleFonts.jetBrainsMono(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color:  const Color.fromARGB(255, 30, 151, 167)
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image Banner
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    // Background Image
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF055d69),
                            Color(0xFF0891a3),
                            Color(0xFF22c1c3),
                          ],
                        ),
                      ),
                    ),
                    // Wellness Image Overlay
                    Positioned(
                      right: -20,
                      top: -10,
                      bottom: -10,
                      child: Opacity(
                        opacity: 0.3,
                        child: Image.asset(
                          'assets/images/wellness.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    // Content Overlay
                    const Positioned(
                      left: 24,
                      top: 24,
                      bottom: 24,
                      right: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Welcome to Mind Verse',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Your mental wellness journey starts here',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(height: 16),
                          
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            
            // Quick Actions Section
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 56) / 2, // Account for padding and spacing
                  child: _buildQuickActionCard(
                    context,
                    'Quick Check',
                    'Check your mood in 2 minutes',
                    Iconsax.clipboard_text,
                    Colors.purple,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuickMoodCheckScreen(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 56) / 2,
                  child: _buildQuickActionCard(
                    context,
                    'Counselling Support',
                    'Connect with professional counsellors',
                    Iconsax.user_cirlce_add,
                    Colors.teal,
                    () {
                      _showCounsellingOptions();
                    },
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 56) / 2,
                  child: _buildQuickActionCard(
                    context,
                    'Mood Tracker',
                    'Track your daily mood',
                    Iconsax.heart,
                    Colors.pink,
                    () {
                      _showMoodTracker();
                    },
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 56) / 2,
                  child: _buildQuickActionCard(
                    context,
                    'Breathing Exercise',
                    'Start a guided breathing session',
                    Iconsax.wind_2,
                    Colors.blue,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BreathingExerciseScreen(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 56) / 2,
                  child: _buildQuickActionCard(
                    context,
                    'Daily Gratitude',
                    'Write what made you happy today',
                    Iconsax.heart,
                    Colors.amber,
                    () {
                      _showGratitudeDialog();
                    },
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 56) / 2,
                  child: _buildQuickActionCard(
                    context,
                    'Daily Challenges',
                    _hasDoneChallengeToday 
                      ? '✅ Today\'s challenge completed!'
                      : 'Try today\'s wellness challenge',
                    _hasDoneChallengeToday ? Iconsax.tick_circle : Iconsax.flag,
                    _hasDoneChallengeToday ? Colors.green : Colors.indigo,
                    () {
                      _showDailyChallengeDialog();
                    },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: _buildQuickActionCard(
                    context,
                    'Emergency Helplines',
                    'Mental health emergency contacts',
                    Iconsax.call_calling,
                    Colors.deepOrange,
                    () {
                      _showEmergencyHelplines();
                    },
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 30),
            
            // Testimonials
            const Text(
              'What Our Users Say',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 4),
                children: [
                  _buildTestimonialCard(
                    "Mind Verse has completely transformed my daily routine. The breathing exercises help me stay calm during stressful situations.",
                    "Vivek Singh",
                    "College Student",
                    Colors.blue,
                  ),
                  _buildTestimonialCard(
                    "The motivational stories feature gives me hope and inspiration every day. It's like having a personal coach.",
                    "Yash kumar",
                    "college student",
                    Colors.green,
                  ),
                  _buildTestimonialCard(
                    "I love the daily challenges! They push me to step out of my comfort zone and try new things for my mental health.",
                    "Anushka parmar",
                    "college student",
                    Colors.purple,
                  ),
                  _buildTestimonialCard(
                    "The gratitude journal has helped me focus on positive aspects of my life. I feel more optimistic now.",
                    "Vaibhav Dubey",
                    "college student",
                    Colors.orange,
                  ),
                  _buildTestimonialCard(
                    "Having access to counselling support through the app made seeking help much less intimidating for me.",
                    "Sumit chouhan",
                    "college Student",
                    Colors.teal,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
          
            
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback? onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 140, // Reduced height to prevent overflow
        padding: const EdgeInsets.all(16), // Reduced padding from 20 to 16
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: color,
              size: 28, // Reduced icon size from 32 to 28
            ),
            Flexible( // Added Flexible to prevent overflow
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15, // Reduced font size from 16 to 15
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2), // Reduced spacing from 4 to 2
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11, // Reduced font size from 12 to 11
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWellnessCard(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey[600],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  void _showCounsellingOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Counselling Support',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildCounsellingOption(
              'Video Counselling',
              'One-on-one video sessions with licensed therapists',
              Iconsax.video,
              Colors.blue,
            ),
            _buildCounsellingOption(
              'Chat Support',
              'Text-based counselling available 24/7',
              Iconsax.message,
              Colors.green,
            ),
            _buildCounsellingOption(
              'Group Therapy',
              'Join supportive group sessions',
              Iconsax.people,
              Colors.purple,
            ),
            _buildCounsellingOption(
              'Campus Counsellor',
              'Connect with your university counsellor',
              Iconsax.building,
              Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounsellingOption(String title, String subtitle, IconData icon, Color color) {
    return ListTile(
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$title feature coming soon!')),
        );
      },
    );
  }

  void _showCrisisSupport() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Iconsax.call, color: Colors.red, size: 24),
            SizedBox(width: 8),
            Text('Crisis Support'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'If you\'re experiencing a mental health crisis, please reach out for immediate help:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            _buildCrisisContact('National Suicide Prevention Lifeline', '988'),
            _buildCrisisContact('Crisis Text Line', 'Text HOME to 741741'),
            _buildCrisisContact('Emergency Services', '911'),
            _buildCrisisContact('Campus Crisis Line', 'Contact Campus Security'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildCrisisContact(String service, String contact) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(Iconsax.call, color: Colors.red, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(service, style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(contact, style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showEmergencyHelplines() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Iconsax.call_calling, color: Colors.deepOrange, size: 28),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Emergency Helplines',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.grey.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Important mental health emergency contacts:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 20),
                      _buildEmergencyContact('National Suicide Prevention Lifeline', '988', 'Available 24/7'),
                      _buildEmergencyContact('Crisis Text Line', '741741', 'Text HOME to get help'),
                      _buildEmergencyContact('SAMHSA National Helpline', '1-800-662-4357', 'Mental health & substance abuse'),
                      _buildEmergencyContact('National Alliance on Mental Illness', '1-800-950-6264', 'Support & information'),
                      _buildEmergencyContact('Emergency Services', '911', 'Immediate emergency assistance'),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.amber.withOpacity(0.3)),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '🏫 Campus Resources:',
                              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.amber, fontSize: 16),
                            ),
                            SizedBox(height: 12),
                            Text('• Campus Counseling Center', style: TextStyle(fontSize: 14)),
                            SizedBox(height: 4),
                            Text('• Student Health Services', style: TextStyle(fontSize: 14)),
                            SizedBox(height: 4),
                            Text('• Dean of Students Office', style: TextStyle(fontSize: 14)),
                            SizedBox(height: 4),
                            Text('• Campus Security (Emergency)', style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Close', style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMoodTracker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Iconsax.heart, color: Colors.pink),
            SizedBox(width: 8),
            Text('Mood Tracker'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How are you feeling today?',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildMoodChip('😊', 'Happy', Colors.green),
                _buildMoodChip('😔', 'Sad', Colors.blue),
                _buildMoodChip('😰', 'Anxious', Colors.orange),
                _buildMoodChip('😴', 'Tired', Colors.grey),
                _buildMoodChip('😡', 'Angry', Colors.red),
                _buildMoodChip('😌', 'Calm', Colors.teal),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Tracking your mood helps identify patterns and triggers.',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodChip(String emoji, String mood, Color color) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Mood "$mood" recorded for today!'),
            backgroundColor: color,
            duration: const Duration(seconds: 2),
          ),
        );
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 4),
            Text(mood, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyContact(String service, String contact, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.red.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Iconsax.call, color: Colors.red, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service, 
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)
                  ),
                  Text(
                    contact, 
                    style: const TextStyle(
                      fontWeight: FontWeight.bold, 
                      color: Colors.red,
                      fontSize: 16
                    )
                  ),
                  Text(
                    description, 
                    style: TextStyle(color: Colors.grey[600], fontSize: 12)
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuoteCard(String quote, String author) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F8FD),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.format_quote, color: Color(0xFF1E97A7), size: 32),
          const SizedBox(height: 10),
          Text(
            quote,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              '- $author',
              style: const TextStyle(
                fontSize: 13,
                color: Colors.blueGrey,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard(String testimonial, String name, String role, Color accentColor) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border(
          left: BorderSide(color: accentColor, width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.format_quote,
            color: accentColor,
            size: 24,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              testimonial,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: accentColor,
                ),
              ),
              Text(
                role,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
