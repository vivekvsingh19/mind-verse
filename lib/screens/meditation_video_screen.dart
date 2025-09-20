import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../widgets/video_player_widget.dart';

class MeditationVideoScreen extends StatelessWidget {
  const MeditationVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meditation Video'),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const SingleChildScrollView(
        //padding: EdgeInsets.all(1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            
            // Video player
            VideoPlayerWidget(
              title: 'Meditation Session',
              subtitle: 'Your personal meditation video from assets/videos/medition.mp4',
              videoPath: 'assets/videos/medition.mp4',
              isAsset: true,
              autoPlay: false,
              showControls: true,
            ),
            
          ],
        ),
      ),
    );
  }
}
