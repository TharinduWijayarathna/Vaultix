import 'package:flutter/material.dart';

class Card extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Border? border;

  const Card({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.boxShadow,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding ?? const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFFFFFFFF),
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        border: border ?? Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1,
        ),
        boxShadow: boxShadow ?? [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: child,
    );
  }
}

class CardHeader extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const CardHeader({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(bottom: 16),
      child: child,
    );
  }
}

class CardTitle extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const CardTitle({
    super.key,
    required this.text,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Color(0xFF0F172A),
        letterSpacing: -0.025,
      ),
    );
  }
}

class CardDescription extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const CardDescription({
    super.key,
    required this.text,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF64748B),
        letterSpacing: -0.025,
        height: 1.5,
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const CardContent({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: child,
    );
  }
}

class CardFooter extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const CardFooter({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(top: 16),
      child: child,
    );
  }
}
