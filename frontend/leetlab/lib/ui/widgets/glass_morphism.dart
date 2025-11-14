import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GlassMorphism extends StatelessWidget {
  const GlassMorphism({
    super.key,
    required this.child,
    this.borderWidth = 3,
    this.blurSigma = 10,
    this.opacity = 1,
    this.borderRadiusOpacity = .3,
    this.borderRadius = 10,
    this.backgoundColor,
    this.borderColor,
  });

  final Widget child;
  final double borderWidth;
  final double blurSigma;
  final double opacity;
  final double borderRadius;
  final double borderRadiusOpacity;
  final Color? backgoundColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final double safeBlur = kIsWeb ? 0 : blurSigma;
    final ThemeData theme = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: safeBlur, sigmaY: safeBlur),
        child: Container(
          decoration: BoxDecoration(
            color:
                backgoundColor?.withOpacity(opacity) ??
                theme.splashColor.withOpacity(opacity),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              width: borderWidth,
              color:
                  borderColor?.withOpacity(borderRadiusOpacity) ??
                  theme.primaryColor.withOpacity(borderRadiusOpacity),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
