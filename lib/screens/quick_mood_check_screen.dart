import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'assessment_screen.dart';

class QuickMoodCheckScreen extends StatefulWidget {
  const QuickMoodCheckScreen({super.key});

  @override
  State<QuickMoodCheckScreen> createState() => _QuickMoodCheckScreenState();
}

class _QuickMoodCheckScreenState extends State<QuickMoodCheckScreen> {
  int currentQuestionIndex = 0;
  Map<int, String> answers = {};
  
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'How are you feeling today?',
      'options': [
        {'text': 'Happy', 'icon': Iconsax.emoji_happy, 'color': Colors.green, 'value': 'happy'},
        {'text': 'Stressed', 'icon': Iconsax.warning_2, 'color': Colors.orange, 'value': 'stressed'},
        {'text': 'Anxious', 'icon': Iconsax.emoji_sad, 'color': Colors.red, 'value': 'anxious'},
        {'text': 'Tired', 'icon': Iconsax.eye_slash, 'color': Colors.blue, 'value': 'tired'},
      ],
    },
    {
      'question': 'How would you rate your energy level?',
      'options': [
        {'text': 'High Energy', 'icon': Iconsax.flash_1, 'color': Colors.amber, 'value': 'high'},
        {'text': 'Moderate', 'icon': Iconsax.battery_3full, 'color': Colors.green, 'value': 'moderate'},
        {'text': 'Low Energy', 'icon': Iconsax.battery_empty, 'color': Colors.orange, 'value': 'low'},
        {'text': 'Exhausted', 'icon': Iconsax.battery_disable, 'color': Colors.red, 'value': 'exhausted'},
      ],
    },
    {
      'question': 'How well did you sleep last night?',
      'options': [
        {'text': 'Great Sleep', 'icon': Iconsax.moon, 'color': Colors.purple, 'value': 'great'},
        {'text': 'Good Sleep', 'icon': Iconsax.cloud, 'color': Colors.blue, 'value': 'good'},
        {'text': 'Poor Sleep', 'icon': Iconsax.eye, 'color': Colors.orange, 'value': 'poor'},
        {'text': 'No Sleep', 'icon': Iconsax.eye_slash, 'color': Colors.red, 'value': 'none'},
      ],
    },
  ];

  void _selectAnswer(String value) {
    setState(() {
      answers[currentQuestionIndex] = value;
    });
    
    if (currentQuestionIndex < questions.length - 1) {
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          currentQuestionIndex++;
        });
      });
    } else {
      _showResults();
    }
  }

  void _showResults() {
    String feedback = _generateFeedback();
    String moodLevel = _calculateMoodLevel();
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildResultsSheet(feedback, moodLevel),
    );
  }

  String _generateFeedback() {
    List<String> responses = answers.values.toList();
    // Count stress indicators
    int stressCount = 0;
    if (responses.contains('stressed') || responses.contains('anxious')) stressCount++;
    if (responses.contains('low') || responses.contains('exhausted')) stressCount++;
    if (responses.contains('poor') || responses.contains('none')) stressCount++;

    if (stressCount >= 2) {
      return "It looks like you might be feeling a bit stressed. Remember, it's okay to have tough days—many students in India feel this way, especially during exams or assignments. Try to take a short break, talk to a friend, or go for a walk. Your well-being matters!";
    } else if (responses.contains('happy') && responses.contains('high')) {
      return "You seem to be in a great mood today! Keep spreading your positive energy. Stay connected with your friends and family, and keep up your good habits. Proud of you!";
    } else if (responses.contains('tired') || responses.contains('exhausted')) {
      return "You seem a bit tired today. College life in India can be hectic—make sure you get enough rest, eat well, and take some time for yourself. A power nap or a cup of chai might help!";
    } else {
      return "You seem to be having a balanced day. Keep checking in with yourself and remember, it's okay to ask for help if you need it. Wishing you a peaceful day ahead!";
    }
  }

  String _calculateMoodLevel() {
    List<String> responses = answers.values.toList();
    
    if (responses.contains('stressed') || responses.contains('anxious')) {
      return 'concerned';
    } else if (responses.contains('happy') && responses.contains('high')) {
      return 'positive';
    } else {
      return 'neutral';
    }
  }

  Widget _buildResultsSheet(String feedback, String moodLevel) {
    Color sheetColor = moodLevel == 'positive' ? Colors.green : 
                      moodLevel == 'concerned' ? Colors.orange : Colors.blue;
    
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Icon and title
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: sheetColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Icon(
                    moodLevel == 'positive' ? Iconsax.emoji_happy :
                    moodLevel == 'concerned' ? Iconsax.info_circle : Iconsax.heart,
                    color: sheetColor,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    'Your Quick Check Results',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Feedback
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: sheetColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: sheetColor.withOpacity(0.2)),
              ),
              child: Text(
                feedback,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.4,
                  color: Colors.black87,
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Assessment options
            if (moodLevel == 'concerned') ...[
              const Text(
                'Want to explore further?',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 14),
              
              Row(
                children: [
                  Expanded(
                    child: _buildAssessmentButton(
                      'PHQ-9 Assessment',
                      'Depression screening',
                      Iconsax.heart,
                      Colors.pink,
                      () => _openAssessment('PHQ-9'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildAssessmentButton(
                      'GAD-7 Assessment',
                      'Anxiety screening',
                      Iconsax.info_circle,
                      Colors.blue,
                      () => _openAssessment('GAD-7'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Done'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _retakeQuiz,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Retake'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // Bottom padding
          ],
        ),
      ),
    );
  }

  Widget _buildAssessmentButton(String title, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 6),
            Text(
              title,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 9,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _openAssessment(String type) {
    Navigator.pop(context); // Close results sheet
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AssessmentScreen(assessmentType: type),
      ),
    );
  }

  void _retakeQuiz() {
    Navigator.pop(context); // Close results sheet
    setState(() {
      currentQuestionIndex = 0;
      answers.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFB),
      appBar: AppBar(
        title: const Text('Quick Mood Check'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress indicator
            Container(
              width: double.infinity,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: (currentQuestionIndex + 1) / questions.length,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF055d69),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 12),
            
            Text(
              'Question ${currentQuestionIndex + 1} of ${questions.length}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Question
            Text(
              questions[currentQuestionIndex]['question'],
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                height: 1.2,
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Answer options
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
              ),
              itemCount: questions[currentQuestionIndex]['options'].length,
              itemBuilder: (context, index) {
                final option = questions[currentQuestionIndex]['options'][index];
                return _buildOptionCard(option);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(Map<String, dynamic> option) {
    return GestureDetector(
      onTap: () => _selectAnswer(option['value']),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: option['color'].withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: option['color'].withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                option['icon'],
                color: option['color'],
                size: 28,
              ),
            ),
            const SizedBox(height: 12),
            Flexible(
              child: Text(
                option['text'],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: option['color'],
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
