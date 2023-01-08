import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/constant/figma_icon_icons.dart';
import 'package:test/feature/notification/view/notification_screen.dart';
import 'package:test/feature/profile/bloc/profile_bloc.dart';
import 'package:test/feature/profile/cubit/profile_cubit.dart';
import 'package:test/feature/widget/widgets.dart';
import 'package:test/util/navigator_util.dart';

//In this case, I wrote bloc cubit both to more clearly show bloc skills

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return blcoVersion(context); // bloc
    return cubitVersion(context); //cubit
  }
}

Widget cubitVersion(BuildContext context) {
  var mq = MediaQuery.of(context);

  return BlocProvider(
    lazy: true,
    create: (context) => ProfileCubit(),
    child: Scaffold(
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
          child: BlocBuilder<ProfileCubit, ProfileStateCubit>(
            builder: (context, state) {
              var cubit = context.read<ProfileCubit>();
              if (state.loading) {
                return loading();
              } else if (state.success) {
                return RefreshIndicator(
                  onRefresh: () async {
                    await cubit.getNotificationCount();
                  },
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    padding: EdgeInsets.zero,
                    children: [
                      BtnWidget(
                        onTap: () {
                          NavigatorUtil.push(
                              context, const NotificationScreen());
                        },
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                BadgeWidget(
                                    top: 3,
                                    right: 3.7,
                                    color: state.count == 0
                                        ? Colors.transparent
                                        : const Color(0xffB30C0C),
                                    child: const Icon(
                                        FigmaIcon.notification_icon,
                                        color: Colors.black)),
                                const SizedBox(width: 12),
                                const Text('Уведомления',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                const Spacer(),
                                const Icon(Icons.arrow_forward_ios_outlined,
                                    color: Color(0xffCECECE))
                              ],
                            )),
                      )
                    ],
                  ),
                );
              } else if (state.haserror) {
                return Center(
                    child: TextButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          alignment: Alignment.center,
                          elevation: MaterialStateProperty.all(0),
                        ),
                        label: Text(state.message,
                            style: const TextStyle(color: Colors.red)),
                        onPressed: () async {
                          await cubit.getNotificationCount();
                        },
                        icon:
                            const Icon(Icons.error_sharp, color: Colors.red)));
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      )
    ])),
  );
}

Widget blcoVersion(BuildContext context) {
  var mq = MediaQuery.of(context);
  return BlocProvider(
    lazy: true,
    create: (context) => ProfileBloc(),
    child: Scaffold(
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
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoding) {
                return loading();
              } else if (state is ProfileSuccess) {
                return RefreshIndicator(
                  onRefresh: () async {
                    context
                        .read<ProfileBloc>()
                        .add(GetNotificationCountEvent());
                  },
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    padding: EdgeInsets.zero,
                    children: [
                      BtnWidget(
                        onTap: () {
                          NavigatorUtil.push(
                              context, const NotificationScreen());
                        },
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                BadgeWidget(
                                    top: 3,
                                    right: 3.7,
                                    color: state.count == 0
                                        ? Colors.transparent
                                        : const Color(0xffB30C0C),
                                    child: const Icon(
                                        FigmaIcon.notification_icon,
                                        color: Colors.black)),
                                const SizedBox(width: 12),
                                const Text('Уведомления',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                const Spacer(),
                                const Icon(Icons.arrow_forward_ios_outlined,
                                    color: Color(0xffCECECE))
                              ],
                            )),
                      )
                    ],
                  ),
                );
              } else if (state is ProfileError) {
                return Center(
                    child: TextButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          alignment: Alignment.center,
                          elevation: MaterialStateProperty.all(0),
                        ),
                        label: Text(state.message!,
                            style: const TextStyle(color: Colors.red)),
                        onPressed: () async {
                          context
                              .read<ProfileBloc>()
                              .add(GetNotificationCountEvent());
                        },
                        icon:
                            const Icon(Icons.error_sharp, color: Colors.red)));
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      )
    ])),
  );
}
