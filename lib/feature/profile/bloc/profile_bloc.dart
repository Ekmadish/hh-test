import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/feature/profile/data/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {
      if (event is GetNotificationCountEvent) {
        getnotificationCount();
      }
    });
  }

  final ProfileRepository _repository = ProfileRepository();

  Future<void> getnotificationCount() async {
    log('calll');
    emit(ProfileLoding());

    await _repository.getNotificattionCount().then((count) {
      emit(ProfileSuccess(count));
    }).timeout(
      const Duration(seconds: 20),
      onTimeout: () {
        emit(const ProfileError('Your request timed out. Please retry'));
      },
    ).catchError(onError);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    emit(ProfileError(error.toString()));
    super.onError(error, stackTrace);
  }
}
