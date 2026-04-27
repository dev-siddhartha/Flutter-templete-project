part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState({
    this.detailState = const NormalInitialState(),
  });

  final NormalState<ProfileModel> detailState;

  @override
  List<Object> get props => [
        detailState,
      ];

  ProfileState copyWith({
    NormalState<ProfileModel>? detailState,
  });
}

final class ProfileStateImpl extends ProfileState {
  const ProfileStateImpl({
    super.detailState,
  });

  @override
  ProfileState copyWith({
    NormalState<ProfileModel>? detailState,
  }) {
    return ProfileStateImpl(
      detailState: detailState ?? this.detailState,
    );
  }
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial({
    super.detailState = const NormalInitialState(),
  });

  @override
  ProfileState copyWith({
    NormalState<ProfileModel>? detailState,
  }) {
    return ProfileInitial(
      detailState: detailState ?? this.detailState,
    );
  }
}
