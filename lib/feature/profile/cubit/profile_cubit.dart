import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/feature/profile/data/profile_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileStateCubit> {
  ProfileCubit() : super(ProfileStateCubit.init()) {
    getNotificationCount();
  }

  final ProfileRepository _repository = ProfileRepository();

  Future<void> getNotificationCount() async {
    if (state.count == null) emit(ProfileStateCubit.loading());
    await _repository.getNotificattionCount().then((c) {
      emit(ProfileStateCubit.success(c));
    }).timeout(
      const Duration(seconds: 20),
      onTimeout: () {
        emit(ProfileStateCubit.error(
            message: 'Your request timed out. Please retry'));
      },
    ).catchError(onError);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    emit(ProfileStateCubit.error(message: error.toString()));
    super.onError(error, stackTrace);
  }
}
