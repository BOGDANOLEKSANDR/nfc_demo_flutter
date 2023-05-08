import 'package:flutter/material.dart';

enum Shade {
  shade50,
  shade100,
  shade200,
  shade300,
  shade400,
  shade500,
  shade600,
  shade700,
  shade800,
  shade900,
}

extension ColorX on Color {
  Color _applyTone(Shade tone) {
    final hslColor = HSLColor.fromColor(this);
    final lightness = hslColor.lightness;

    const lowDivisor = 6;
    const highDivisor = 5;

    final lowStep = (1.0 - lightness) / lowDivisor;
    final highStep = lightness / highDivisor;

    switch (tone) {
      case Shade.shade50:
        return (hslColor.withLightness(lightness + (lowStep * 5))).toColor();
      case Shade.shade100:
        return (hslColor.withLightness(lightness + (lowStep * 4))).toColor();
      case Shade.shade200:
        return (hslColor.withLightness(lightness + (lowStep * 3))).toColor();
      case Shade.shade300:
        return (hslColor.withLightness(lightness + (lowStep * 2))).toColor();
      case Shade.shade400:
        return (hslColor.withLightness(lightness + lowStep)).toColor();
      case Shade.shade500:
        return (hslColor.withLightness(lightness)).toColor();
      case Shade.shade600:
        return (hslColor.withLightness(lightness - highStep)).toColor();
      case Shade.shade700:
        return (hslColor.withLightness(lightness - (highStep * 2))).toColor();
      case Shade.shade800:
        return (hslColor.withLightness(lightness - (highStep * 3))).toColor();
      case Shade.shade900:
        return (hslColor.withLightness(lightness - (highStep * 4))).toColor();
    }
  }

  Color get shade50 => _applyTone(Shade.shade50);

  Color get shade100 => _applyTone(Shade.shade100);

  Color get shade200 => _applyTone(Shade.shade200);

  Color get shade300 => _applyTone(Shade.shade300);

  Color get shade400 => _applyTone(Shade.shade400);

  Color get shade500 => _applyTone(Shade.shade500);

  Color get shade600 => _applyTone(Shade.shade600);

  Color get shade700 => _applyTone(Shade.shade700);

  Color get shade800 => _applyTone(Shade.shade800);

  Color get shade900 => _applyTone(Shade.shade900);
}
