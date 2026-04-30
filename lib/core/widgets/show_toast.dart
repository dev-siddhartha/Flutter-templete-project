import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:flutter_template/core/utils/app_imports.dart';

enum ToastGravity { top, center, bottom }

enum ToastType { success, info, error }

class AppToast {
  static _ToastEntry? _active;

  static void showToast(
    String message, {
    int duration = 3,
    ToastGravity gravity = ToastGravity.bottom,
    ToastType toastType = ToastType.info,
  }) {
    final overlay = getIt<NavigationService>().rootNavigatorKey.currentState?.overlay;
    if (overlay == null) return;

    _active?.dismiss(animate: true);

    final entry = _ToastEntry(
        message: message,
        overlay: overlay,
        duration: duration,
        position: gravity,
        toastType: toastType);

    _active = entry;
    entry.insert();
  }
}

class _ToastEntry extends TickerProvider {
  _ToastEntry(
      {required this.message,
      required this.overlay,
      required this.duration,
      required this.position,
      required this.toastType});

  final String message;
  final OverlayState overlay;
  final int duration;
  final ToastGravity position;
  final ToastType toastType;

  late final AnimationController _controller;
  late final Animation<Offset> _slide;
  late final Animation<double> _fade;
  late final OverlayEntry _overlayEntry;

  Timer? _dismissTimer;
  bool _disposed = false;

  final Set<Ticker> _tickers = {};
  List<Color> colors(ToastType toastType) {
    switch (toastType) {
      case ToastType.success:
        return [
          AppColors.primary[200],
          AppColors.primary[200],
          AppColors.grey[50],
          AppColors.whiteColor,
        ];
      case ToastType.info:
        return [
          AppColors.info[200],
          AppColors.info[200],
          AppColors.grey[50],
          AppColors.whiteColor,
        ];
      case ToastType.error:
        return [
          AppColors.error[200],
          AppColors.error[200],
          AppColors.grey[50],
          AppColors.whiteColor,
        ];
    }
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    final ticker = Ticker(onTick);
    _tickers.add(ticker);
    return ticker;
  }

  void insert() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 250),
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _fade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _overlayEntry = OverlayEntry(builder: _build);
    overlay.insert(_overlayEntry);

    _controller.forward();

    _dismissTimer = Timer(Duration(seconds: duration), () {
      dismiss(animate: true);
      if (AppToast._active == this) {
        AppToast._active = null;
      }
    });
  }

  Future<void> dismiss({bool animate = true}) async {
    if (_disposed) return;

    _dismissTimer?.cancel();
    _dismissTimer = null;

    if (animate && _controller.status != AnimationStatus.dismissed) {
      await _controller.reverse();
    }

    _overlayEntry.remove();
    _dispose();
  }

  void _dispose() {
    if (_disposed) return;
    _disposed = true;

    for (final t in _tickers) {
      t.dispose();
    }

    _controller.dispose();
  }

  Widget _build(BuildContext context) {
    final media = MediaQuery.of(context);

    double? top;
    double? bottom;

    Widget child = SlideTransition(
      position: _slide,
      child: FadeTransition(
        opacity: _fade,
        child: Material(
          color: Colors.transparent,
          child: _toastUI(context),
        ),
      ),
    );

    switch (position) {
      case ToastGravity.top:
        top = media.padding.top + 20.h;
        break;

      case ToastGravity.center:
        return Center(child: child);

      case ToastGravity.bottom:
        bottom = media.padding.bottom + 20.h;
        break;
    }

    return Positioned(
      top: top,
      bottom: bottom,
      left: 12.w,
      right: 12.w,
      child: child,
    );
  }

  Widget _toastUI(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: 50.h, maxHeight: 120.h),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          colors: colors(toastType),
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey[900].withValues(alpha: 0.2),
            blurRadius: 12.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded,
              color: Theme.of(context).primaryColor),
          10.horizontalSpace,
          Expanded(
            child: TextWidget(
              message,
              textType: TextType.bodyLarge,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              color: AppColors.lightTextPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
