part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final int count;

  const ProfileSuccess(this.count);
}

class ProfileLoding extends ProfileState {}

class ProfileError extends ProfileState {
  final String? message;
  const ProfileError(this.message);
}
