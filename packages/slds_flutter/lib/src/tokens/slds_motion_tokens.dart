/// SLDS motion tokens.
class SldsMotionTokens {
  const SldsMotionTokens({required this.reducedMotion});

  final bool reducedMotion;

  Duration get instant => Duration.zero;

  Duration get fast =>
      reducedMotion ? Duration.zero : const Duration(milliseconds: 100);

  Duration get normal =>
      reducedMotion ? Duration.zero : const Duration(milliseconds: 200);

  Duration get moderate =>
      reducedMotion ? Duration.zero : const Duration(milliseconds: 300);

  Duration get slow =>
      reducedMotion ? Duration.zero : const Duration(milliseconds: 400);

  Duration get enter =>
      reducedMotion ? Duration.zero : const Duration(milliseconds: 250);

  Duration get exit =>
      reducedMotion ? Duration.zero : const Duration(milliseconds: 200);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SldsMotionTokens && other.reducedMotion == reducedMotion;
  }

  @override
  int get hashCode => Object.hashAll([reducedMotion]);
}
