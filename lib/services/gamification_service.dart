import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class GamificationService {
  static final GamificationService _instance = GamificationService._internal();
  factory GamificationService() => _instance;
  GamificationService._internal();

  // User progress data (in a real app, this would be stored in a database)
  int _wellnessPoints = 0;
  int _currentStreak = 0;
  int _longestStreak = 0;
  Set<String> _unlockedBadges = {};
  Map<String, int> _activityCounts = {
    'breathing_exercises': 0,
    'mood_check_ins': 0,
    'chat_sessions': 0,
    'resource_views': 0,
    'community_posts': 0,
  };

  // Getters
  int get wellnessPoints => _wellnessPoints;
  int get currentStreak => _currentStreak;
  int get longestStreak => _longestStreak;
  Set<String> get unlockedBadges => _unlockedBadges;
  Map<String, int> get activityCounts => _activityCounts;

  // Points for different activities
  static const Map<String, int> activityPoints = {
    'daily_check_in': 10,
    'breathing_exercise': 15,
    'mood_tracking': 8,
    'chat_session': 12,
    'resource_read': 5,
    'community_post': 20,
    'help_peer': 25,
    'streak_bonus': 5,
  };

  // Add points for completing activities
  void addPoints(String activityType, {int customPoints = 0}) {
    int points = customPoints > 0 ? customPoints : (activityPoints[activityType] ?? 0);
    _wellnessPoints += points;
    
    // Update activity counts
    if (_activityCounts.containsKey(activityType)) {
      _activityCounts[activityType] = _activityCounts[activityType]! + 1;
    }
    
    // Check for new badges
    _checkForNewBadges();
  }

  // Update streak
  void updateStreak() {
    _currentStreak++;
    if (_currentStreak > _longestStreak) {
      _longestStreak = _currentStreak;
    }
    
    // Streak bonus points
    if (_currentStreak % 7 == 0) {
      addPoints('streak_bonus', customPoints: _currentStreak);
    }
    
    _checkForNewBadges();
  }

  void resetStreak() {
    _currentStreak = 0;
  }

  // Check for new badges based on achievements
  void _checkForNewBadges() {
    final badges = Badge.getAllBadges();
    
    for (final badge in badges) {
      if (!_unlockedBadges.contains(badge.id) && badge.isUnlocked(this)) {
        _unlockedBadges.add(badge.id);
        // Could trigger a notification or celebration here
      }
    }
  }

  // Get user level based on points
  int get userLevel => (_wellnessPoints / 100).floor() + 1;
  
  // Get progress to next level
  double get levelProgress => (_wellnessPoints % 100) / 100.0;
  
  // Get points needed for next level
  int get pointsToNextLevel => 100 - (_wellnessPoints % 100);

  // Get user rank/title
  String get userRank {
    if (_wellnessPoints < 50) return 'Beginner';
    if (_wellnessPoints < 200) return 'Explorer';
    if (_wellnessPoints < 500) return 'Achiever';
    if (_wellnessPoints < 1000) return 'Champion';
    if (_wellnessPoints < 2000) return 'Master';
    return 'Wellness Guru';
  }
}

// Badge model
class Badge {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final BadgeType type;
  final int requiredValue;

  const Badge({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.type,
    required this.requiredValue,
  });

  bool isUnlocked(GamificationService service) {
    switch (type) {
      case BadgeType.points:
        return service.wellnessPoints >= requiredValue;
      case BadgeType.streak:
        return service.longestStreak >= requiredValue;
      case BadgeType.breathingExercises:
        return service.activityCounts['breathing_exercises']! >= requiredValue;
      case BadgeType.moodCheckIns:
        return service.activityCounts['mood_check_ins']! >= requiredValue;
      case BadgeType.chatSessions:
        return service.activityCounts['chat_sessions']! >= requiredValue;
      case BadgeType.communityPosts:
        return service.activityCounts['community_posts']! >= requiredValue;
      case BadgeType.resourceViews:
        return service.activityCounts['resource_views']! >= requiredValue;
    }
  }

  static List<Badge> getAllBadges() {
    return [
      // Points-based badges
      const Badge(
        id: 'first_steps',
        title: 'First Steps',
        description: 'Earn your first 50 wellness points',
        icon: Iconsax.medal_star,
        color: Colors.amber,
        type: BadgeType.points,
        requiredValue: 50,
      ),
      const Badge(
        id: 'point_collector',
        title: 'Point Collector',
        description: 'Earn 200 wellness points',
        icon: Iconsax.crown,
        color: Colors.orange,
        type: BadgeType.points,
        requiredValue: 200,
      ),
      const Badge(
        id: 'wellness_master',
        title: 'Wellness Master',
        description: 'Earn 1000 wellness points',
        icon: Iconsax.cup,
        color: Colors.purple,
        type: BadgeType.points,
        requiredValue: 1000,
      ),
      
      // Streak badges
      const Badge(
        id: 'consistent_carer',
        title: 'Consistent Carer',
        description: 'Maintain a 7-day streak',
        icon: Iconsax.calendar_tick,
        color: Colors.green,
        type: BadgeType.streak,
        requiredValue: 7,
      ),
      const Badge(
        id: 'dedication_champion',
        title: 'Dedication Champion',
        description: 'Maintain a 30-day streak',
        icon: Iconsax.award,
        color: Colors.blue,
        type: BadgeType.streak,
        requiredValue: 30,
      ),
      
      // Activity-specific badges
      const Badge(
        id: 'calm_achiever',
        title: 'Calm Achiever',
        description: 'Complete 10 breathing exercises',
        icon: Iconsax.wind_2,
        color: Colors.lightBlue,
        type: BadgeType.breathingExercises,
        requiredValue: 10,
      ),
      const Badge(
        id: 'breath_master',
        title: 'Breath Master',
        description: 'Complete 50 breathing exercises',
        icon: Iconsax.health,
        color: Colors.teal,
        type: BadgeType.breathingExercises,
        requiredValue: 50,
      ),
      const Badge(
        id: 'mood_tracker',
        title: 'Mood Tracker',
        description: 'Complete 20 mood check-ins',
        icon: Iconsax.emoji_happy,
        color: Colors.pink,
        type: BadgeType.moodCheckIns,
        requiredValue: 20,
      ),
      const Badge(
        id: 'supportive_peer',
        title: 'Supportive Peer',
        description: 'Create 10 community posts',
        icon: Iconsax.people,
        color: Colors.indigo,
        type: BadgeType.communityPosts,
        requiredValue: 10,
      ),
      const Badge(
        id: 'knowledge_seeker',
        title: 'Knowledge Seeker',
        description: 'View 25 wellness resources',
        icon: Iconsax.book_1,
        color: Colors.deepOrange,
        type: BadgeType.resourceViews,
        requiredValue: 25,
      ),
    ];
  }
}

enum BadgeType {
  points,
  streak,
  breathingExercises,
  moodCheckIns,
  chatSessions,
  communityPosts,
  resourceViews,
}

// Achievement notification widget
class AchievementNotification extends StatelessWidget {
  final Badge badge;
  final VoidCallback? onDismiss;

  const AchievementNotification({
    super.key,
    required this.badge,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            badge.color.withOpacity(0.9),
            badge.color.withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: badge.color.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            badge.icon,
            size: 48,
            color: Colors.white,
          ),
          const SizedBox(height: 12),
          Text(
            'Badge Unlocked!',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            badge.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            badge.description,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onDismiss,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: badge.color,
            ),
            child: const Text('Awesome!'),
          ),
        ],
      ),
    );
  }
}
