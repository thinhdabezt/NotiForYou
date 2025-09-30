import 'package:flutter/material.dart';
import 'package:notiforyou/services/audio/retro_sound_service.dart';
import 'package:notiforyou/services/theme/theme_manager.dart';
import 'package:notiforyou/view/widgets/pixel_widgets.dart';

class EasterEggService {
  static final EasterEggService _instance = EasterEggService._internal();
  factory EasterEggService() => _instance;
  EasterEggService._internal();

  final List<String> _konamiCode = ['UP', 'UP', 'DOWN', 'DOWN', 'LEFT', 'RIGHT', 'LEFT', 'RIGHT', 'B', 'A'];
  final List<String> _currentSequence = [];
  int _tapCount = 0;
  DateTime? _lastTap;

  // Check for Konami Code
  void addInput(String input) {
    _currentSequence.add(input);
    if (_currentSequence.length > _konamiCode.length) {
      _currentSequence.removeAt(0);
    }

    if (_sequenceMatches(_konamiCode)) {
      _triggerKonamiEasterEgg();
      _currentSequence.clear();
    }
  }

  // Check for rapid taps
  void addTap() {
    final now = DateTime.now();
    if (_lastTap != null && now.difference(_lastTap!).inMilliseconds < 500) {
      _tapCount++;
    } else {
      _tapCount = 1;
    }
    _lastTap = now;

    if (_tapCount >= 10) {
      _triggerRapidTapEasterEgg();
      _tapCount = 0;
    }
  }

  bool _sequenceMatches(List<String> target) {
    if (_currentSequence.length != target.length) return false;
    for (int i = 0; i < target.length; i++) {
      if (_currentSequence[i] != target[i]) return false;
    }
    return true;
  }

  void _triggerKonamiEasterEgg() {
    retroSounds.playEasterEgg();
    // This would show a special dialog or unlock features
  }

  void _triggerRapidTapEasterEgg() {
    retroSounds.playEasterEgg();
    // This would trigger a different easter egg
  }
}

class EasterEggDetector extends StatefulWidget {
  final Widget child;

  const EasterEggDetector({Key? key, required this.child}) : super(key: key);

  @override
  State<EasterEggDetector> createState() => _EasterEggDetectorState();
}

class _EasterEggDetectorState extends State<EasterEggDetector> {
  final _easterEggService = EasterEggService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _easterEggService.addTap();
      },
      child: widget.child,
    );
  }
}

class SecretMinigame extends StatefulWidget {
  const SecretMinigame({Key? key}) : super(key: key);

  @override
  State<SecretMinigame> createState() => _SecretMinigameState();
}

