import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'dart:async';
import '../services/gamification_service.dart';

class BreathingExerciseScreen extends StatefulWidget {
  const BreathingExerciseScreen({super.key});

  @override
  State<BreathingExerciseScreen> createState() => _BreathingExerciseScreenState();
}

class _BreathingExerciseScreenState extends State<BreathingExerciseScreen>
    with TickerProviderStateMixin {
  late AnimationController _breathingController;
  late Animation<double> _breathingAnimation;
  
  final GamificationService _gamificationService = GamificationService();
  
  Timer? _sessionTimer;
  Timer? _phaseTimer;
  
  bool _isActive = false;
  int _sessionDuration = 5; // minutes
  int _remainingTime = 0;
  int _currentCycle = 0;
  
  BreathingPhase _currentPhase = BreathingPhase.inhale;
  
  // Simple breathing technique timing (in seconds)
  final Map<BreathingPhase, int> _breathingTimings = {
    BreathingPhase.inhale: 4,
    BreathingPhase.hold: 2,
    BreathingPhase.exhale: 6,
  };

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _remainingTime = _sessionDuration * 60;
    _calculateTotalCycles();
  }

  void _initializeAnimations() {
    _breathingController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    
    _breathingAnimation = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _breathingController,
      curve: Curves.easeInOut,
    ));
  }

  void _calculateTotalCycles() {
    // Not needed for minimal version
  }

  void _startSession() {
    setState(() {
      _isActive = true;
      _currentCycle = 0;
      _remainingTime = _sessionDuration * 60;
    });
    
    _startSessionTimer();
    _startBreathingCycle();
  }

  void _stopSession() {
    setState(() {
      _isActive = false;
    });
    
    _sessionTimer?.cancel();
    _phaseTimer?.cancel();
    _breathingController.stop();
  }

  void _pauseResumeSession() {
    if (_isActive) {
      _stopSession();
    } else {
      _startSession();
    }
  }

  void _startSessionTimer() {
    _sessionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime--;
      });
      
      if (_remainingTime <= 0) {
        _completeSession();
      }
    });
  }

  void _startBreathingCycle() {
    _currentPhase = BreathingPhase.inhale;
    _executePhase();
  }

  void _executePhase() {
    if (!_isActive) return;
    
    final phaseDuration = _breathingTimings[_currentPhase] ?? 4;
    
    // Update animation based on phase
    switch (_currentPhase) {
      case BreathingPhase.inhale:
        _breathingController.forward(from: 0);
        break;
      case BreathingPhase.hold:
        // Keep current state
        break;
      case BreathingPhase.exhale:
        _breathingController.reverse(from: 1);
        break;
    }
    
    _phaseTimer = Timer(Duration(seconds: phaseDuration), () {
      _nextPhase();
    });
  }

  void _nextPhase() {
    final phases = _breathingTimings.keys.toList();
    final currentIndex = phases.indexOf(_currentPhase);
    
    if (currentIndex < phases.length - 1) {
      setState(() {
        _currentPhase = phases[currentIndex + 1];
      });
      _executePhase();
    } else {
      // Complete cycle
      setState(() {
        _currentCycle++;
        _currentPhase = BreathingPhase.inhale; // Reset to first phase
      });
      if (_isActive && _remainingTime > 0) {
        _startBreathingCycle();
      }
    }
  }

  void _completeSession() {
    _stopSession();
    
    // Award wellness points for completing the breathing exercise
    _gamificationService.addPoints('breathing_exercise');
    
    _showCompletionDialog();
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Session Complete! 🎉'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Congratulations! You completed your $_sessionDuration-minute breathing session.'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Iconsax.star,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '+15 Wellness Points',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text('Total cycles: $_currentCycle'),
            const SizedBox(height: 8),
            const Text('Take a moment to notice how you feel.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Done'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _resetSession();
            },
            child: const Text('Start Again'),
          ),
        ],
      ),
    );
  }

  void _resetSession() {
    setState(() {
      _isActive = false;
      _currentCycle = 0;
      _remainingTime = _sessionDuration * 60;
      _currentPhase = BreathingPhase.inhale;
    });
    
    _breathingController.reset();
    _sessionTimer?.cancel();
    _phaseTimer?.cancel();
  }

  String get _phaseInstruction {
    switch (_currentPhase) {
      case BreathingPhase.inhale:
        return 'Breathe In';
      case BreathingPhase.hold:
        return 'Hold';
      case BreathingPhase.exhale:
        return 'Breathe Out';
    }
  }

  String get _remainingTimeString {
    final minutes = _remainingTime ~/ 60;
    final seconds = _remainingTime % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _breathingController.dispose();
    _sessionTimer?.cancel();
    _phaseTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Breathing',
          style: TextStyle(
            color: Colors.black87, 
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Timer Display
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Time Remaining',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    _remainingTimeString,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            
            // Breathing Circle
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Phase instruction
                    Text(
                      _phaseInstruction,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 60),
                    
                    // Simple breathing circle
                    AnimatedBuilder(
                      animation: _breathingAnimation,
                      builder: (context, child) {
                        return Container(
                          width: 200 * _breathingAnimation.value,
                          height: 200 * _breathingAnimation.value,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 3,
                            ),
                          ),
                          child: Icon(
                            Iconsax.wind_25, // Use a breathing-related icon
                            color: Theme.of(context).colorScheme.primary,
                            size: 40,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            // Simple Controls
            Container(
              margin: const EdgeInsets.all(20),
              child: _isActive
                  ? Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _pauseResumeSession,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[100],
                              foregroundColor: Colors.grey[700],
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(_isActive ? 'Pause' : 'Resume'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _resetSession,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[50],
                              foregroundColor: Colors.red[700],
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Stop'),
                          ),
                        ),
                      ],
                    )
                  : ElevatedButton(
                      onPressed: _startSession,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: const Size(double.infinity, 0),
                      ),
                      child: const Text(
                        'Start Breathing',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

enum BreathingPhase { inhale, hold, exhale }

