import 'package:flutter/material.dart';
import 'package:notiforyou/constants/eight_bit_theme.dart';

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
    final backgroundColor = widget.backgroundColor ?? 
        (widget.isSecondary ? EightBitTheme.secondaryButton : EightBitTheme.primaryButton);
    final textColor = widget.textColor ?? EightBitTheme.primaryBackground;
    final borderColor = widget.borderColor ?? EightBitTheme.borderColor;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: widget.width,
        height: widget.height ?? 48,
        decoration: EightBitTheme.pixelButtonDecoration(
          backgroundColor: backgroundColor,
          borderColor: borderColor,
          isPressed: _isPressed,
        ),
        child: Center(
          child: Text(
            widget.text,
            style: EightBitTheme.buttonStyle.copyWith(color: textColor),
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
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      enableSuggestions: enableSuggestions,
      autocorrect: autocorrect,
      maxLines: maxLines,
      onChanged: onChanged,
      style: EightBitTheme.bodyStyle,
      decoration: EightBitTheme.pixelInputDecoration(
        hintText: hintText,
        borderColor: borderColor ?? EightBitTheme.borderColor,
        focusedBorderColor: focusedBorderColor ?? EightBitTheme.focusedBorderColor,
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
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: EightBitTheme.pixelCardDecoration(
        backgroundColor: backgroundColor ?? EightBitTheme.cardBackground,
        borderColor: borderColor ?? EightBitTheme.borderColor,
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
    return Container(
      decoration: EightBitTheme.pixelAppBarDecoration(),
      child: AppBar(
        title: Text(
          title,
          style: EightBitTheme.headingStyle,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: actions,
        leading: leading,
        automaticallyImplyLeading: automaticallyImplyLeading,
        iconTheme: const IconThemeData(
          color: EightBitTheme.primaryText,
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: EightBitTheme.pixelCardDecoration(),
      child: ListTile(
        title: title,
        subtitle: subtitle,
        leading: leading,
        trailing: trailing,
        onTap: onTap,
        contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textColor: EightBitTheme.primaryText,
        iconColor: EightBitTheme.secondaryText,
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
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.all(8),
        decoration: _isPressed 
          ? EightBitTheme.pixelButtonDecoration(
              backgroundColor: EightBitTheme.tertiaryBackground,
              isPressed: true,
            )
          : null,
        child: Icon(
          widget.icon,
          color: widget.color ?? EightBitTheme.primaryText,
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
    return Container(
      margin: margin ?? const EdgeInsets.all(8),
      padding: padding ?? const EdgeInsets.all(16),
      decoration: EightBitTheme.pixelCardDecoration(
        backgroundColor: backgroundColor ?? EightBitTheme.cardBackground,
        borderColor: borderColor ?? EightBitTheme.borderColor,
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
    return Container(
      height: 20,
      decoration: BoxDecoration(
        border: Border.all(
          color: EightBitTheme.borderColor,
          width: EightBitTheme.pixelBorderWidth,
        ),
        borderRadius: BorderRadius.circular(EightBitTheme.pixelRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(EightBitTheme.pixelRadius),
        child: LinearProgressIndicator(
          value: value,
          backgroundColor: backgroundColor ?? EightBitTheme.tertiaryBackground,
          valueColor: AlwaysStoppedAnimation<Color>(
            valueColor ?? EightBitTheme.primaryButton,
          ),
        ),
      ),
    );
  }
}