import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/core/model/failure_model.dart';
import 'package:flutter_template/core/services/state/normal_state.dart';
import 'package:flutter_template/core/utils/app_imports.dart';
import 'package:flutter_template/features/auth/data/service/auth_service.dart';
import 'package:flutter_template/features/auth/domain/model/token_model.dart';
import 'package:flutter_template/features/auth/domain/repo/auth_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

@lazySingleton
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginInitial()) {
    on<LoginUserEvent>(_loginUser);
  }

  void _loginUser(LoginUserEvent event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(loginState: const NormalLoadingState<bool>()));
      final response = await getIt<AuthRepo>().loginUser(
        username: event.username,
        password: event.password,
      );

      response.fold((l) {
        if (l["data"] != null) {
          TokenModel tokenModel = TokenModel.fromJson(l["data"]);

          AuthService().storeTokens(tokenModel);

          emit(state.copyWith(
            loginState: const NormalSuccessState(data: true),
          ));
        } else {
          emit(
            state.copyWith(
              loginState: NormalFailureState(
                failure: Failure(message: "Something went wrong"),
              ),
            ),
          );
        }
      }, (r) {
        emit(state.copyWith(loginState: NormalFailureState(failure: r)));
      });
    } catch (e) {
      emit(
        state.copyWith(
          loginState: NormalFailureState(
            failure: Failure(message: "Something went wrong"),
          ),
        ),
      );
      rethrow;
    }
  }
}
