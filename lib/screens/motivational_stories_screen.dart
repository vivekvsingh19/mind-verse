import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MotivationalStoriesScreen extends StatefulWidget {
  const MotivationalStoriesScreen({super.key});

  @override
  State<MotivationalStoriesScreen> createState() =>
      _MotivationalStoriesScreenState();
}

class _MotivationalStoriesScreenState extends State<MotivationalStoriesScreen> {
  PageController pageController = PageController();
  int currentStoryIndex = 0;

  final List<MotivationalStory> stories = [
    MotivationalStory(
      title: "Albert Einstein's Academic Struggles",
      failure:
          "Einstein didn't speak until age 4 and was told by teachers he would never amount to much. His university application was rejected, and early academic papers were ignored.",
      success:
          "Became one of history's greatest physicists, developed the theory of relativity, and won the Nobel Prize. His work revolutionized our understanding of space, time, and gravity.",
      lesson:
          "Late bloomers can achieve extraordinary things. Intelligence comes in many forms, and persistence matters more than early recognition.",
      category: "Education",
      icon: Iconsax.lamp_1,
      color: const Color(0xFF2BA2B0),
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/3/3e/Einstein_1921_by_F_Schmutzer_-_restoration.jpg",
    ),
    MotivationalStory(
      title: "Oprah Winfrey's Difficult Beginnings",
      failure:
          "Born into poverty, faced abuse, became pregnant at 14, lost her baby, was fired from her first television job for being 'too emotionally invested.'",
      success:
          "Built a media empire worth billions, became one of the most influential women in the world, helped millions through her shows and philanthropy.",
      lesson:
          "Your background doesn't determine your future. Emotional investment and authenticity can be strengths, not weaknesses.",
      category: "Media",
      icon: Iconsax.microphone,
      color: const Color(0xFF8B5CF6),
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0a/Oprah_in_2014.jpg/640px-Oprah_in_2014.jpg",
    ),
    MotivationalStory(
      title: "Stephen King's Rejections",
      failure:
          "His first novel 'Carrie' was rejected 30 times. He threw it in the trash, feeling it was worthless. Worked as a janitor while writing.",
      success:
          "Became one of the best-selling authors of all time with over 350 million books sold. 'Carrie' became a classic and successful movie.",
      lesson:
          "Rejection doesn't mean your work has no value. Sometimes you need just one 'yes' to change everything.",
      category: "Writing",
      icon: Iconsax.book_1,
      color: const Color(0xFF06B6D4),
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/Stephen_King%2C_Comicon.jpg/640px-Stephen_King%2C_Comicon.jpg",
    ),
    MotivationalStory(
      title: "Michael Jordan's High School Cut",
      failure:
          "Cut from his high school basketball team for not being good enough. Coach said he lacked skill and wasn't tall enough.",
      success:
          "Became arguably the greatest basketball player ever, won 6 NBA championships, and inspired millions worldwide.",
      lesson:
          "Being told you're not good enough can fuel determination. Use rejection as motivation to improve.",
      category: "Sports",
      icon: Iconsax.award,
      color: const Color(0xFF10B981),
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ae/Michael_Jordan_in_2014.jpg/640px-Michael_Jordan_in_2014.jpg",
    ),
    MotivationalStory(
      title: "J.K. Rowling's Rock Bottom",
      failure:
          "Single mother on welfare, clinically depressed, unemployed. Harry Potter was rejected by 12 publishers who said it was too long for children.",
      success:
          "Harry Potter became the best-selling book series in history, making her the first billionaire author and inspiring millions of readers.",
      lesson:
          "Rock bottom can be the foundation to rebuild your life. Great ideas may be initially misunderstood.",
      category: "Writing",
      icon: Iconsax.magic_star,
      color: const Color(0xFF6366F1),
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/J._K._Rowling_2010.jpg/640px-J._K._Rowling_2010.jpg",
    ),
    MotivationalStory(
      title: "Walt Disney's Early Failures",
      failure:
          "Fired from newspaper for 'lacking imagination.' His first animation company went bankrupt. Mickey Mouse was initially rejected for being 'too scary.'",
      success:
          "Created the Disney empire, revolutionized animation, built theme parks that bring joy to millions, and created timeless characters.",
      lesson:
          "Creative vision may be ahead of its time. Financial failure doesn't mean creative failure.",
      category: "Entertainment",
      icon: Iconsax.happyemoji,
      color: const Color(0xFFF59E0B),
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/5/50/Walt_Disney_1946_%28cropped2%29.JPG",
    ),
    MotivationalStory(
      title: "Colonel Sanders' Late Start",
      failure:
          "Failed at multiple jobs, lost his restaurant during highway construction, was rejected 1,009 times when trying to sell his chicken recipe.",
      success:
          "Founded KFC at age 62, built a global franchise empire, became a household name and inspiration for late-in-life success.",
      lesson:
          "It's never too late to start over. Persistence in the face of rejection can lead to extraordinary success.",
      category: "Business",
      icon: Iconsax.cup,
      color: const Color(0xFF8B5CF6),
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cf/ColSanders.jpg/640px-ColSanders.jpg",
    ),
    MotivationalStory(
      title: "Thomas Edison's Learning Process",
      failure:
          "Teachers said he was 'too dumb to learn anything.' Failed over 1,000 times while inventing the light bulb.",
      success:
          "Invented the light bulb, phonograph, and motion picture camera. Held over 1,000 patents and revolutionized modern life.",
      lesson:
          "Failure is just learning what doesn't work. Intelligence isn't fixed - it can be developed through effort.",
      category: "Innovation",
      icon: Iconsax.lamp_1,
      color: const Color(0xFF10B981),
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9d/Thomas_Edison2.jpg/640px-Thomas_Edison2.jpg",
    ),
    MotivationalStory(
      title: "Vera Wang's Career Change",
      failure:
          "Passed over for promotion at Vogue after 17 years. Started in fashion at age 40, considered 'too old' for the industry.",
      success:
          "Built a billion-dollar fashion empire, became the go-to designer for celebrities, revolutionized bridal fashion.",
      lesson:
          "Career changes can lead to your true calling. Age is not a barrier to success in new fields.",
      category: "Fashion",
      icon: Iconsax.crown_1,
      color: const Color(0xFF06B6D4),
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Vera_Wang_2019.jpg/640px-Vera_Wang_2019.jpg",
    ),
    MotivationalStory(
      title: "Steve Jobs' Comeback",
      failure:
          "Fired from Apple, the company he co-founded. NeXT computer was a commercial failure. Pixar struggled for years.",
      success:
          "Returned to save Apple from bankruptcy, created revolutionary products like iPhone and iPad, built the world's most valuable company.",
      lesson:
          "Sometimes you need to lose everything to find your true potential. Setbacks can lead to even greater comebacks.",
      category: "Technology",
      icon: Iconsax.mobile,
      color: const Color(0xFFF59E0B),
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b9/Steve_Jobs_Headshot_2010-CROP.jpg/640px-Steve_Jobs_Headshot_2010-CROP.jpg",
    ),

    MotivationalStory(
      title: "Sachin Tendulkar’s Early Challenges",
      failure:
          "Struggled with form early in his career, faced criticism after multiple injuries and failures in big matches.",
      success:
          "Became the 'God of Cricket', scoring 100 international centuries and inspiring millions worldwide.",
      lesson: "Consistency and hard work build legends, not overnight success.",
      category: "Sports",
      icon: Iconsax.activity,
      color: const Color(0xFF1A237E),
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/2/25/Sachin_Tendulkar_2015.jpg",
    ),

    MotivationalStory(
      title: "Stephen Hawking’s Disability",
      failure:
          "Diagnosed with ALS at age 21, doctors predicted he would live only 2 years. Lost ability to speak and move independently.",
      success:
          "Became one of the world’s greatest theoretical physicists, author of 'A Brief History of Time', and a symbol of perseverance.",
      lesson:
          "Mind is more powerful than the body. Knowledge and determination overcome physical limits.",
      category: "Science",
      icon: Iconsax.book,
      color: const Color(0xFF283593),
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/e/eb/Stephen_Hawking.StarChild.jpg",
    ),

    MotivationalStory(
      title: "Dhirubhai Ambani’s Modest Start",
      failure:
          "Started as a petrol pump attendant in Yemen with no money or connections. Faced doubts and criticism when building Reliance.",
      success:
          "Founded Reliance Industries, one of India’s largest business empires.",
      lesson:
          "Great businesses can start with small dreams and relentless ambition.",
      category: "Business",
      icon: Iconsax.wallet,
      color: const Color(0xFFD32F2F),
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/1/1b/Dhirubhai_Ambani_2011_stamp_of_India.jpg",
    ),

    MotivationalStory(
      title: "Mary Kom’s Struggles",
      failure:
          "Came from a poor family in Manipur, faced gender stereotypes and lack of facilities in sports.",
      success:
          "Became a six-time world champion boxer and Olympic medalist, inspiring women in sports.",
      lesson:
          "Never let limitations define you. Determination breaks barriers.",
      category: "Sports",
      icon: Iconsax.finger_scan,
      color: const Color(0xFFE91E63),
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/7/70/Mary_Kom_in_2016.jpg",
    ),

    MotivationalStory(
      title: "Nelson Mandela’s Imprisonment",
      failure:
          "Spent 27 years in prison for opposing apartheid in South Africa.",
      success:
          "Became South Africa’s first black President and a global symbol of justice and equality.",
      lesson: "Freedom and justice demand sacrifice, patience, and resilience.",
      category: "Leadership",
      icon: Iconsax.lock,
      color: const Color(0xFF6A1B9A),
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/0/0d/Nelson_Mandela-2008_%28edit%29.jpg",
    ),

    MotivationalStory(
      title: "Amitabh Bachchan’s Setbacks",
      failure:
          "Rejected by radio due to his voice, faced multiple film flops, and went bankrupt after his company failed.",
      success:
          "Rose to become Bollywood’s ‘Shahenshah’ with decades of stardom and unmatched influence.",
      lesson: "Failures are temporary, but resilience makes you timeless.",
      category: "Entertainment",
      icon: Iconsax.video,
      color: const Color(0xFFBF360C),
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/0/0f/Amitabh_Bachchan_2013.jpg",
    ),

    MotivationalStory(
      title: "J.K. Rowling’s Rejections",
      failure:
          "Lived as a struggling single mother on welfare. 'Harry Potter' was rejected by 12 publishers.",
      success:
          "Created the Harry Potter series, one of the most successful franchises in history.",
      lesson:
          "Imagination and persistence can turn rejection into global success.",
      category: "Literature",
      icon: Iconsax.pen_tool,
      color: const Color(0xFF512DA8),
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/5/5d/J._K._Rowling_2010.jpg",
    ),

    MotivationalStory(
      title: "Usain Bolt’s Early Struggles",
      failure:
          "Struggled with scoliosis and poor discipline in training during youth.",
      success:
          "Became the fastest man on Earth, winning 8 Olympic gold medals.",
      lesson: "Focus, discipline, and training unlock hidden potential.",
      category: "Sports",
      icon: Iconsax.timer_1,
      color: const Color(0xFFF57C00),
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/f/fa/Usain_Bolt_Rio_100m_final_2016.jpg",
    ),

    MotivationalStory(
      title: "Kalpana Chawla’s Dream",
      failure:
          "Faced gender bias in choosing aerospace, initially denied opportunities in aviation as an Indian woman.",
      success:
          "Became the first Indian woman in space. Though she died in the Columbia disaster, she remains an icon of courage.",
      lesson: "Dream beyond the skies, even if the path is full of challenges.",
      category: "Science",
      icon: Iconsax.cloud,
      color: const Color(0xFF0288D1),
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/3/3e/Kalpana_Chawla%2C_NASA_photo_portrait_in_orange_suit.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E293B)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Motivational Stories',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle, color: Color(0xFF64748B)),
            onPressed: () {
              final randomIndex =
                  (stories.length *
                          (DateTime.now().millisecondsSinceEpoch % 1000) /
                          1000)
                      .floor();
              setState(() {
                currentStoryIndex = randomIndex;
              });
              pageController.animateToPage(
                randomIndex,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Story counter
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${currentStoryIndex + 1} of ${stories.length}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2BA2B0).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    stories[currentStoryIndex].category,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2BA2B0),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Story cards
          Expanded(
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  currentStoryIndex = index;
                });
              },
              itemCount: stories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: StoryCard(story: stories[index]),
                );
              },
            ),
          ),

          // Navigation controls
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: "previous",
                  onPressed:
                      currentStoryIndex > 0
                          ? () {
                            pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                          : null,
                  backgroundColor:
                      currentStoryIndex > 0
                          ? const Color(0xFF2BA2B0)
                          : Colors.grey[300],
                  child: Icon(
                    Icons.arrow_back_ios,
                    color:
                        currentStoryIndex > 0 ? Colors.white : Colors.grey[600],
                  ),
                ),
                FloatingActionButton.extended(
                  heroTag: "favorite",
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Added "${stories[currentStoryIndex].title}" to favorites!',
                        ),
                        backgroundColor: const Color(0xFF2BA2B0),
                      ),
                    );
                  },
                  backgroundColor: const Color(0xFF2BA2B0),
                  label: const Text(
                    'Save Story',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  icon: const Icon(Icons.favorite, color: Colors.white),
                ),
                FloatingActionButton(
                  heroTag: "next",
                  onPressed:
                      currentStoryIndex < stories.length - 1
                          ? () {
                            pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                          : null,
                  backgroundColor:
                      currentStoryIndex < stories.length - 1
                          ? const Color(0xFF2BA2B0)
                          : Colors.grey[300],
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color:
                        currentStoryIndex < stories.length - 1
                            ? Colors.white
                            : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MotivationalStory {
  final String title;
  final String failure;
  final String success;
  final String lesson;
  final String category;
  final IconData icon;
  final Color color;
  final String? imageUrl; // Optional image URL

  MotivationalStory({
    required this.title,
    required this.failure,
    required this.success,
    required this.lesson,
    required this.category,
    required this.icon,
    required this.color,
    this.imageUrl,
  });
}

class StoryCard extends StatefulWidget {
  final MotivationalStory story;

  const StoryCard({super.key, required this.story});

  @override
  State<StoryCard> createState() => _StoryCardState();
}

class _StoryCardState extends State<StoryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;
  bool isShowingFailure = true;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _flip() {
    if (isShowingFailure) {
      _flipController.forward();
    } else {
      _flipController.reverse();
    }
    setState(() {
      isShowingFailure = !isShowingFailure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flip,
      child: AnimatedBuilder(
        animation: _flipAnimation,
        builder: (context, child) {
          final isShowingFront = _flipAnimation.value < 0.5;
          return Transform(
            alignment: Alignment.center,
            transform:
                Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(_flipAnimation.value * 3.14159),
            child:
                isShowingFront
                    ? _buildFailureSide()
                    : Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateY(3.14159),
                      child: _buildSuccessSide(),
                    ),
          );
        },
      ),
    );
  }

  Widget _buildFailureSide() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [const Color(0xFFF1F5F9), const Color(0xFFE2E8F0)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Iconsax.close_circle,
                    color: Color(0xFF64748B),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'The Struggle',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      Text(
                        'Tap to see the triumph',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Profile Image
            if (widget.story.imageUrl != null)
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFE2E8F0), width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    widget.story.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFE2E8F0),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          widget.story.icon,
                          size: 30,
                          color: const Color(0xFF64748B),
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFE2E8F0),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: CircularProgressIndicator(
                            value:
                                loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                            strokeWidth: 2,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFF64748B),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

            if (widget.story.imageUrl != null) const SizedBox(height: 20),

            // Title
            Text(
              widget.story.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            // Failure content
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  widget.story.failure,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Flip indicator
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.touch_app,
                    size: 16,
                    color: Color(0xFF64748B),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Tap to flip',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessSide() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF0FDFC), Color(0xFFE6FFFA)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2BA2B0).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Iconsax.award,
                    color: Color(0xFF2BA2B0),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'The Triumph',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2BA2B0),
                        ),
                      ),
                      Text(
                        'Tap to see the struggle',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Title
            Text(
              widget.story.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            // Success content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      widget.story.success,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: Colors.grey[800],
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 20),

                    // Lesson
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2BA2B0).withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF2BA2B0).withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Iconsax.lamp_1,
                                color: Color(0xFF2BA2B0),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Key Lesson',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF2BA2B0),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.story.lesson,
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.5,
                              color: Colors.grey[800],
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Flip indicator
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF2BA2B0).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.touch_app,
                    size: 16,
                    color: Color(0xFF2BA2B0),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Tap to flip',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2BA2B0),
                    ),
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
