import 'dart:convert';
import 'dart:io';

void main() {
  final source = File('tokens/slds_alpha.tokens.json');
  if (!source.existsSync()) {
    stderr.writeln('Missing tokens/slds_alpha.tokens.json');
    exitCode = 1;
    return;
  }

  final decoded = jsonDecode(source.readAsStringSync()) as Map<String, Object?>;
  final version = decoded['version'];
  stdout.writeln('SLDS token source loaded: $version');
  stdout.writeln(
    'This script does not generate code. tokens/slds_alpha.tokens.json is a '
    'point-in-time design reference exported from Figma; it is not read at '
    'runtime and is not kept in sync automatically. '
    'lib/src/tokens/slds_tokens.dart is the single authoritative, live '
    'source consumed by every component. When you change a value in '
    'slds_tokens.dart, either update this JSON to match by hand or accept '
    'that it will drift and should not be trusted as current.',
  );
}
