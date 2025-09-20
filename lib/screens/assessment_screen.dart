import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AssessmentScreen extends StatefulWidget {
  final String assessmentType;
  
  const AssessmentScreen({super.key, required this.assessmentType});

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  int currentQuestionIndex = 0;
  Map<int, int> answers = {};
  
  // PHQ-9 Questions
  final List<String> phq9Questions = [
    "Little interest or pleasure in doing things",
    "Feeling down, depressed, or hopeless",
    "Trouble falling or staying asleep, or sleeping too much",
    "Feeling tired or having little energy",
    "Poor appetite or overeating",
    "Feeling bad about yourself or that you are a failure or have let yourself or your family down",
    "Trouble concentrating on things, such as reading the newspaper or watching television",
    "Moving or speaking so slowly that other people could have noticed, or the opposite - being so fidgety or restless that you have been moving around a lot more than usual",
    "Thoughts that you would be better off dead, or of hurting yourself"
  ];
  
  // GAD-7 Questions
  final List<String> gad7Questions = [
    "Feeling nervous, anxious, or on edge",
    "Not being able to stop or control worrying",
    "Worrying too much about different things",
    "Trouble relaxing",
    "Being so restless that it is hard to sit still",
    "Becoming easily annoyed or irritable",
    "Feeling afraid, as if something awful might happen"
  ];
  
  final List<String> answerOptions = [
    "Not at all",
    "Several days",
    "More than half the days",
    "Nearly every day"
  ];

  List<String> get currentQuestions {
    return widget.assessmentType == 'PHQ-9' ? phq9Questions : gad7Questions;
  }

  void _selectAnswer(int value) {
    setState(() {
      answers[currentQuestionIndex] = value;
    });
    
    if (currentQuestionIndex < currentQuestions.length - 1) {
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
    int totalScore = answers.values.fold(0, (sum, score) => sum + score);
    String interpretation = _interpretScore(totalScore);
    Color scoreColor = _getScoreColor(totalScore);
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildResultsSheet(totalScore, interpretation, scoreColor),
    );
  }

  String _interpretScore(int score) {
    if (widget.assessmentType == 'PHQ-9') {
      if (score <= 4) return "Minimal depression";
      if (score <= 9) return "Mild depression";
      if (score <= 14) return "Moderate depression";
      if (score <= 19) return "Moderately severe depression";
      return "Severe depression";
    } else {
      // GAD-7
      if (score <= 4) return "Minimal anxiety";
      if (score <= 9) return "Mild anxiety";
      if (score <= 14) return "Moderate anxiety";
      return "Severe anxiety";
    }
  }

  Color _getScoreColor(int score) {
    int maxScore = widget.assessmentType == 'PHQ-9' ? 27 : 21;
    if (score <= maxScore * 0.3) return Colors.green;
    if (score <= maxScore * 0.6) return Colors.orange;
    return Colors.red;
  }

  Widget _buildResultsSheet(int score, String interpretation, Color scoreColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(height: 24),
            
            // Title
            Text(
              '${widget.assessmentType} Results',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Score display
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: scoreColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: scoreColor.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Text(
                    'Your Score',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$score',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: scoreColor,
                    ),
                  ),
                  Text(
                    interpretation,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: scoreColor,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Disclaimer
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Iconsax.info_circle, color: Colors.blue, size: 20),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'This is not a diagnostic tool. Please consult with a healthcare professional for proper evaluation.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Recommendations
            const Text(
              'Recommendations',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            
            Expanded(
              child: ListView(
                children: _getRecommendations(score),
              ),
            ),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
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
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        currentQuestionIndex = 0;
                        answers.clear();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Retake'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getRecommendations(int score) {
    List<String> recommendations = [];
    
    if (widget.assessmentType == 'PHQ-9') {
      if (score <= 4) {
        recommendations = [
          "Continue maintaining good mental health habits",
          "Regular exercise and healthy sleep schedule",
          "Stay connected with friends and family",
        ];
      } else if (score <= 14) {
        recommendations = [
          "Consider talking to a counselor or therapist",
          "Practice stress management techniques",
          "Maintain regular sleep and exercise routines",
          "Consider joining support groups",
        ];
      } else {
        recommendations = [
          "Seek professional help from a mental health provider",
          "Consider contacting a crisis helpline if needed",
          "Reach out to trusted friends or family",
          "Avoid making major life decisions right now",
        ];
      }
    } else {
      // GAD-7
      if (score <= 4) {
        recommendations = [
          "Continue current coping strategies",
          "Practice relaxation techniques",
          "Maintain healthy lifestyle habits",
        ];
      } else if (score <= 14) {
        recommendations = [
          "Try anxiety management techniques",
          "Consider mindfulness or meditation",
          "Talk to a healthcare provider",
          "Limit caffeine and practice good sleep hygiene",
        ];
      } else {
        recommendations = [
          "Seek professional mental health treatment",
          "Consider therapy or counseling",
          "Practice grounding techniques",
          "Reach out to support systems",
        ];
      }
    }
    
    return recommendations.map((rec) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Iconsax.tick_circle, color: Colors.green, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              rec,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    )).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFB),
      appBar: AppBar(
        title: Text('${widget.assessmentType} Assessment'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
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
                widthFactor: (currentQuestionIndex + 1) / currentQuestions.length,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF055d69),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            Text(
              'Question ${currentQuestionIndex + 1} of ${currentQuestions.length}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Question
            Text(
              'Over the last 2 weeks, how often have you been bothered by:',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            
            const SizedBox(height: 16),
            
            Text(
              currentQuestions[currentQuestionIndex],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                height: 1.3,
              ),
            ),
            
            const SizedBox(height: 48),
            
            // Answer options
            Expanded(
              child: ListView.builder(
                itemCount: answerOptions.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildAnswerOption(answerOptions[index], index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerOption(String text, int value) {
    return GestureDetector(
      onTap: () => _selectAnswer(value),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  '$value',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
