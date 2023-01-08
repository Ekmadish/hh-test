import 'package:test/feature/notification/model/notification_model.dart';
import 'package:test/util/api_heper.dart';

class Repository {
  final HttpController _httpController = HttpController();
  //encapsulation http
  //simplify codeing experience

  Future<NotificationModel> getNotification(int page) async {
    try {
      var map = await _httpController.get('/notifications?page=$page');
      var notificationModel = NotificationModel.fromJson(map);
      return notificationModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> markReadNotification(int id) async {
    try {
      await _httpController.post('/notifications/mark-read', body: {"id": id});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> markAllRead(List<Datum?> id) async {
    try {
      for (var i in id) {
        await _httpController
            .post('/notifications/mark-read', body: {"id": i!.id});
      }
    } catch (e) {
      rethrow;
    }
  }

  void close() {}
  //unnessary part ////////////////////////////////////////
  Future<void> postNotification() async {
    await _httpController.post('/notifications');
  }

  Future<void> unreadNotificationCount() async {
    try {
      await _httpController.get('/notifications/unread-count');
    } catch (e) {
      rethrow;
    }
  }
}
