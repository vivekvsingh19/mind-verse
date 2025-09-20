import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class WellnessGuideScreen extends StatefulWidget {
  const WellnessGuideScreen({super.key});

  @override
  State<WellnessGuideScreen> createState() => _WellnessGuideScreenState();
}

class _WellnessGuideScreenState extends State<WellnessGuideScreen> {
  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Anxiety',
    'Depression',
    'Stress',
    'Sleep',
    'Relationships',
    'Self-Care',
    'Motivation',
  ];

  final List<WellnessGuide> guides = [
    WellnessGuide(
      title: 'Managing Anxiety in College',
      description: 'Learn practical techniques to handle anxiety during your studies and daily life.',
      content: '''
Anxiety is a common experience for college students. Here are some effective strategies:

1. **Deep Breathing Exercises**
   - Take slow, deep breaths for 4 counts
   - Hold for 4 counts
   - Exhale for 6 counts
   - Repeat 5-10 times

2. **Grounding Techniques**
   - 5-4-3-2-1 technique: Name 5 things you see, 4 you can touch, 3 you hear, 2 you smell, 1 you taste
   - Focus on the present moment

3. **Time Management**
   - Break large tasks into smaller ones
   - Use calendars and planners
   - Set realistic deadlines

4. **Self-Care Practices**
   - Regular exercise
   - Adequate sleep (7-9 hours)
   - Healthy nutrition
   - Social connections

5. **When to Seek Help**
   - If anxiety interferes with daily activities
   - Physical symptoms persist
   - Thoughts of self-harm
   - Academic performance suffers significantly

Remember: It's okay to ask for help. Your college counseling center is there for you.
      ''',
      category: 'Anxiety',
      readTime: '8 min read',
      icon: Iconsax.heart,
      color: Colors.blue,
    ),
    WellnessGuide(
      title: 'Understanding Depression',
      description: 'Comprehensive guide to recognizing and managing depression in student life.',
      content: '''
Depression affects many students. Understanding it is the first step to managing it.

**Signs of Depression:**
- Persistent sadness or emptiness
- Loss of interest in activities
- Changes in appetite or sleep
- Difficulty concentrating
- Feelings of worthlessness
- Fatigue or low energy

**Coping Strategies:**

1. **Daily Routine**
   - Maintain regular sleep schedule
   - Set small, achievable goals
   - Include physical activity

2. **Social Support**
   - Stay connected with friends and family
   - Join clubs or groups
   - Don't isolate yourself

3. **Mindfulness and Meditation**
   - Practice daily meditation
   - Try mindfulness apps
   - Focus on present moment

4. **Professional Help**
   - Therapy (CBT, DBT)
   - Counseling services
   - Support groups
   - Medication if recommended

5. **Lifestyle Changes**
   - Regular exercise
   - Balanced nutrition
   - Limit alcohol and drugs
   - Adequate sunlight exposure

**Emergency Resources:**
- Campus counseling center
- National Suicide Prevention Lifeline: 988
- Crisis text line: Text HOME to 741741

You are not alone. Help is available and recovery is possible.
      ''',
      category: 'Depression',
      readTime: '12 min read',
      icon: Iconsax.health,
      color: Colors.purple,
    ),
    WellnessGuide(
      title: 'Stress Management Techniques',
      description: 'Effective ways to manage academic and personal stress.',
      content: '''
Stress is inevitable, but manageable. Here's how to cope effectively:

**Quick Stress Relief:**
1. **Progressive Muscle Relaxation**
   - Tense and release muscle groups
   - Start with toes, work up to head
   - Hold tension for 5 seconds, then release

2. **Visualization**
   - Picture a calm, peaceful place
   - Engage all your senses
   - Spend 5-10 minutes there mentally

3. **Physical Activity**
   - Go for a walk
   - Do jumping jacks
   - Stretch or yoga poses

**Long-term Stress Management:**

1. **Time Management**
   - Prioritize tasks
   - Use the Pomodoro Technique
   - Learn to say no

2. **Healthy Boundaries**
   - Set limits on work/study time
   - Maintain social connections
   - Take regular breaks

3. **Stress-Reducing Activities**
   - Hobbies you enjoy
   - Creative outlets
   - Nature time
   - Music or art

4. **Physical Health**
   - Regular exercise routine
   - Balanced diet
   - Adequate sleep
   - Limit caffeine

5. **Mental Health Practices**
   - Journaling
   - Meditation
   - Gratitude practice
   - Professional counseling

Remember: Some stress is normal, but chronic stress needs attention.
      ''',
      category: 'Stress',
      readTime: '10 min read',
      icon: Iconsax.shield_tick,
      color: Colors.orange,
    ),
    WellnessGuide(
      title: 'Better Sleep Habits',
      description: 'Improve your sleep quality for better mental health and academic performance.',
      content: '''
Good sleep is essential for mental health and academic success.

**Sleep Hygiene Basics:**

1. **Consistent Schedule**
   - Go to bed and wake up at same time daily
   - Even on weekends
   - Avoid "catching up" on sleep

2. **Bedroom Environment**
   - Cool temperature (65-68°F)
   - Dark room (blackout curtains)
   - Quiet space (earplugs if needed)
   - Comfortable mattress and pillows

3. **Pre-Sleep Routine**
   - Start winding down 1 hour before bed
   - No screens 30 minutes before sleep
   - Reading, gentle stretching, or meditation
   - Warm bath or shower

4. **What to Avoid**
   - Caffeine after 2 PM
   - Large meals before bed
   - Alcohol (disrupts sleep quality)
   - Daytime naps longer than 20 minutes

**Common Sleep Challenges:**

1. **Racing Thoughts**
   - Keep a worry journal
   - Write down tomorrow's tasks
   - Practice mindfulness meditation

2. **Stress and Anxiety**
   - Progressive muscle relaxation
   - Deep breathing exercises
   - Calming music or sounds

3. **Irregular Schedule**
   - Gradually adjust bedtime
   - Use light therapy
   - Maintain consistent meal times

**When to Seek Help:**
- Persistent insomnia (3+ weeks)
- Excessive daytime sleepiness
- Snoring or breathing issues
- Sleep doesn't refresh you

Quality sleep improves mood, memory, and immune function.
      ''',
      category: 'Sleep',
      readTime: '9 min read',
      icon: Iconsax.moon,
      color: Colors.indigo,
    ),
    WellnessGuide(
      title: 'Building Healthy Relationships',
      description: 'Tips for maintaining meaningful connections and setting boundaries.',
      content: '''
Healthy relationships are crucial for mental wellbeing and college success.

**Characteristics of Healthy Relationships:**
- Mutual respect and trust
- Open, honest communication
- Support for individual growth
- Healthy boundaries
- Shared values and interests

**Building Strong Friendships:**

1. **Be Authentic**
   - Show your true self
   - Don't try to please everyone
   - Share your interests and values

2. **Active Listening**
   - Give full attention
   - Ask follow-up questions
   - Validate their feelings

3. **Consistency**
   - Regular check-ins
   - Follow through on plans
   - Be reliable and trustworthy

4. **Shared Activities**
   - Study groups
   - Hobbies and interests
   - Volunteer work
   - Exercise together

**Setting Healthy Boundaries:**

1. **Know Your Limits**
   - Time and energy
   - Emotional capacity
   - Personal values

2. **Communicate Clearly**
   - Use "I" statements
   - Be direct but kind
   - Explain your needs

3. **Stay Consistent**
   - Don't make exceptions to avoid conflict
   - Reinforce boundaries when needed

**Dealing with Difficult People:**

1. **Toxic Relationships**
   - Recognize red flags
   - Limit contact when possible
   - Seek support from others

2. **Conflict Resolution**
   - Address issues early
   - Focus on specific behaviors
   - Find compromise when possible

**Romance in College:**
- Take things slow
- Maintain individual identity
- Communicate expectations
- Respect each other's goals

Remember: You deserve relationships that make you feel valued and supported.
      ''',
      category: 'Relationships',
      readTime: '11 min read',
      icon: Iconsax.people,
      color: Colors.pink,
    ),
    WellnessGuide(
      title: 'Daily Self-Care Routine',
      description: 'Simple self-care practices that fit into a busy student schedule.',
      content: '''
Self-care isn't selfish - it's essential for sustaining your wellbeing.

**Morning Self-Care (10-15 minutes):**
1. **Mindful Start**
   - 5 minutes of deep breathing
   - Set daily intentions
   - Gratitude practice

2. **Physical Care**
   - Gentle stretching
   - Hydrate with water
   - Nutritious breakfast

3. **Mental Preparation**
   - Review daily goals
   - Positive affirmations
   - Quick meditation

**Throughout the Day:**

1. **Micro Self-Care**
   - Take deep breaths between classes
   - Step outside for fresh air
   - Listen to favorite music
   - Text a friend

2. **Study Breaks**
   - 5-minute walks
   - Healthy snacks
   - Eye rest from screens
   - Quick stretches

3. **Midday Reset**
   - 10-minute mindfulness
   - Eat lunch away from desk
   - Call family/friends

**Evening Self-Care (20-30 minutes):**

1. **Unwind Activities**
   - Warm bath or shower
   - Reading for pleasure
   - Gentle yoga
   - Journaling

2. **Reflection**
   - What went well today?
   - What am I grateful for?
   - What do I need tomorrow?

3. **Preparation**
   - Set out tomorrow's clothes
   - Prepare healthy snacks
   - Create peaceful sleep environment

**Self-Care Categories:**

1. **Physical**
   - Exercise regularly
   - Eat nutritious meals
   - Get adequate sleep
   - Stay hydrated

2. **Emotional**
   - Express feelings
   - Practice self-compassion
   - Seek support when needed
   - Celebrate achievements

3. **Mental**
   - Learn new things
   - Challenge yourself
   - Take breaks from stress
   - Practice mindfulness

4. **Social**
   - Spend time with loved ones
   - Join communities
   - Help others
   - Set boundaries

5. **Spiritual**
   - Connect with nature
   - Practice gratitude
   - Meditation or prayer
   - Find meaning and purpose

Remember: Self-care looks different for everyone. Find what works for you.
      ''',
      category: 'Self-Care',
      readTime: '13 min read',
      icon: Iconsax.heart_circle,
      color: Colors.green,
    ),
    WellnessGuide(
      title: 'Staying Motivated Through Challenges',
      description: 'Strategies to maintain motivation and resilience during difficult times.',
      content: '''
Motivation naturally fluctuates. Here's how to build lasting resilience:

**Understanding Motivation:**
- Intrinsic vs. extrinsic motivation
- Motivation comes and goes
- Discipline and habits matter more
- Small actions build momentum

**Building Intrinsic Motivation:**

1. **Connect to Purpose**
   - Why are you in college?
   - What are your long-term goals?
   - How does this relate to your values?

2. **Set Meaningful Goals**
   - SMART goals (Specific, Measurable, Achievable, Relevant, Time-bound)
   - Break large goals into smaller steps
   - Celebrate progress

3. **Focus on Growth**
   - Embrace challenges as learning opportunities
   - View failures as feedback
   - Develop growth mindset

**Staying Motivated Daily:**

1. **Morning Motivation**
   - Review your goals
   - Visualize success
   - Start with easiest task

2. **Progress Tracking**
   - Keep a journal
   - Use apps or planners
   - Visual progress charts

3. **Reward Systems**
   - Small rewards for daily tasks
   - Bigger rewards for weekly goals
   - Non-material rewards (time off, activities)

**Overcoming Setbacks:**

1. **Normalize Struggles**
   - Everyone faces challenges
   - Setbacks are temporary
   - Focus on what you can control

2. **Problem-Solving Approach**
   - Identify specific issues
   - Brainstorm solutions
   - Take one small step

3. **Support Systems**
   - Talk to friends, family, mentors
   - Join study groups
   - Use campus resources

**Building Resilience:**

1. **Develop Coping Skills**
   - Stress management techniques
   - Emotional regulation
   - Flexible thinking

2. **Maintain Perspective**
   - This too shall pass
   - Focus on what you've overcome before
   - Remember your strengths

3. **Self-Compassion**
   - Treat yourself kindly
   - Avoid harsh self-criticism
   - Practice forgiveness

**Creating Sustainable Habits:**
- Start small (2-minute rule)
- Stack habits with existing routines
- Focus on consistency over perfection
- Environment design for success

Remember: Motivation gets you started, but habits keep you going.
      ''',
      category: 'Motivation',
      readTime: '14 min read',
      icon: Iconsax.cup,
      color: Colors.amber,
    ),
  ];

  List<WellnessGuide> get filteredGuides {
    if (selectedCategory == 'All') {
      return guides;
    }
    return guides.where((guide) => guide.category == selectedCategory).toList();
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
          'Wellness Guide',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
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
          
          // Guides List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredGuides.length,
              itemBuilder: (context, index) {
                final guide = filteredGuides[index];
                return GuideCard(
                  guide: guide,
                  onTap: () => _showGuideDetails(guide),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showGuideDetails(WellnessGuide guide) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GuideDetailScreen(guide: guide),
      ),
    );
  }
}

