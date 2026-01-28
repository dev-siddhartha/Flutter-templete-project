import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/core/services/state/normal_state.dart';
import 'package:flutter_template/core/utils/app_imports.dart';
import 'package:flutter_template/core/utils/localization/localization_service.dart';
import 'package:flutter_template/core/widgets/buttons/input_button.dart';
import 'package:flutter_template/core/widgets/show_toast.dart';
import 'package:flutter_template/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:flutter_template/features/auth/presentation/bloc/login_bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController usernameController =
      TextEditingController(text: "emilys");
  final TextEditingController passwordController = TextEditingController(
    text: "emilyspass",
  );

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void login() {
    if (formKey.currentState!.validate()) {
      getIt<LoginBloc>().add(LoginUserEvent(
        username: usernameController.text,
        password: passwordController.text,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenPadding(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextWidget(
                l10(context).login,
                textType: TextType.heading,
              ),
              50.verticalSpace,
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: "Username",
                  hintText: "Enter your username",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Username is required";
                  }
                  return null;
                },
              ),
              20.verticalSpace,
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: "Password",
                  hintText: "Enter your password",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is required";
                  }
                  return null;
                },
              ),
              20.verticalSpace,
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state.loginState is NormalSuccessState) {
                    getIt<AuthCubit>().login(state.loginState.data ?? false);
                  } else if (state.loginState is NormalFailureState) {
                    showToast(
                        state.loginState.failure?.message ??
                            "Something went wrong",
                        toastType: ToastType.error);
                  }
                },
                builder: (context, state) {
                  return InputButton(
                    onPressed: login,
                    buttonText: "Login",
                    isLoading: state.loginState is NormalLoadingState,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
