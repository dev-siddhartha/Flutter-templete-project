import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

class AppLogger {
  /// Logs a debug message.
  static void debug(String message, {Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      developer.log(
        message,
        name: 'AppLogger',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// Logs an info message.
  static void info(String message) {
    if (kDebugMode) {
      developer.log(message, name: 'AppLogger');
    }
    if (kReleaseMode) {
      /// send data to analytics
    }
  }

  /// Logs a warning message.
  static void warning(String message, {Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      developer.log(
        message,
        name: 'AppLogger',
        level: 900, // Warning level
        error: error,
        stackTrace: stackTrace,
      );
    }
    if (kReleaseMode && error != null) {
      /// send data to crashlytics
    }
  }

  /// Logs an error message.
  static void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    bool fatal = false,
  }) {
    if (kDebugMode) {
      developer.log(
        message,
        name: 'AppLogger',
        level: 1000, // Error level
        error: error,
        stackTrace: stackTrace,
      );
    }

    if (kReleaseMode) {
      if (error != null && stackTrace != null) {
        // do something
      } else {
        // do someething
      }
    }
  }

  /// Logs an error with context information.
  static void errorWithContext(
    String message, {
    required String context,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? additionalData,
    bool fatal = false,
  }) {
    final fullMessage = '[$context] $message';

    if (kDebugMode) {
      developer.log(
        fullMessage,
        name: 'AppLogger',
        level: 1000,
        error: error,
        stackTrace: stackTrace,
      );

      if (additionalData != null) {
        developer.log(
          'Additional data: $additionalData',
          name: 'AppLogger',
        );
      }
    }

    if (kReleaseMode) {
      if (error != null && stackTrace != null) {
        // FirebaseCrashlytics.instance.recordError(
        //   error,
        //   stackTrace,
        //   fatal: fatal,
        //   reason: fullMessage,
        // );
      } else {
        // FirebaseCrashlytics.instance.log('Error: $fullMessage');
      }
    }
  }
}
