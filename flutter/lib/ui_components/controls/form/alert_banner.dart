import 'package:flutter/material.dart';

/// Alert banner variant.
enum BannerVariant { urgent, warning, success, info }

/// Alert banner widget.
class AlertBannerWidget extends StatelessWidget {
  final BannerVariant variant;
  final List<String> messages;
  final VoidCallback? onDismiss;

  const AlertBannerWidget({
    super.key,
    this.variant = BannerVariant.info,
    this.messages = const [],
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(_icon, color: _iconColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: messages.map((message) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    message,
                    style: TextStyle(color: _textColor),
                  ),
                );
              }).toList(),
            ),
          ),
          if (onDismiss != null)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: onDismiss,
              color: _iconColor,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
        ],
      ),
    );
  }

  Color get _backgroundColor {
    switch (variant) {
      case BannerVariant.urgent:
        return const Color(0xFFFEE2E2);
      case BannerVariant.warning:
        return const Color(0xFFFEF3C7);
      case BannerVariant.success:
        return const Color(0xFFD1FAE5);
      case BannerVariant.info:
        return const Color(0xFFDBEAFE);
    }
  }

  Color get _borderColor {
    switch (variant) {
      case BannerVariant.urgent:
        return const Color(0xFFEF4444);
      case BannerVariant.warning:
        return const Color(0xFFF59E0B);
      case BannerVariant.success:
        return const Color(0xFF10B981);
      case BannerVariant.info:
        return const Color(0xFF3B82F6);
    }
  }

  Color get _iconColor => _borderColor;

  Color get _textColor {
    switch (variant) {
      case BannerVariant.urgent:
        return const Color(0xFF991B1B);
      case BannerVariant.warning:
        return const Color(0xFF92400E);
      case BannerVariant.success:
        return const Color(0xFF065F46);
      case BannerVariant.info:
        return const Color(0xFF1E40AF);
    }
  }

  IconData get _icon {
    switch (variant) {
      case BannerVariant.urgent:
        return Icons.error;
      case BannerVariant.warning:
        return Icons.warning;
      case BannerVariant.success:
        return Icons.check_circle;
      case BannerVariant.info:
        return Icons.info;
    }
  }
}
