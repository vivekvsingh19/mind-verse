import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import '../services/audio_service.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String audioPath;
  final bool isAsset;
  final Color? primaryColor;
  final bool showFullControls;

  const AudioPlayerWidget({
    super.key,
    required this.title,
    this.subtitle,
    required this.audioPath,
    this.isAsset = true,
    this.primaryColor,
    this.showFullControls = true,
  });

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final AudioService _audioService = AudioService();
  double _volume = 1.0;

  @override
  void initState() {
    super.initState();
    _audioService.addListener(_onAudioStateChanged);
  }

  @override
  void dispose() {
    _audioService.removeListener(_onAudioStateChanged);
    super.dispose();
  }

  void _onAudioStateChanged() {
    setState(() {});
  }

  bool get _isCurrentTrack => _audioService.currentTrack == widget.audioPath;

  Future<void> _togglePlayPause() async {
    if (_isCurrentTrack && _audioService.isPlaying) {
      await _audioService.pause();
    } else if (_isCurrentTrack && !_audioService.isPlaying) {
      await _audioService.play();
    } else {
      if (widget.isAsset) {
        await _audioService.playAsset(widget.audioPath);
      } else {
        await _audioService.playUrl(widget.audioPath);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = widget.primaryColor ?? theme.colorScheme.primary;
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and subtitle
            Row(
              children: [
                Icon(
                  Iconsax.music,
                  color: primaryColor,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (widget.subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          widget.subtitle!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Progress bar (only show if this track is playing)
            if (_isCurrentTrack && widget.showFullControls) ...[
              ProgressBar(
                progress: _audioService.position,
                total: _audioService.duration,
                progressBarColor: primaryColor,
                thumbColor: primaryColor,
                baseBarColor: Colors.grey[300],
                bufferedBarColor: Colors.grey[400],
                timeLabelTextStyle: theme.textTheme.bodySmall,
                onSeek: (duration) {
                  _audioService.seek(duration);
                },
              ),
              const SizedBox(height: 16),
            ],
            
            // Controls
            Row(
              children: [
                // Play/Pause button
                Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: _audioService.isLoading ? null : _togglePlayPause,
                    icon: _audioService.isLoading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : Icon(
                            (_isCurrentTrack && _audioService.isPlaying)
                                ? Iconsax.pause
                                : Iconsax.play,
                            color: Colors.white,
                            size: 24,
                          ),
                  ),
                ),
                
                if (widget.showFullControls && _isCurrentTrack) ...[
                  const SizedBox(width: 16),
                  
                  // Stop button
                  IconButton(
                    onPressed: () => _audioService.stop(),
                    icon: Icon(
                      Iconsax.stop,
                      color: Colors.grey[600],
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // Volume control
                  Icon(
                    Iconsax.volume_high,
                    color: Colors.grey[600],
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 100,
                    child: Slider(
                      value: _volume,
                      onChanged: (value) {
                        setState(() {
                          _volume = value;
                        });
                        _audioService.setVolume(value);
                      },
                      activeColor: primaryColor,
                      inactiveColor: Colors.grey[300],
                    ),
                  ),
                ],
                
                if (!widget.showFullControls) ...[
                  const Spacer(),
                  Text(
                    _isCurrentTrack 
                        ? '${_formatDuration(_audioService.position)} / ${_formatDuration(_audioService.duration)}'
                        : _formatDuration(_audioService.duration),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
