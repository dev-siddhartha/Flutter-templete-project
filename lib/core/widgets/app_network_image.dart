import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_template/core/utils/app_imports.dart';

/// Cached network image with sensible default loading/error states.
///
/// Use this instead of a raw [Image.network] anywhere in the app so remote
/// images are disk/memory cached and get consistent placeholder/error UI.
class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final colors = context.slds.colors;

    Widget image = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => _StateContainer(
        width: width,
        height: height,
        color: colors.surfaceCard,
        child: Center(
          child: SizedBox(
            width: 20.w,
            height: 20.w,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: colors.buttonPrimaryBackground,
            ),
          ),
        ),
      ),
      errorWidget: (context, url, error) => _StateContainer(
        width: width,
        height: height,
        color: colors.surfaceCard,
        child: Icon(Icons.broken_image_outlined, color: colors.textSecondary),
      ),
    );

    if (borderRadius != null) {
      image = ClipRRect(borderRadius: borderRadius!, child: image);
    }

    return image;
  }
}

class _StateContainer extends StatelessWidget {
  const _StateContainer({
    required this.width,
    required this.height,
    required this.color,
    required this.child,
  });

  final double? width;
  final double? height;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: color,
      child: child,
    );
  }
}
