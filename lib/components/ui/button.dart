import 'package:flutter/material.dart';

enum ButtonVariant {
  default_,
  destructive,
  outline,
  secondary,
  ghost,
  link,
}

enum ButtonSize {
  default_,
  sm,
  lg,
  icon,
}

class Button extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool isLoading;
  final bool isFullWidth;

  const Button({
    super.key,
    required this.child,
    this.onPressed,
    this.variant = ButtonVariant.default_,
    this.size = ButtonSize.default_,
    this.isLoading = false,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: _getHeight(),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: _getButtonStyle(),
        child: isLoading
            ? SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getTextColor(),
                  ),
                ),
              )
            : child,
      ),
    );
  }

  double _getHeight() {
    switch (size) {
      case ButtonSize.sm:
        return 36;
      case ButtonSize.lg:
        return 44;
      case ButtonSize.icon:
        return 40;
      case ButtonSize.default_:
      default:
        return 40;
    }
  }

  ButtonStyle _getButtonStyle() {
    final backgroundColor = _getBackgroundColor();
    final foregroundColor = _getTextColor();
    final side = _getBorderSide();

    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      side: side,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: _getPadding(),
      textStyle: _getTextStyle(),
    );
  }

  Color _getBackgroundColor() {
    switch (variant) {
      case ButtonVariant.default_:
        return const Color(0xFF0F172A);
      case ButtonVariant.destructive:
        return const Color(0xFFEF4444);
      case ButtonVariant.outline:
        return Colors.transparent;
      case ButtonVariant.secondary:
        return const Color(0xFFF1F5F9);
      case ButtonVariant.ghost:
        return Colors.transparent;
      case ButtonVariant.link:
        return Colors.transparent;
    }
  }

  Color _getTextColor() {
    switch (variant) {
      case ButtonVariant.default_:
        return const Color(0xFFFFFFFF);
      case ButtonVariant.destructive:
        return const Color(0xFFFFFFFF);
      case ButtonVariant.outline:
        return const Color(0xFF0F172A);
      case ButtonVariant.secondary:
        return const Color(0xFF0F172A);
      case ButtonVariant.ghost:
        return const Color(0xFF0F172A);
      case ButtonVariant.link:
        return const Color(0xFF0F172A);
    }
  }

  BorderSide? _getBorderSide() {
    switch (variant) {
      case ButtonVariant.outline:
        return const BorderSide(
          color: Color(0xFFE2E8F0),
          width: 1,
        );
      case ButtonVariant.default_:
      case ButtonVariant.destructive:
      case ButtonVariant.secondary:
      case ButtonVariant.ghost:
      case ButtonVariant.link:
        return null;
    }
  }

  EdgeInsetsGeometry _getPadding() {
    switch (size) {
      case ButtonSize.sm:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case ButtonSize.lg:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 12);
      case ButtonSize.icon:
        return const EdgeInsets.all(8);
      case ButtonSize.default_:
      default:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 10);
    }
  }

  TextStyle _getTextStyle() {
    switch (size) {
      case ButtonSize.sm:
        return const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: -0.025,
        );
      case ButtonSize.lg:
        return const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: -0.025,
        );
      case ButtonSize.icon:
        return const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: -0.025,
        );
      case ButtonSize.default_:
      default:
        return const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: -0.025,
        );
    }
  }
}
