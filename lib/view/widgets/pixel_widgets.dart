import 'package:flutter/material.dart';
import 'package:notiforyou/services/theme/theme_manager.dart';
import 'package:notiforyou/services/audio/retro_sound_service.dart';

class PixelButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  final bool isSecondary;

  const PixelButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.width,
    this.height,
    this.isSecondary = false,
  }) : super(key: key);

  @override
  State<PixelButton> createState() => _PixelButtonState();
}

class _PixelButtonState extends State<PixelButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = themeManager.currentTheme;
    final backgroundColor = widget.backgroundColor ?? 
        (widget.isSecondary ? theme.secondaryButton : theme.primaryButton);
    final textColor = widget.textColor ?? theme.primaryBackground;
    final borderColor = widget.borderColor ?? theme.borderColor;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () {
        retroSounds.playButtonPress();
        widget.onPressed?.call();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: widget.width,
        height: widget.height ?? 48,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor,
            width: 3.0,
          ),
          borderRadius: BorderRadius.circular(0),
          boxShadow: _isPressed 
            ? [] 
            : [
                const BoxShadow(
                  color: Colors.black,
                  offset: Offset(4, 4),
                  blurRadius: 0,
                ),
              ],
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              fontFamily: 'Courier',
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: textColor,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}

class PixelTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final bool enableSuggestions;
  final bool autocorrect;
  final int? maxLines;
  final ValueChanged<String>? onChanged;
  final Color? borderColor;
  final Color? focusedBorderColor;

  const PixelTextField({
    Key? key,
    this.controller,
    this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.enableSuggestions = true,
    this.autocorrect = true,
    this.maxLines = 1,
    this.onChanged,
    this.borderColor,
    this.focusedBorderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = themeManager.currentTheme;
    
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      enableSuggestions: enableSuggestions,
      autocorrect: autocorrect,
      maxLines: maxLines,
      onChanged: onChanged,
      style: TextStyle(
        fontFamily: 'Courier',
        fontSize: 16.0,
        color: theme.primaryText,
        letterSpacing: 1.0,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: 'Courier',
          fontSize: 14.0,
          color: const Color(0xFF666666),
          letterSpacing: 1.0,
        ),
        filled: true,
        fillColor: theme.inputBackground,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(
            color: borderColor ?? theme.borderColor,
            width: 3.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(
            color: focusedBorderColor ?? theme.focusedBorderColor,
            width: 3.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(
            color: theme.errorBorderColor,
            width: 3.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(
            color: theme.errorBorderColor,
            width: 3.0,
          ),
        ),
      ),
    );
  }
}

class PixelContainer extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;

  const PixelContainer({
    Key? key,
    required this.child,
    this.backgroundColor,
    this.borderColor,
    this.padding,
    this.margin,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = themeManager.currentTheme;
    
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.cardBackground,
        border: Border.all(
          color: borderColor ?? theme.borderColor,
          width: 3.0,
        ),
        borderRadius: BorderRadius.circular(0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(4, 4),
            blurRadius: 0,
          ),
        ],
      ),
      child: child,
    );
  }
}

class PixelAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;

  const PixelAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = themeManager.currentTheme;
    
    return Container(
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xFF00FF00), // Use dynamic color later
            width: 3.0,
          ),
        ),
      ),
      child: AppBar(
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Courier',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: theme.secondaryText,
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: actions,
        leading: leading,
        automaticallyImplyLeading: automaticallyImplyLeading,
        iconTheme: IconThemeData(
          color: theme.primaryText,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class PixelListTile extends StatelessWidget {
  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? contentPadding;

  const PixelListTile({
    Key? key,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = themeManager.currentTheme;
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: theme.cardBackground,
        border: Border.all(
          color: theme.borderColor,
          width: 3.0,
        ),
        borderRadius: BorderRadius.circular(0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(4, 4),
            blurRadius: 0,
          ),
        ],
      ),
      child: ListTile(
        title: title,
        subtitle: subtitle,
        leading: leading,
        trailing: trailing,
        onTap: () {
          retroSounds.playNavigation();
          onTap?.call();
        },
        contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textColor: theme.primaryText,
        iconColor: theme.secondaryText,
      ),
    );
  }
}

class PixelIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;
  final double? size;
  final String? tooltip;

  const PixelIconButton({
    Key? key,
    required this.icon,
    this.onPressed,
    this.color,
    this.size,
    this.tooltip,
  }) : super(key: key);

  @override
  State<PixelIconButton> createState() => _PixelIconButtonState();
}

class _PixelIconButtonState extends State<PixelIconButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = themeManager.currentTheme;
    
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () {
        retroSounds.playButtonPress();
        widget.onPressed?.call();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.all(8),
        decoration: _isPressed 
          ? BoxDecoration(
              color: theme.tertiaryBackground,
              border: Border.all(
                color: theme.borderColor,
                width: 3.0,
              ),
              borderRadius: BorderRadius.circular(0),
            )
          : null,
        child: Icon(
          widget.icon,
          color: widget.color ?? theme.primaryText,
          size: widget.size ?? 24,
        ),
      ),
    );
  }
}

class PixelCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final Color? borderColor;

  const PixelCard({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = themeManager.currentTheme;
    
    return Container(
      margin: margin ?? const EdgeInsets.all(8),
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.cardBackground,
        border: Border.all(
          color: borderColor ?? theme.borderColor,
          width: 3.0,
        ),
        borderRadius: BorderRadius.circular(0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(4, 4),
            blurRadius: 0,
          ),
        ],
      ),
      child: child,
    );
  }
}

class PixelProgressIndicator extends StatelessWidget {
  final double? value;
  final Color? backgroundColor;
  final Color? valueColor;

  const PixelProgressIndicator({
    Key? key,
    this.value,
    this.backgroundColor,
    this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = themeManager.currentTheme;
    
    return Container(
      height: 20,
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.borderColor,
          width: 3.0,
        ),
        borderRadius: BorderRadius.circular(0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child: LinearProgressIndicator(
          value: value,
          backgroundColor: backgroundColor ?? theme.tertiaryBackground,
          valueColor: AlwaysStoppedAnimation<Color>(
            valueColor ?? theme.primaryButton,
          ),
        ),
      ),
    );
  }
}