class WellnessGuide {
  final String title;
  final String description;
  final String content;
  final String category;
  final String readTime;
  final IconData icon;
  final Color color;

  WellnessGuide({
    required this.title,
    required this.description,
    required this.content,
    required this.category,
    required this.readTime,
    required this.icon,
    required this.color,
  });
}

class GuideCard extends StatelessWidget {
  final WellnessGuide guide;
  final VoidCallback onTap;

  const GuideCard({
    super.key,
    required this.guide,
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
                  color: guide.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  guide.icon,
                  color: guide.color,
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
                      guide.title,
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
                      guide.description,
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
                            color: guide.color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            guide.category,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: guide.color,
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
                          guide.readTime,
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
              
              // Arrow
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

class GuideDetailScreen extends StatelessWidget {
  final WellnessGuide guide;

  const GuideDetailScreen({super.key, required this.guide});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          guide.category,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: Colors.black),
            onPressed: () {
              // Add bookmark functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Guide bookmarked!')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: guide.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    guide.icon,
                    color: guide.color,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        guide.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        guide.readTime,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Description
            Text(
              guide.description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Content
            Text(
              guide.content,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
                height: 1.6,
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Share functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Guide shared!')),
                      );
                    },
                    icon: const Icon(Icons.share, size: 18),
                    label: const Text('Share'),
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
                      // Mark as helpful
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Thank you for your feedback!')),
                      );
                    },
                    icon: const Icon(Icons.thumb_up, size: 18),
                    label: const Text('Helpful'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: guide.color,
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
    );
  }
}