class _SecretMinigameState extends State<SecretMinigame>
    with SingleTickerProviderStateMixin {
  late AnimationController _gameController;
  int _score = 0;
  double _playerX = 0.5;
  final List<double> _obstacles = [];
  bool _gameRunning = false;

  @override
  void initState() {
    super.initState();
    _gameController = AnimationController(
      duration: const Duration(milliseconds: 50),
      vsync: this,
    );

    _gameController.addListener(_updateGame);
  }

  @override
  void dispose() {
    _gameController.dispose();
    super.dispose();
  }

  void _startGame() {
    setState(() {
      _gameRunning = true;
      _score = 0;
      _obstacles.clear();
      _playerX = 0.5;
    });
    _gameController.repeat();
    retroSounds.playSuccess();
  }

  void _stopGame() {
    setState(() {
      _gameRunning = false;
    });
    _gameController.stop();
    retroSounds.playError();
  }

  void _updateGame() {
    setState(() {
      // Move obstacles down
      for (int i = _obstacles.length - 1; i >= 0; i--) {
        _obstacles[i] += 0.02;
        if (_obstacles[i] > 1.2) {
          _obstacles.removeAt(i);
          _score += 10;
        }
      }

      // Add new obstacles
      if (_obstacles.isEmpty || _obstacles.last < 0.8) {
        if (DateTime.now().millisecondsSinceEpoch % 100 < 5) {
          _obstacles.add(-0.1);
        }
      }

      // Check collisions
      for (double obstacle in _obstacles) {
        if (obstacle > 0.8 && obstacle < 1.0) {
          if ((_playerX - obstacle).abs() < 0.1) {
            _stopGame();
            break;
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PixelAppBar(
        title: "◉ SECRET ARCADE ◉",
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              themeManager.currentTheme.primaryBackground,
              themeManager.currentTheme.secondaryBackground,
            ],
          ),
        ),
        child: Column(
          children: [
            // Score
            PixelContainer(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "SCORE: $_score",
                    style: TextStyle(
                      fontFamily: 'Courier',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: themeManager.currentTheme.accentText,
                    ),
                  ),
                  if (!_gameRunning)
                    PixelButton(
                      text: "START",
                      onPressed: _startGame,
                    ),
                ],
              ),
            ),

            // Game area
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: PixelContainer(
                  padding: const EdgeInsets.all(8),
                  child: _gameRunning ? _buildGameArea() : _buildInstructions(),
                ),
              ),
            ),

            // Controls
            if (_gameRunning)
              PixelContainer(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PixelButton(
                      text: "◄",
                      onPressed: () {
                        setState(() {
                          _playerX = (_playerX - 0.1).clamp(0.0, 1.0);
                        });
                        retroSounds.playButtonPress();
                      },
                      width: 60,
                    ),
                    PixelButton(
                      text: "►",
                      onPressed: () {
                        setState(() {
                          _playerX = (_playerX + 0.1).clamp(0.0, 1.0);
                        });
                        retroSounds.playButtonPress();
                      },
                      width: 60,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameArea() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            // Player
            Positioned(
              left: _playerX * constraints.maxWidth - 10,
              bottom: 20,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: themeManager.currentTheme.primaryText,
                  border: Border.all(
                    color: themeManager.currentTheme.borderColor,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    "♦",
                    style: TextStyle(
                      color: themeManager.currentTheme.primaryBackground,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),

            // Obstacles
            ..._obstacles.map((obstacle) {
              return Positioned(
                left: obstacle * constraints.maxWidth - 10,
                top: obstacle * constraints.maxHeight,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: themeManager.currentTheme.errorText,
                    border: Border.all(
                      color: themeManager.currentTheme.errorBorderColor,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "▲",
                      style: TextStyle(
                        color: themeManager.currentTheme.primaryBackground,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        );
      },
    );
  }

  Widget _buildInstructions() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "🎮 RETRO DODGE 🎮",
            style: TextStyle(
              fontFamily: 'Courier',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: themeManager.currentTheme.accentText,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Avoid the red triangles!\nMove with ◄ ► buttons",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Courier',
              fontSize: 16,
              color: themeManager.currentTheme.primaryText,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Hidden mini-game unlocked!\nYou found the secret! 🎉",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Courier',
              fontSize: 14,
              color: themeManager.currentTheme.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}

// Special 8-bit loading animation for easter eggs
class RetroLoadingAnimation extends StatefulWidget {
  final String message;

  const RetroLoadingAnimation({
    Key? key,
    this.message = "LOADING...",
  }) : super(key: key);

  @override
  State<RetroLoadingAnimation> createState() => _RetroLoadingAnimationState();
}

class _RetroLoadingAnimationState extends State<RetroLoadingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final _loadingChars = ['|', '/', '-', '\\'];
  int _charIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _controller.addListener(() {
      setState(() {
        _charIndex = (_charIndex + 1) % _loadingChars.length;
      });
    });

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.message,
          style: TextStyle(
            fontFamily: 'Courier',
            fontSize: 16,
            color: themeManager.currentTheme.primaryText,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          _loadingChars[_charIndex],
          style: TextStyle(
            fontFamily: 'Courier',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: themeManager.currentTheme.accentText,
          ),
        ),
      ],
    );
  }
}