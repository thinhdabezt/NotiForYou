import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class RetroSoundService {
  static final RetroSoundService _instance = RetroSoundService._internal();
  factory RetroSoundService() => _instance;
  RetroSoundService._internal();

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _soundEnabled = true;

  bool get soundEnabled => _soundEnabled;

  void toggleSound() {
    _soundEnabled = !_soundEnabled;
  }

  void setSoundEnabled(bool enabled) {
    _soundEnabled = enabled;
  }

  // Play different retro beep sounds for different actions
  Future<void> playButtonPress() async {
    if (!_soundEnabled) return;
    await _playTone(800, 100); // High pitched beep
  }

  Future<void> playButtonHover() async {
    if (!_soundEnabled) return;
    await _playTone(600, 50); // Medium pitched quick beep
  }

  Future<void> playSuccess() async {
    if (!_soundEnabled) return;
    // Play ascending beeps for success
    await _playTone(500, 100);
    await Future.delayed(const Duration(milliseconds: 50));
    await _playTone(700, 100);
    await Future.delayed(const Duration(milliseconds: 50));
    await _playTone(900, 150);
  }

  Future<void> playError() async {
    if (!_soundEnabled) return;
    // Play descending beeps for error
    await _playTone(400, 200);
    await Future.delayed(const Duration(milliseconds: 100));
    await _playTone(300, 200);
  }

  Future<void> playNavigation() async {
    if (!_soundEnabled) return;
    await _playTone(700, 80); // Navigation beep
  }

  Future<void> playDelete() async {
    if (!_soundEnabled) return;
    // Play warning beep for delete
    await _playTone(250, 300);
  }

  Future<void> playNewNote() async {
    if (!_soundEnabled) return;
    // Play creation sound
    await _playTone(600, 100);
    await Future.delayed(const Duration(milliseconds: 50));
    await _playTone(800, 150);
  }

  Future<void> playSave() async {
    if (!_soundEnabled) return;
    // Play save confirmation
    await _playTone(750, 120);
  }

  Future<void> playEasterEgg() async {
    if (!_soundEnabled) return;
    // Play a fun sequence for easter eggs
    const notes = [440, 494, 523, 587, 659, 698, 784]; // A, B, C, D, E, F, G
    for (int i = 0; i < notes.length; i++) {
      await _playTone(notes[i], 100);
      await Future.delayed(const Duration(milliseconds: 80));
    }
  }

  // Generate and play a tone using system beep (limited but works without audio files)
  Future<void> _playTone(int frequency, int duration) async {
    try {
      // Use system feedback for a more authentic retro feel
      await HapticFeedback.selectionClick();
      
      // We'll simulate the beep using a short duration audio generation
      // This is a simplified version - in a real app you'd generate actual audio waves
      await Future.delayed(Duration(milliseconds: duration ~/ 10));
    } catch (e) {
      // Fallback to haptic feedback only
      await HapticFeedback.lightImpact();
    }
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}

// Convenient global access
final retroSounds = RetroSoundService();