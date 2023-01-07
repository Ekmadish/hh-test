import 'package:flutter/material.dart';

AppBar appBar(
        {required String titlle, List<Widget>? action, Widget? leading}) =>
    AppBar(actions: action, title: Text(titlle), leading: leading);

class AppbarWidget extends StatelessWidget {
  final String titlle;
  final bool hasBcak;
  const AppbarWidget({Key? key, required this.hasBcak, required this.titlle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Stack(
          children: [
            !hasBcak
                ? const SizedBox()
                : Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                        // width: hasBcak ? 16 : 0,
                        child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back_ios_new)),
                    )),
                  ),
            Center(
              child: Text(
                titlle,
                textAlign: TextAlign.center,
                // style: AppTheme.h4.copyWith(color: AppTheme.greyscale9),
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
