import 'package:flutter/material.dart';

class PixelIcons {
  static const double _defaultSize = 24.0;

  // Custom pixel art add icon
  static Widget add({double size = _defaultSize, Color? color}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _AddIconPainter(color ?? Colors.white),
    );
  }

  // Custom pixel art delete icon
  static Widget delete({double size = _defaultSize, Color? color}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _DeleteIconPainter(color ?? Colors.white),
    );
  }

  // Custom pixel art edit icon
  static Widget edit({double size = _defaultSize, Color? color}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _EditIconPainter(color ?? Colors.white),
    );
  }

  // Custom pixel art save icon
  static Widget save({double size = _defaultSize, Color? color}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _SaveIconPainter(color ?? Colors.white),
    );
  }

  // Custom pixel art note icon
  static Widget note({double size = _defaultSize, Color? color}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _NoteIconPainter(color ?? Colors.white),
    );
  }

  // Custom pixel art settings icon
  static Widget settings({double size = _defaultSize, Color? color}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _SettingsIconPainter(color ?? Colors.white),
    );
  }

  // Custom pixel art user icon
  static Widget user({double size = _defaultSize, Color? color}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _UserIconPainter(color ?? Colors.white),
    );
  }

  // Custom pixel art logout icon
  static Widget logout({double size = _defaultSize, Color? color}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _LogoutIconPainter(color ?? Colors.white),
    );
  }

  // Custom pixel art theme icon
  static Widget theme({double size = _defaultSize, Color? color}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _ThemeIconPainter(color ?? Colors.white),
    );
  }

  // Custom pixel art sound icon
  static Widget sound({double size = _defaultSize, Color? color, bool enabled = true}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _SoundIconPainter(color ?? Colors.white, enabled),
    );
  }
}

class _AddIconPainter extends CustomPainter {
  final Color color;
  _AddIconPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final pixelSize = size.width / 8;

