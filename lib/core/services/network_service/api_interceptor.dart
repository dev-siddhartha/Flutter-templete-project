import 'package:flutter_template/core/constants/api_constants.dart';
import 'package:flutter_template/core/initial_app_mixin.dart';
import 'package:flutter_template/core/services/network_service/network_service.dart';
import 'package:flutter_template/core/utils/app_imports.dart';
import 'package:flutter_template/core/widgets/show_toast.dart';
import 'package:flutter_template/features/auth/data/service/auth_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TokenInterceptor extends Interceptor {
  final AuthService _authService = AuthService();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Make async call to get token
    final token = await _authService.getAccessToken();
    if (token.isNotEmpty && !options.path.contains('oauth2/token')) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final data = err.response?.data;

    if (data is Map &&
        data['error'] is Map &&
        data['error']['errorType'] == ApiConstants.unauthorized) {
      _handleSessionTimeout();
      return;
    }

    return handler.next(err);
  }

  void _handleSessionTimeout() {
    getIt<InitialAppMixin>().logout();
    showToast(
      "Session Timed Out",
      toastType: ToastType.info,
      gravity: ToastGravity.TOP,
    );
  }
}
