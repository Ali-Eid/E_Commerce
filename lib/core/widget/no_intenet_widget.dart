import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorConnectionWidget extends StatelessWidget {
  final String text;
  final String pathImg;
  const ErrorConnectionWidget(
      {Key? key, required this.text, required this.pathImg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(pathImg, fit: BoxFit.fill),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
