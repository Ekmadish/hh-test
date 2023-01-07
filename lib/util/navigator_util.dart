import 'package:flutter/material.dart';

Route<String> transitionSlide(Widget? page) {
  return PageRouteBuilder(
    opaque: true,
    fullscreenDialog: true,
    pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) =>
        page!,
    transitionsBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      const Offset begin = Offset(0.0, 1.0);

      const Offset end = Offset.zero;
      const Cubic curve = Curves.ease;

      final Animatable<Offset> tween = Tween(
        begin: begin,
        end: end,
      ).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route transitionFade(Widget? page) {
  return PageRouteBuilder(
    fullscreenDialog: true,
    pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) =>
        page!,
    transitionsBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      return FadeTransition(
        opacity: animation,
        // position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class FadeRoute extends PageRoute {
  FadeRoute({
    @required this.builder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
  });

  final WidgetBuilder? builder;

  @override
  final Duration transitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color? barrierColor;

  @override
  final String? barrierLabel;

  @override
  final bool maintainState;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) =>
      builder!(context);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: builder!(context),
    );
  }
}

class SlideRoute extends PageRoute {
  SlideRoute({
    @required this.builder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.opaque = false,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
  });

  final WidgetBuilder? builder;

  @override
  final Duration transitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color? barrierColor;

  @override
  final String? barrierLabel;

  @override
  final bool maintainState;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) =>
      builder!(context);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    const Offset begin = Offset(0.0, 1.0);

    const Offset end = Offset.zero;
    const Curve curve = Curves.ease;

    final Animatable<Offset> tween = Tween<Offset>(
      begin: begin,
      end: end,
    ).chain(
      CurveTween(curve: curve),
    );
    return SlideTransition(
      position: animation.drive(tween),
      child: builder!(context),
    );
  }
}

class NavigatorUtil {
  static Future<void> push(BuildContext context, Widget page) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => page));
  }
}
