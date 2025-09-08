import 'package:flutter/material.dart';

enum BadgeVariant {
  default_,
  secondary,
  destructive,
  outline,
}

class Badge extends StatelessWidget {
  final Widget child;
  final BadgeVariant variant;
  final EdgeInsetsGeometry? padding;

  const Badge({
    super.key,
    required this.child,
    this.variant = BadgeVariant.default_,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(6),
        border: _getBorder(),
      ),
      child: DefaultTextStyle(
        style: _getTextStyle(),
        child: child,
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (variant) {
      case BadgeVariant.default_:
        return const Color(0xFF0F172A);
      case BadgeVariant.secondary:
        return const Color(0xFFF1F5F9);
      case BadgeVariant.destructive:
        return const Color(0xFFEF4444);
      case BadgeVariant.outline:
        return Colors.transparent;
    }
  }

  Border? _getBorder() {
    switch (variant) {
      case BadgeVariant.outline:
        return Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1,
        );
      case BadgeVariant.default_:
      case BadgeVariant.secondary:
      case BadgeVariant.destructive:
        return null;
    }
  }

  TextStyle _getTextStyle() {
    switch (variant) {
      case BadgeVariant.default_:
        return const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color(0xFFFFFFFF),
          letterSpacing: -0.025,
        );
      case BadgeVariant.secondary:
        return const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color(0xFF0F172A),
          letterSpacing: -0.025,
        );
      case BadgeVariant.destructive:
        return const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color(0xFFFFFFFF),
          letterSpacing: -0.025,
        );
      case BadgeVariant.outline:
        return const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color(0xFF0F172A),
          letterSpacing: -0.025,
        );
    }
  }
}
