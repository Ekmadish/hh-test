import 'package:flutter/material.dart';
import 'package:test/constant/constant.dart';
import 'package:test/feature/notification/cubit/notification_cubit.dart';
import 'package:test/feature/notification/model/notification_model.dart';
import 'package:test/feature/notificationdetail/view/notification_detail_screen.dart';
import 'package:test/feature/widget/appbarwidget.dart';
import 'package:test/feature/widget/cupertinbtn_widget.dart';
import 'package:test/feature/widget/loading_widget.dart';
import 'package:test/util/date_time_extension.dart';
import 'package:test/util/navigator_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        lazy: true,
        key: const ValueKey('BlocProvider'),
        create: (context) => NotificationCubit(),
        child: Scaffold(
            appBar: appBar(
                titlle: 'Уведомления',
                leading: BtnWidget(
                  child:
                      const Icon(Icons.arrow_back_ios_new, color: Colors.black),
                  onTap: () => Navigator.pop(context),
                )),
            // floatingActionButton: FloatingActionButton(onPressed: () async {
            //   await Repository().postNotification();
            //   await Repository().unreadNotificationCount();
            // }),
            backgroundColor: Constant.bcColor,
            body: blocVariant()));
  }

  Widget blocVariant() {
    return BlocBuilder<NotificationCubit, NotificationState>(
      buildWhen: (previous, current) => true,
      key: const ValueKey('BlocBuilder'),
      builder: (context, state) {
        var cubit = context.read<NotificationCubit>();
        if (state.loading) {
          return loading();
        } else if (state.haserror) {
          return Center(
              child: TextButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    alignment: Alignment.center,
                    elevation: MaterialStateProperty.all(0),
                  ),
                  label: Text(state.message,
                      style: const TextStyle(color: Colors.red)),
                  onPressed: () async {
                    await cubit.getNotification();
                  },
                  icon: const Icon(Icons.error_sharp, color: Colors.red)));
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            BtnWidget(
                onTap: () async {
                  await cubit.markAllRead();
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xff1C1C1C),
                        borderRadius: BorderRadius.circular(5)),
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    margin: const EdgeInsets.only(left: 16),
                    child: const Text('Отметить все как прочитанные',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w300)))),
            const SizedBox(height: 10),
            Expanded(
                child: RefreshIndicator(
              onRefresh: () async {
                await cubit.getNotification();
              },
              child: NotificationListener<ScrollEndNotification>(
                key: const ValueKey('NotificationListener'),
                onNotification: (scrollEnd) {
                  final metrics = scrollEnd.metrics;
                  if (metrics.atEdge) {
                    bool isTop = metrics.pixels == 0;
                    if (!isTop) {
                      cubit.loadMore();
                    }
                  }
                  return true;
                },
                child: ListView.builder(
                    controller: cubit.controller,
                    key: const ValueKey('ListViewbuilder'),
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero.copyWith(bottom: 20),
                    shrinkWrap: true,
                    itemCount: state.notificationModel!.data!.length + 1,
                    itemBuilder: (context, index) {
                      if (index == state.notificationModel!.data!.length) {
                        if (cubit.hasNextPage) {
                          return Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: loading());
                        }
                        return const SizedBox();
                      } else {
                        var data = state.notificationModel!.data![index];
                        return item(context, data!);
                      }
                    }),
              ),
            ))
          ],
        );
      },
    );
  }
}

Widget item(BuildContext context, Datum data) {
  var isRead = data.isRead ?? false;

  var date = data.notifiedAt;
  return Container(
      margin: const EdgeInsets.only(top: 20, left: 16, right: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
              color: !isRead ? Colors.black : const Color(0xffE8E8E8),
              width: 1)),
      child: BtnWidget(
          onTap: () async {
            NavigatorUtil.push(
                context,
                NotificationDetailScreen(
                  data: data,
                ));
            if (!isRead) {
              await context
                  .read<NotificationCubit>()
                  .markReadNotification(data.id!);
            }
          },
          child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9)),
              minLeadingWidth: 0,
              contentPadding: const EdgeInsets.all(20),
              leading: SizedBox(
                width: 94,
                height: 70,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: data.imageUrl == null
                      ? Image.asset('assets/noImage.jpeg')
                      : Image.network(
                          loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return loading();
                        }, data.imageUrl!, fit: BoxFit.cover),
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(data.title ?? 'nil'),
              ),
              isThreeLine: false,
              subtitle: Text(StringExtension.displayTimeAgoFromTimestamp(
                  date.toString())))));
}
