class FileCacheConfig {
  final List<FileField> fields;

  const FileCacheConfig(this.fields);
}

class FileField {
  /// Key provided by api
  final String key; // api key
  /// Key to store local path of cache [map key with the model]
  final String localKey; // where to store local path

  const FileField({
    required this.key,
    required this.localKey,
  });
}
