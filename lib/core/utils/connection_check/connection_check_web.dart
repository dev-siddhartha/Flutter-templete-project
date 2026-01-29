import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> hasInternetConnection() async {
  final connection = await Connectivity().checkConnectivity();
  return connection.any((e) => e != ConnectivityResult.none);
}
