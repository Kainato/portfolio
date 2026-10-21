import 'package:flutter/material.dart';

/// Adiciona um atalho para envolver um widget de texto com padding.
extension TextExtension on Text {
  Padding padding(EdgeInsetsGeometry value) {
    return Padding(
      padding: value,
      child: this,
    );
  }
}
