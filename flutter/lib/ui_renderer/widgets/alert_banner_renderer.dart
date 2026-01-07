import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/widgets/alert_banner.dart';
import '../../ui_components/controls/form/alert_banner.dart';

/// Renderer for AlertBanner component.
class AlertBannerRenderer implements ComponentRenderer<AlertBannerComponent> {
  @override
  Widget render(AlertBannerComponent component) {
    return ListenableBuilder(
      listenable: component,
      builder: (context, _) {
        return AlertBannerWidget(
          variant: _mapVariant(component.variant),
          messages: component.messages,
        );
      },
    );
  }

  BannerVariant _mapVariant(AlertBannerVariant variant) {
    switch (variant) {
      case AlertBannerVariant.urgent:
        return BannerVariant.urgent;
      case AlertBannerVariant.warning:
        return BannerVariant.warning;
      case AlertBannerVariant.success:
        return BannerVariant.success;
      case AlertBannerVariant.info:
        return BannerVariant.info;
    }
  }
}
