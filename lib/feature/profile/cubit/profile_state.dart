part of 'profile_cubit.dart';

@immutable
class ProfileStateCubit extends Equatable {
  final String message;
  final bool loading;
  final bool haserror;
  final bool success;
  final bool init;
  final int? count;

  const ProfileStateCubit(
      {required this.message,
      required this.loading,
      required this.haserror,
      required this.success,
      required this.init,
      this.count});

  @override
  List<Object> get props =>
      [message, loading, haserror, success, init, count ?? 'nil'];

  factory ProfileStateCubit.init() => const ProfileStateCubit(
      message: 'init',
      loading: false,
      haserror: false,
      success: false,
      init: true);

  factory ProfileStateCubit.loading() => const ProfileStateCubit(
      message: 'loading',
      loading: true,
      haserror: false,
      success: false,
      init: false);

  factory ProfileStateCubit.error({required String message}) =>
      ProfileStateCubit(
          message: message,
          loading: false,
          haserror: true,
          success: false,
          init: true);

  factory ProfileStateCubit.success(int c) => ProfileStateCubit(
      count: c,
      message: 'success',
      loading: false,
      haserror: false,
      success: true,
      init: false);
}
