import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import '../services/network_audio_service.dart';

class NetworkAudioPlayerWidget extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String? audioUrl;
  final String? assetPath;
  final Color? primaryColor;
  final bool showFullControls;
  final bool isNetworkStream;

  const NetworkAudioPlayerWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.audioUrl,
    this.assetPath,
    this.primaryColor,
    this.showFullControls = true,
    this.isNetworkStream = false,
  });

  @override
  State<NetworkAudioPlayerWidget> createState() => _NetworkAudioPlayerWidgetState();
}

class _NetworkAudioPlayerWidgetState extends State<NetworkAudioPlayerWidget> {
  final NetworkAudioService _audioService = NetworkAudioService();
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
    if (mounted) setState(() {});
  }

  bool get _isCurrentTrack {
    return _audioService.currentTrack == widget.title ||
           _audioService.currentTrack == widget.audioUrl ||
           _audioService.currentTrack == widget.assetPath;
  }

  Future<void> _togglePlayPause() async {
    if (_isCurrentTrack && _audioService.isPlaying) {
      await _audioService.pause();
    } else if (_isCurrentTrack && !_audioService.isPlaying) {
      await _audioService.play();
    } else {
      if (widget.isNetworkStream && widget.audioUrl != null) {
        await _audioService.playFromUrl(widget.audioUrl!, title: widget.title);
      } else if (widget.assetPath != null) {
        await _audioService.playAsset(widget.assetPath!);
      }
    }
  }

  Widget _buildErrorWidget() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Row(
        children: [
          Icon(
            Iconsax.warning_2,
            color: Colors.red[600],
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _audioService.errorMessage ?? 'Network error occurred',
              style: TextStyle(
                color: Colors.red[700],
                fontSize: 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          TextButton(
            onPressed: () {
              _audioService.clearError();
              _togglePlayPause();
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              minimumSize: Size.zero,
            ),
            child: Text(
              'Retry',
              style: TextStyle(
                color: Colors.red[600],
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
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
                  widget.isNetworkStream ? Iconsax.global : Iconsax.music,
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
                      if (widget.isNetworkStream) ...[
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Iconsax.wifi,
                              size: 12,
                              color: Colors.grey[500],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Streaming',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.grey[500],
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                // Network signal indicator
                if (widget.isNetworkStream && _isCurrentTrack) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _audioService.isBuffering 
                          ? Colors.orange[100] 
                          : Colors.green[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 8,
                          height: 8,
                          child: _audioService.isBuffering 
                              ? CircularProgressIndicator(
                                  strokeWidth: 1,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.orange[600]!,
                                  ),
                                )
                              : Icon(
                                  Iconsax.tick_circle,
                                  size: 8,
                                  color: Colors.green[600],
                                ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _audioService.isBuffering ? 'Buffering' : 'Connected',
                          style: TextStyle(
                            fontSize: 10,
                            color: _audioService.isBuffering 
                                ? Colors.orange[600] 
                                : Colors.green[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Error display
            if (_audioService.hasNetworkError && _isCurrentTrack) ...[
              _buildErrorWidget(),
              const SizedBox(height: 16),
            ],
            
            // Progress bar (only show if this track is playing)
            if (_isCurrentTrack && widget.showFullControls && !_audioService.hasNetworkError) ...[
              ProgressBar(
                progress: _audioService.position,
                total: _audioService.duration,
                buffered: _audioService.bufferedPosition,
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
                    onPressed: (_audioService.isLoading && _isCurrentTrack) ? null : _togglePlayPause,
                    icon: _audioService.isLoading && _isCurrentTrack
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
                
                if (widget.showFullControls && _isCurrentTrack && !_audioService.hasNetworkError) ...[
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
                  
                  // Speed control
                  PopupMenuButton<double>(
                    icon: Icon(
                      Iconsax.setting_2,
                      color: Colors.grey[600],
                      size: 20,
                    ),
                    onSelected: (speed) {
                      _audioService.setSpeed(speed);
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(value: 0.5, child: Text('0.5x')),
                      const PopupMenuItem(value: 0.75, child: Text('0.75x')),
                      const PopupMenuItem(value: 1.0, child: Text('1.0x')),
                      const PopupMenuItem(value: 1.25, child: Text('1.25x')),
                      const PopupMenuItem(value: 1.5, child: Text('1.5x')),
                      const PopupMenuItem(value: 2.0, child: Text('2.0x')),
                    ],
                  ),
                  
                  // Volume control
                  Icon(
                    _volume > 0.5 ? Iconsax.volume_high : 
                    _volume > 0 ? Iconsax.volume_low : Iconsax.volume_slash,
                    color: Colors.grey[600],
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 80,
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
                        : 'Tap to play',
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
