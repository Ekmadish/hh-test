import 'package:flutter/material.dart';
import 'package:test/constant/figma_icon_icons.dart';
import 'package:test/feature/notification/view/notification_screen.dart';
import 'package:test/feature/widget/appbarwidget.dart';
import 'package:test/feature/widget/badge_widget.dart';
import 'package:test/feature/widget/cupertinbtn_widget.dart';
import 'package:test/util/navigator_util.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
        body: Column(children: [
      SizedBox(height: mq.padding.top),
      const AppbarWidget(hasBcak: false, titlle: 'Мой профиль'),
      Expanded(
        child: Container(
            margin:
                const EdgeInsets.only(left: 16, right: 16, top: 45, bottom: 80),
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: const Color(0xffE8E8E8), width: 1)),
            child: BtnWidget(
              onTap: () {
                NavigatorUtil.push(context, const NotificationScreen());
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    BadgeWidget(
                        top: 3,
                        right: 3.7,
                        color: Color(0xffB30C0C),
                        child: Icon(FigmaIcon.notification_icon,
                            color: Colors.black)),
                    SizedBox(width: 12),
                    Text('Уведомления',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios_outlined,
                        color: Color(0xffCECECE))
                  ],
                ),
              ),
            )),
      )
    ]));
  }
}
