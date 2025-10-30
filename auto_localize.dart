import 'dart:convert';
import 'dart:developer';
import 'dart:io';

const l10nPath = 'lib/l10n';
const dartDir = 'lib/features';
final arbFiles = [
  '$l10nPath/app_en.arb',
  '$l10nPath/app_ne.arb',
  '$l10nPath/app_ar.arb',
];

/// To generate text in arb files
/// Run code: dart auto_localize.dart
/// To generate localization: flutter pub get
Future<void> main() async {
  // Load arb files into memory
  final arbData = await _loadArbFiles();

  final dartFiles = await _getAllDartFiles(Directory(dartDir));

  for (final file in dartFiles) {
    var content = await file.readAsString();

    // Skip files that don’t contain autoLocalize at all
    if (!content.contains('autoLocalize(')) continue;

    var modified = false;

    /// Regex to match:
    /// localize('some string')
    /// OR
    /// localize('some string', key: 'string')
    final regex = RegExp(
        r"""autoLocalize\s*\(\s*(['"])(.+?)\1(?:\s*,\s*key\s*:\s*(['"])(\w+)\3)?\s*\)""");
    final matches = regex.allMatches(content).toList();

    for (final match in matches.reversed) {
      final rawText = match.group(2)!;
      final customKey = match.group(4);
      final key = customKey ?? _toKey(rawText);

      // Extract placeholders like {name}, {count}, etc.
      final placeholderRegex = RegExp(r'\{(\w+)\}');
      final placeholders = <String, dynamic>{};

      for (final phMatch in placeholderRegex.allMatches(rawText)) {
        final phName = phMatch.group(1)!;
        placeholders[phName] = {};
      }

      for (final lang in arbData.keys) {
        arbData[lang]![key] = rawText;

        final metadata = <String, dynamic>{
          'description': rawText,
          if (placeholders.isNotEmpty) 'placeholders': placeholders,
        };

        arbData[lang]!['@$key'] = metadata;
        log('Set "$key" in $lang.arb with value and metadata');
      }

      final replacement = "l10(context).$key";
      content = content.replaceRange(match.start, match.end, replacement);
      modified = true;
    }

    if (modified) {
      await file.writeAsString(content);
      log('Updated Dart file: ${file.path}');
    }
  }

  // Write updated arb files back to disk
  await _writeArbFiles(arbData);
  log('Localization update complete.');
}

Future<List<File>> _getAllDartFiles(Directory dir) async {
  final root = Directory.current.absolute.path;
  final files = <File>[];

  await for (var entity in dir.list(recursive: true, followLinks: false)) {
    if (entity is! File || !entity.path.endsWith('.dart')) continue;

    final path = entity.absolute.path;

    // Exclude anything not in the project folder
    if (!path.startsWith(root)) continue;

    if ([
      '/l10n/',
      '.pub-cache',
      '/.dart_tool/',
      '/packages/',
      '/build/',
      '.g.dart',
      '.freezed.dart',
      '/.idea/',
      '/.vscode/',
      '/flutter/',
      '/sdk/',
    ].any((ex) => path.contains(ex))) {
      continue;
    }

    files.add(entity);
  }

  log('✅ Found ${files.length} valid Dart files');
  return files;
}

Future<Map<String, Map<String, dynamic>>> _loadArbFiles() async {
  final Map<String, Map<String, dynamic>> result = {};
  for (final path in arbFiles) {
    final file = File(path);
    if (!await file.exists()) {
      stderr.writeln('Error: ARB file not found: $path');
      exit(1);
    }
    final content = await file.readAsString();
    final jsonContent = jsonDecode(content) as Map<String, dynamic>;
    // Extract language code from filename: app_en.arb -> en
    final langCode = RegExp(r'app_(\w+)\.arb').firstMatch(path)!.group(1)!;
    result[langCode] = jsonContent;
  }
  return result;
}

Future<void> _writeArbFiles(Map<String, Map<String, dynamic>> arbData) async {
  for (final langEntry in arbData.entries) {
    final langCode = langEntry.key;
    final data = langEntry.value;
    final filePath = '$l10nPath/app_$langCode.arb';
    final file = File(filePath);

    const encoder = JsonEncoder.withIndent('  ');
    final jsonString = encoder.convert(data);
    await file.writeAsString(jsonString);
  }
}

String _toKey(String text) {
  // Convert "Welcome to App!" -> "welcome_to_app"
  // Ensure only valid Dart identifier characters: letters, digits, and underscores, and not starting with digit
  var key = text
      .toLowerCase()
      .replaceAll(RegExp(r'[^\w\s]'), '') // Remove punctuation
      .replaceAll(RegExp(r'\s+'), '_') // Replace spaces with underscores
      .trim();

  // Remove leading characters until we get a letter or underscore
  key = key.replaceFirst(RegExp(r'^[^a-zA-Z_]+'), '');

  // If empty or starts with digit, prefix with underscore
  if (key.isEmpty || RegExp(r'^\d').hasMatch(key)) {
    key = '_$key';
  }

  return key;
}
