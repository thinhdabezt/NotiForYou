import 'package:flutter/material.dart';
import 'package:notiforyou/services/theme/theme_manager.dart';

class TypingAnimation extends StatefulWidget {
  final String text;
  final Duration speed;
  final TextStyle? style;
  final VoidCallback? onComplete;
  final bool showCursor;

  const TypingAnimation({
    Key? key,
    required this.text,
    this.speed = const Duration(milliseconds: 50),
    this.style,
    this.onComplete,
    this.showCursor = true,
  }) : super(key: key);

  @override
  State<TypingAnimation> createState() => _TypingAnimationState();
}

class _TypingAnimationState extends State<TypingAnimation>
    with TickerProviderStateMixin {
  late AnimationController _typingController;
  late AnimationController _cursorController;
  late Animation<int> _typingAnimation;
  String _displayText = '';

  @override
  void initState() {
    super.initState();

    _typingController = AnimationController(
      duration: widget.speed * widget.text.length,
      vsync: this,
    );

    _cursorController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _typingAnimation = IntTween(
      begin: 0,
      end: widget.text.length,
    ).animate(CurvedAnimation(
      parent: _typingController,
      curve: Curves.linear,
    ));

    _typingAnimation.addListener(() {
      setState(() {
        _displayText = widget.text.substring(0, _typingAnimation.value);
      });
    });

    _typingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete?.call();
        if (widget.showCursor) {
          _cursorController.repeat(reverse: true);
        }
      }
    });

    if (widget.showCursor) {
      _cursorController.repeat(reverse: true);
    }

    _typingController.forward();
  }

  @override
  void dispose() {
    _typingController.dispose();
    _cursorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_typingController, _cursorController]),
      builder: (context, child) {
        return RichText(
          text: TextSpan(
            style: widget.style ??
                TextStyle(
                  fontFamily: 'Courier',
                  fontSize: 16,
                  color: themeManager.currentTheme.primaryText,
                ),
            children: [
              TextSpan(text: _displayText),
              if (widget.showCursor && _typingController.isCompleted)
                TextSpan(
                  text: '█',
                  style: TextStyle(
                    color: themeManager.currentTheme.primaryText
                        .withValues(alpha: _cursorController.value),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class PixelGlitchEffect extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final bool enabled;

  const PixelGlitchEffect({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.enabled = true,
  }) : super(key: key);

  @override
  State<PixelGlitchEffect> createState() => _PixelGlitchEffectState();
}

class _PixelGlitchEffectState extends State<PixelGlitchEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _offsetAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void trigger() {
    if (widget.enabled) {
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: trigger,
      child: AnimatedBuilder(
        animation: _offsetAnimation,
        builder: (context, child) {
          if (!widget.enabled || _offsetAnimation.value == 0) {
            return widget.child;
          }

          return Transform.translate(
            offset: Offset(
              (_offsetAnimation.value * 4 - 2) * (1 - _offsetAnimation.value),
              0,
            ),
            child: widget.child,
          );
        },
      ),
    );
  }
}

class PixelPulseAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double minScale;
  final double maxScale;

  const PixelPulseAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.minScale = 0.95,
    this.maxScale = 1.05,
  }) : super(key: key);

  @override
  State<PixelPulseAnimation> createState() => _PixelPulseAnimationState();
}

class _PixelPulseAnimationState extends State<PixelPulseAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: widget.minScale,
      end: widget.maxScale,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: widget.child,
        );
      },
    );
  }
}

class MatrixRainAnimation extends StatefulWidget {
  final double height;
  final double width;

  const MatrixRainAnimation({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  State<MatrixRainAnimation> createState() => _MatrixRainAnimationState();
}

class _MatrixRainAnimationState extends State<MatrixRainAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_MatrixColumn> _columns = [];
  final _chars = '01アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲン';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );

    // Create columns
    for (int i = 0; i < (widget.width / 20).floor(); i++) {
      _columns.add(_MatrixColumn(
        x: i * 20.0,
        chars: _chars,
        height: widget.height,
      ));
    }

    _controller.addListener(() {
      setState(() {
        for (var column in _columns) {
          column.update();
        }
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
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: CustomPaint(
        painter: _MatrixPainter(_columns, themeManager.currentTheme.primaryText),
      ),
    );
  }
}

class _MatrixColumn {
  final double x;
  final String chars;
  final double height;
  double y = 0;
  final List<String> columnChars = [];
  final List<double> charOpacities = [];

  _MatrixColumn({
    required this.x,
    required this.chars,
    required this.height,
  }) {
    reset();
  }

  void reset() {
    y = -height / 2;
    columnChars.clear();
    charOpacities.clear();
    
    final length = (height / 20).floor();
    for (int i = 0; i < length; i++) {
      columnChars.add(chars[(chars.length * (i / length)).floor()]);
      charOpacities.add((1 - i / length).clamp(0.0, 1.0));
    }
  }

  void update() {
    y += 2;
    if (y > height) {
      reset();
    }
  }
}

class _MatrixPainter extends CustomPainter {
  final List<_MatrixColumn> columns;
  final Color color;

  _MatrixPainter(this.columns, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    for (var column in columns) {
      for (int i = 0; i < column.columnChars.length; i++) {
        final charY = column.y + (i * 20);
        if (charY >= 0 && charY <= size.height) {
          textPainter.text = TextSpan(
            text: column.columnChars[i],
            style: TextStyle(
              fontFamily: 'Courier',
              fontSize: 16,
              color: color.withValues(alpha: column.charOpacities[i]),
            ),
          );
          textPainter.layout();
          textPainter.paint(canvas, Offset(column.x, charY));
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}