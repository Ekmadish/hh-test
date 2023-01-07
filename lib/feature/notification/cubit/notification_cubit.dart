import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/feature/notification/data/repository.dart';
import 'package:test/feature/notification/model/notification_model.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationState.init()) {
    // when initialize this bloc gets data from the server
    // this step also can be done by the pure bloc in my case for less code , simple ...i used cubit...
    getNotification();
  }

  final Repository _repository = Repository(); //the data layer
  final ScrollController _controller =
      ScrollController(); // for animate scroll view
  ScrollController get controller => _controller;

  int _page = 1;
  bool _hasNextPage = true;
  bool _isLoadMoreRunning = false;
  bool get hasNextPage => _hasNextPage;
//for pagination
  void loadMore() async {
    if (_hasNextPage && !_isLoadMoreRunning) {
      _isLoadMoreRunning = true;
      _page = _page + 1;
      _getNotification(true);
    }
  }

  Future<void> getNotification({int? page}) async {
    await _getNotification(state.notificationModel != null, page: page);
  }

  Future<void> _getNotification(bool fromMore, {int? page}) async {
    if (state.notificationModel == null) emit(NotificationState.loading());
    await _repository.getNotification(page ?? _page).then((n) {
      if (fromMore) {
        _isLoadMoreRunning = false;
        _hasNextPage = n.meta!.currentPage! < n.meta!.lastPage!;
        var copyWith = state.notificationModel!
            .copyWith(data: n.data, meta: n.meta, links: n.links);
        emit(NotificationState.success(copyWith));
      } else {
        emit(NotificationState.success(n));
      }
    }).timeout(const Duration(seconds: 20), onTimeout: () {
      emit(NotificationState.error(
          message: 'Your request timed out. Please retry'));
    }).catchError(onError);
  }

  Future<void> markReadNotification(int id) async {
    await _repository.markReadNotification(id);
    _getNotification(false, page: 1).then((value) {
      if (controller.hasClients) {
        controller.animateTo(controller.position.minScrollExtent,
            duration: kTabScrollDuration, curve: Curves.ease);
      }
    });
  }

  Future<void> markAllRead() async {
    var list = state.notificationModel!.data!
        .where((element) => element!.isRead == false)
        .toList();
    if (list.isNotEmpty) {
      await _repository.markAllRead(list);
      _getNotification(false, page: 1).then((value) {
        if (controller.hasClients) {
          controller.animateTo(controller.position.minScrollExtent,
              duration: kTabScrollDuration, curve: Curves.ease);
        }
      });
    }
  }

  Future<void> postNotification() async {
    await _repository.postNotification();
  }

//catch all the blco error then emit etc...
  @override
  void onError(Object error, StackTrace stackTrace) {
    emit(NotificationState.error(message: error.toString()));
    super.onError(error, stackTrace);
  }

  @override
  Future<void> close() {
    controller.dispose();
    _repository.close(); //In order to better prevent memory leaks
    return super.close();
  }
}
