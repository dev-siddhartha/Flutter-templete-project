import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/core/model/failure_model.dart';
import 'package:flutter_template/core/services/api_service/api_service.dart';
import 'package:flutter_template/core/services/state/normal_state.dart';
import 'package:flutter_template/core/utils/app_imports.dart';
import 'package:flutter_template/features/auth/domain/repo/auth_repo.dart';
import 'package:flutter_template/features/profile/domain/model/profile_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

@lazySingleton
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileInitial()) {
    on<GetProfileEvent>(_onGetProfileEvent);
  }

  void _onGetProfileEvent(
      GetProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(state.copyWith(detailState: const NormalLoadingState()));

      final response = await ApiService.fetchNormalData(
          apiCall: () => getIt<AuthRepo>().getProfile(),
          fromJson: ProfileModel.fromJson);

      emit(state.copyWith(detailState: response));
    } catch (e) {
      emit(state.copyWith(
          detailState: NormalFailureState(
              failure: Failure(message: "Something went wrong"))));
    }
  }
}
