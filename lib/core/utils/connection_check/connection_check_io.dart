import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> hasInternetConnection() async {
  try {
    final connection = await Connectivity().checkConnectivity();
    final working = await InternetAddress.lookup('google.com')
        .timeout(const Duration(seconds: 2));
    return (connection.any((e) => e != ConnectivityResult.none)) &&
        working.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}
