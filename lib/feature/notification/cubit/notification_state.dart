part of 'notification_cubit.dart';

@immutable
class NotificationState extends Equatable {
  final String message;
  final bool loading;
  final bool haserror;
  final bool success;
  final bool init;
  final NotificationModel? notificationModel;

  const NotificationState(
      {required this.message,
      required this.loading,
      required this.haserror,
      required this.success,
      required this.init,
      this.notificationModel});
  @override
  List<Object?> get props => [
        message,
        loading,
        haserror,
        success,
        init,
        notificationModel?.data!.length,
        notificationModel?.data,
        notificationModel?.meta?.currentPage,
        notificationModel?.meta?.total,
        notificationModel?.meta?.lastPage,
      ];

  factory NotificationState.init() => const NotificationState(
      message: 'init',
      loading: false,
      haserror: false,
      success: false,
      init: true);

  factory NotificationState.loading() => const NotificationState(
      message: 'loading',
      loading: true,
      haserror: false,
      success: false,
      init: false);

  factory NotificationState.error({required String message}) =>
      NotificationState(
          message: message,
          loading: false,
          haserror: true,
          success: false,
          init: true);

  factory NotificationState.success(NotificationModel n) => NotificationState(
      notificationModel: n,
      message: 'success',
      loading: false,
      haserror: false,
      success: true,
      init: false);
}
