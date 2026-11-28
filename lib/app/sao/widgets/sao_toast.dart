import 'package:flutter/material.dart';

import '../sao_theme.dart';

/// Notificação exibida no canto superior direito ("Missão aberta", "Skill equipada"...).
class SaoToast {
  const SaoToast(this.id, this.title, this.message);

  final int id;
  final String title;
  final String message;
}

/// Controla a fila de notificações. Cada uma some sozinha após 2,6 segundos.
class SaoToastController extends ChangeNotifier {
  final List<SaoToast> _items = [];
  int _nextId = 0;
  bool _disposed = false;

  List<SaoToast> get items => List.unmodifiable(_items);

  void show(String title, String message) {
    final toast = SaoToast(_nextId++, title, message);
    _items.add(toast);
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 2600), () {
      if (_disposed) return;
      _items.remove(toast);
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}

/// Pilha visual das notificações ativas.
class SaoToastHost extends StatelessWidget {
  const SaoToastHost({super.key, required this.controller});

  final SaoToastController controller;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final toast in controller.items)
            _ToastTile(key: ValueKey(toast.id), toast: toast),
        ],
      ),
    );
  }
}

class _ToastTile extends StatelessWidget {
  const _ToastTile({super.key, required this.toast});

  final SaoToast toast;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: reduceMotion
          ? Duration.zero
          : const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
      builder: (context, t, child) => Opacity(
        opacity: t,
        child: Transform.translate(
          offset: Offset(30 * (1 - t), 0),
          child: child,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: const Border(
            left: BorderSide(color: SaoColors.orange, width: 4),
          ),
          boxShadow: [
            BoxShadow(
              color: SaoColors.ink.withValues(alpha: 0.14),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(toast.title, style: SaoText.display.copyWith(fontSize: 13)),
            const SizedBox(width: 10),
            Text(toast.message, style: SaoText.body.copyWith(fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
