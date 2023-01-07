import 'package:flutter/material.dart';
import 'package:test/feature/notification/model/notification_model.dart';
import 'package:test/feature/widget/cupertinbtn_widget.dart';
import 'package:test/feature/widget/loading_widget.dart';
import 'package:test/util/date_time_extension.dart';

class NotificationDetailScreen extends StatelessWidget {
  final Datum data;
  const NotificationDetailScreen({Key? key, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero.copyWith(bottom: 40),
            children: [
              SizedBox(
                  height: mq.size.height * .6,
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12)),
                      child: Stack(
                          alignment: AlignmentDirectional.center,
                          fit: StackFit.expand,
                          children: [
                            data.imageUrl == null
                                ? Image.asset('assets/noImage.jpeg')
                                : Image.network(loadingBuilder:
                                    (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return loading();
                                  }, data.imageUrl!, fit: BoxFit.cover),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: ListTile(
                                    contentPadding:
                                        const EdgeInsets.only(left: 48),
                                    title: Text(data.title ?? 'nil',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 28,
                                            fontWeight: FontWeight.w500)),
                                    subtitle: Text(
                                        StringExtension
                                            .displayTimeAgoFromTimestamp(
                                                data.notifiedAt.toString()),
                                        style: const TextStyle(
                                            color: Color(0xff9A9A9A),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400))))
                          ]))),
              Padding(
                  padding: const EdgeInsets.only(top: 26, left: 21, right: 21),
                  child: Column(children: [
                    Text(data.description ?? 'nil',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400))
                  ]))
            ],
          ),
          Column(
            children: [
              SizedBox(height: mq.padding.top),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: BtnWidget(
                  child:
                      const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  onTap: () => Navigator.pop(context),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
