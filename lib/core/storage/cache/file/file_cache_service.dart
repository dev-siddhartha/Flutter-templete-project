import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:injectable/injectable.dart';

@singleton
class FileCacheService {
  final CacheManager _manager;

  FileCacheService() : _manager = DefaultCacheManager();

  Future<File> getFile(String url) {
    return _manager.getSingleFile(url);
  }

  Future<String> cacheFile(String url) async {
    final file =await _manager.getSingleFile(url);
    return file.path;
  }

  Future<void> remove(String url) {
    return _manager.removeFile(url);
  }

  Future<void> clearAll() {
    return _manager.emptyCache();
  }
}