    // Draw pixel art + icon
    // Horizontal line
    for (int i = 2; i <= 5; i++) {
      canvas.drawRect(
        Rect.fromLTWH(i * pixelSize, 3 * pixelSize, pixelSize, pixelSize),
        paint,
      );
    }
    // Vertical line
    for (int i = 2; i <= 5; i++) {
      canvas.drawRect(
        Rect.fromLTWH(3 * pixelSize, i * pixelSize, pixelSize, pixelSize),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DeleteIconPainter extends CustomPainter {
  final Color color;
  _DeleteIconPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final pixelSize = size.width / 8;

    // Draw pixel art X icon
    for (int i = 1; i <= 6; i++) {
      // Diagonal from top-left to bottom-right
      canvas.drawRect(
        Rect.fromLTWH(i * pixelSize, i * pixelSize, pixelSize, pixelSize),
        paint,
      );
      // Diagonal from top-right to bottom-left
      canvas.drawRect(
        Rect.fromLTWH((7 - i) * pixelSize, i * pixelSize, pixelSize, pixelSize),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _EditIconPainter extends CustomPainter {
  final Color color;
  _EditIconPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final pixelSize = size.width / 8;

    // Draw pixel art pencil icon
    // Pencil tip
    canvas.drawRect(Rect.fromLTWH(1 * pixelSize, 6 * pixelSize, pixelSize, pixelSize), paint);
    // Pencil body
    for (int i = 2; i <= 5; i++) {
      canvas.drawRect(Rect.fromLTWH(i * pixelSize, (7 - i) * pixelSize, pixelSize, pixelSize), paint);
      canvas.drawRect(Rect.fromLTWH((i + 1) * pixelSize, (7 - i) * pixelSize, pixelSize, pixelSize), paint);
    }
    // Pencil eraser
    canvas.drawRect(Rect.fromLTWH(6 * pixelSize, 1 * pixelSize, pixelSize, pixelSize), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SaveIconPainter extends CustomPainter {
  final Color color;
  _SaveIconPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final pixelSize = size.width / 8;

    // Draw pixel art floppy disk icon
    // Outer frame
    for (int i = 1; i <= 6; i++) {
      canvas.drawRect(Rect.fromLTWH(1 * pixelSize, i * pixelSize, pixelSize, pixelSize), paint);
      canvas.drawRect(Rect.fromLTWH(6 * pixelSize, i * pixelSize, pixelSize, pixelSize), paint);
      canvas.drawRect(Rect.fromLTWH(i * pixelSize, 1 * pixelSize, pixelSize, pixelSize), paint);
      canvas.drawRect(Rect.fromLTWH(i * pixelSize, 6 * pixelSize, pixelSize, pixelSize), paint);
    }
    // Label area
    for (int i = 3; i <= 5; i++) {
      canvas.drawRect(Rect.fromLTWH(i * pixelSize, 2 * pixelSize, pixelSize, pixelSize), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _NoteIconPainter extends CustomPainter {
  final Color color;
  _NoteIconPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final pixelSize = size.width / 8;

    // Draw pixel art document icon
    // Document outline
    for (int i = 1; i <= 6; i++) {
      canvas.drawRect(Rect.fromLTWH(2 * pixelSize, i * pixelSize, pixelSize, pixelSize), paint);
      canvas.drawRect(Rect.fromLTWH(5 * pixelSize, i * pixelSize, pixelSize, pixelSize), paint);
    }
    for (int i = 2; i <= 5; i++) {
      canvas.drawRect(Rect.fromLTWH(i * pixelSize, 1 * pixelSize, pixelSize, pixelSize), paint);
      canvas.drawRect(Rect.fromLTWH(i * pixelSize, 6 * pixelSize, pixelSize, pixelSize), paint);
    }
    // Text lines
    canvas.drawRect(Rect.fromLTWH(3 * pixelSize, 3 * pixelSize, pixelSize, pixelSize), paint);
    canvas.drawRect(Rect.fromLTWH(4 * pixelSize, 3 * pixelSize, pixelSize, pixelSize), paint);
    canvas.drawRect(Rect.fromLTWH(3 * pixelSize, 4 * pixelSize, pixelSize, pixelSize), paint);
    canvas.drawRect(Rect.fromLTWH(3 * pixelSize, 5 * pixelSize, pixelSize, pixelSize), paint);
    canvas.drawRect(Rect.fromLTWH(4 * pixelSize, 5 * pixelSize, pixelSize, pixelSize), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SettingsIconPainter extends CustomPainter {
  final Color color;
  _SettingsIconPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final pixelSize = size.width / 8;

    // Draw pixel art gear icon
    // Center
    canvas.drawRect(Rect.fromLTWH(3 * pixelSize, 3 * pixelSize, pixelSize, pixelSize), paint);
    canvas.drawRect(Rect.fromLTWH(4 * pixelSize, 3 * pixelSize, pixelSize, pixelSize), paint);
    canvas.drawRect(Rect.fromLTWH(3 * pixelSize, 4 * pixelSize, pixelSize, pixelSize), paint);
    canvas.drawRect(Rect.fromLTWH(4 * pixelSize, 4 * pixelSize, pixelSize, pixelSize), paint);

    // Teeth
    canvas.drawRect(Rect.fromLTWH(3 * pixelSize, 1 * pixelSize, 2 * pixelSize, pixelSize), paint);
    canvas.drawRect(Rect.fromLTWH(3 * pixelSize, 6 * pixelSize, 2 * pixelSize, pixelSize), paint);
    canvas.drawRect(Rect.fromLTWH(1 * pixelSize, 3 * pixelSize, pixelSize, 2 * pixelSize), paint);
    canvas.drawRect(Rect.fromLTWH(6 * pixelSize, 3 * pixelSize, pixelSize, 2 * pixelSize), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _UserIconPainter extends CustomPainter {
  final Color color;
  _UserIconPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final pixelSize = size.width / 8;

    // Draw pixel art user icon
    // Head
    for (int i = 3; i <= 4; i++) {
      for (int j = 2; j <= 3; j++) {
        canvas.drawRect(Rect.fromLTWH(i * pixelSize, j * pixelSize, pixelSize, pixelSize), paint);
      }
    }
    // Body
    for (int i = 2; i <= 5; i++) {
      for (int j = 4; j <= 6; j++) {
        canvas.drawRect(Rect.fromLTWH(i * pixelSize, j * pixelSize, pixelSize, pixelSize), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LogoutIconPainter extends CustomPainter {
  final Color color;
  _LogoutIconPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final pixelSize = size.width / 8;

    // Draw pixel art door/exit icon
    // Door frame
    for (int i = 1; i <= 6; i++) {
      canvas.drawRect(Rect.fromLTWH(1 * pixelSize, i * pixelSize, pixelSize, pixelSize), paint);
      canvas.drawRect(Rect.fromLTWH(4 * pixelSize, i * pixelSize, pixelSize, pixelSize), paint);
    }
    for (int i = 1; i <= 4; i++) {
      canvas.drawRect(Rect.fromLTWH(i * pixelSize, 1 * pixelSize, pixelSize, pixelSize), paint);
      canvas.drawRect(Rect.fromLTWH(i * pixelSize, 6 * pixelSize, pixelSize, pixelSize), paint);
    }
    // Door handle
    canvas.drawRect(Rect.fromLTWH(3 * pixelSize, 3 * pixelSize, pixelSize, pixelSize), paint);

    // Arrow pointing out
    canvas.drawRect(Rect.fromLTWH(5 * pixelSize, 3 * pixelSize, pixelSize, pixelSize), paint);
    canvas.drawRect(Rect.fromLTWH(6 * pixelSize, 2 * pixelSize, pixelSize, pixelSize), paint);
    canvas.drawRect(Rect.fromLTWH(6 * pixelSize, 4 * pixelSize, pixelSize, pixelSize), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ThemeIconPainter extends CustomPainter {
  final Color color;
  _ThemeIconPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final pixelSize = size.width / 8;

    // Draw pixel art palette icon
    // Palette outline
    for (int i = 2; i <= 5; i++) {
      canvas.drawRect(Rect.fromLTWH(i * pixelSize, 2 * pixelSize, pixelSize, pixelSize), paint);
      canvas.drawRect(Rect.fromLTWH(i * pixelSize, 5 * pixelSize, pixelSize, pixelSize), paint);
    }
    for (int i = 2; i <= 5; i++) {
      canvas.drawRect(Rect.fromLTWH(2 * pixelSize, i * pixelSize, pixelSize, pixelSize), paint);
      canvas.drawRect(Rect.fromLTWH(5 * pixelSize, i * pixelSize, pixelSize, pixelSize), paint);
    }
    // Color dots
    canvas.drawRect(Rect.fromLTWH(3 * pixelSize, 3 * pixelSize, pixelSize, pixelSize), paint);
    canvas.drawRect(Rect.fromLTWH(4 * pixelSize, 4 * pixelSize, pixelSize, pixelSize), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SoundIconPainter extends CustomPainter {
  final Color color;
  final bool enabled;
  _SoundIconPainter(this.color, this.enabled);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final pixelSize = size.width / 8;

    // Draw pixel art speaker icon
    // Speaker base
    for (int i = 3; i <= 4; i++) {
      canvas.drawRect(Rect.fromLTWH(2 * pixelSize, i * pixelSize, pixelSize, pixelSize), paint);
    }
    // Speaker cone
    canvas.drawRect(Rect.fromLTWH(3 * pixelSize, 2 * pixelSize, pixelSize, pixelSize), paint);
    canvas.drawRect(Rect.fromLTWH(3 * pixelSize, 5 * pixelSize, pixelSize, pixelSize), paint);
    canvas.drawRect(Rect.fromLTWH(4 * pixelSize, 1 * pixelSize, pixelSize, pixelSize), paint);
    canvas.drawRect(Rect.fromLTWH(4 * pixelSize, 6 * pixelSize, pixelSize, pixelSize), paint);

    if (enabled) {
      // Sound waves
      canvas.drawRect(Rect.fromLTWH(5 * pixelSize, 3 * pixelSize, pixelSize, pixelSize), paint);
      canvas.drawRect(Rect.fromLTWH(5 * pixelSize, 4 * pixelSize, pixelSize, pixelSize), paint);
      canvas.drawRect(Rect.fromLTWH(6 * pixelSize, 2 * pixelSize, pixelSize, pixelSize), paint);
      canvas.drawRect(Rect.fromLTWH(6 * pixelSize, 5 * pixelSize, pixelSize, pixelSize), paint);
    } else {
      // X for muted
      canvas.drawRect(Rect.fromLTWH(5 * pixelSize, 2 * pixelSize, pixelSize, pixelSize), paint);
      canvas.drawRect(Rect.fromLTWH(6 * pixelSize, 3 * pixelSize, pixelSize, pixelSize), paint);
      canvas.drawRect(Rect.fromLTWH(5 * pixelSize, 4 * pixelSize, pixelSize, pixelSize), paint);
      canvas.drawRect(Rect.fromLTWH(6 * pixelSize, 5 * pixelSize, pixelSize, pixelSize), paint);
      canvas.drawRect(Rect.fromLTWH(6 * pixelSize, 2 * pixelSize, pixelSize, pixelSize), paint);
      canvas.drawRect(Rect.fromLTWH(5 * pixelSize, 5 * pixelSize, pixelSize, pixelSize), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}