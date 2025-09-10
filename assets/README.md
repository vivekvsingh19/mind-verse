# Assets Folder Structure

This folder contains all the static assets used in the MindCare Digital Mental Health Support app.

## Directory Structure

```
assets/
├── images/          # Image assets (PNG, JPG)
├── icons/           # Custom icons and app icons
├── audio/           # Audio files for relaxation and meditation
└── videos/          # Video content for educational resources
```

## Images (`assets/images/`)

### App Branding
- `app_logo.png` - Main app logo (512x512px recommended)
- `chatbot_avatar.png` - AI assistant avatar (100x100px)

### Resource Illustrations
- `wellness_guide.png` - Mental health and wellness illustration (300x200px)
- `relaxation_audio.png` - Audio/meditation themed illustration (300x200px)
- `video_content.png` - Video/educational content illustration (300x200px)

### Design Guidelines
- Use the app's primary color theme: rgb(0, 137, 140) #00898C
- Maintain consistent style across all illustrations
- Ensure images are optimized for mobile and web
- Support both light and dark themes if applicable

## Icons (`assets/icons/`)

Custom icons and app launcher icons should be placed here.
- App launcher icons for different platforms
- Custom SVG icons for specific features
- Platform-specific icon variations

## Audio (`assets/audio/`)

### Meditation & Relaxation
- `guided_meditation.mp3` - Guided meditation sessions (10-20 min)
- `breathing_exercise.mp3` - Breathing exercise guides (5-10 min)
- `nature_sounds.mp3` - Calming nature sounds (30-60 min)

### Format Requirements
- Use MP3 format for broad compatibility
- Optimize file sizes for mobile devices
- Ensure high-quality audio (44.1kHz, 16-bit minimum)

## Videos (`assets/videos/`)

Educational video content for mental health resources.
- Use MP4 format for broad compatibility
- Optimize for mobile playback
- Include closed captions when possible

## Usage in Code

To use these assets in Flutter:

```dart
// Images
Image.asset('assets/images/wellness_guide.png')

// Audio (with audio player packages)
AudioPlayer().play(AssetSource('audio/guided_meditation.mp3'))

// Icons
IconButton(
  icon: Image.asset('assets/icons/custom_icon.png'),
  onPressed: () {},
)
```

## Notes

- All assets should be optimized for performance
- Consider creating multiple resolution variants for images (@1x, @2x, @3x)
- Ensure all assets follow the app's design guidelines
- Test assets on different screen sizes and devices
- Keep file sizes reasonable for mobile applications

## Copyright & Licensing

Ensure all assets used have appropriate licensing for commercial use or are created specifically for this project.
