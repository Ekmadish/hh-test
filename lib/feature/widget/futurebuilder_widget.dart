import 'package:flutter/material.dart';

import 'loading_widget.dart';

class FutureBuilderWidget<T> extends StatelessWidget {
  const FutureBuilderWidget(
      {Key? key,
      required this.future,
      required this.whenDone,
      this.whenError,
      this.whenActive,
      this.whenNone,
      this.initialData})
      : super(key: key);
  final Future<T> future;

  final Widget? whenActive;

  final Widget? whenNone;

  final Widget Function(T snapshotData) whenDone;

  final Widget Function(Object? error)? whenError;

  final T? initialData;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      initialData: initialData,
      key: const Key('FutureBuilder'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            if (whenError != null) {
              return whenError!(snapshot.error!);
            } else {
              return Center(child: Text(snapshot.error.toString()));
            }
          }
          return whenDone(snapshot.data as T);
        }

        return loading();
      },
    );
  }
}
