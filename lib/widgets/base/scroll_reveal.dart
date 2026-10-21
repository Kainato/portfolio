import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Revela o conteúdo com um fade e um leve deslocamento quando entra no viewport.
class ScrollReveal extends StatefulWidget {
  const ScrollReveal({super.key, required this.child});

  final Widget child;

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal> {
  ScrollPosition? _position;
  bool _isVisible = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final nextPosition = Scrollable.of(context).position;
    if (_position == nextPosition) return;

    _position?.removeListener(_checkVisibility);
    _position = nextPosition..addListener(_checkVisibility);
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
  }

  void _checkVisibility() {
    if (_isVisible || !mounted) return;
    final renderObject = context.findRenderObject();
    final position = _position;
    if (renderObject == null ||
        position == null ||
        !position.hasContentDimensions) {
      return;
    }

    final viewport = RenderAbstractViewport.maybeOf(renderObject);
    if (viewport == null) return;

    final leading = viewport.getOffsetToReveal(renderObject, 0).offset;
    final trailing = viewport.getOffsetToReveal(renderObject, 1).offset;
    final viewportStart = position.pixels;
    final isInViewport =
        leading < viewportStart + position.viewportDimension * 0.88 &&
        trailing + position.viewportDimension >
            viewportStart + position.viewportDimension * 0.12;

    if (isInViewport) {
      setState(() => _isVisible = true);
      position.removeListener(_checkVisibility);
    }
  }

  @override
  void dispose() {
    _position?.removeListener(_checkVisibility);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedSlide(
    offset: _isVisible ? Offset.zero : const Offset(0, 0.08),
    duration: const Duration(milliseconds: 650),
    curve: Curves.easeOutCubic,
    child: AnimatedOpacity(
      opacity: _isVisible ? 1 : 0,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeOutCubic,
      child: widget.child,
    ),
  );
}
