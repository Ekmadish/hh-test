import 'package:test/util/api_heper.dart';

class ProfileRepository {
  final HttpController _httpController = HttpController();

  Future<int> getNotificattionCount() async {
    try {
      var map = await _httpController.get('/notifications/unread-count');
      return map['count'];
    } catch (e) {
      rethrow;
    }
  }
}
