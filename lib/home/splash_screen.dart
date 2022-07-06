import 'dart:async';

import '../core/widget/page_transition.dart';
import '../features/category/presentation/bloc/category/category_bloc.dart';
import 'home_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCustomSplashScreen extends StatefulWidget {
  @override
  _MyCustomSplashScreenState createState() => _MyCustomSplashScreenState();
}

class _MyCustomSplashScreenState extends State<MyCustomSplashScreen>
    with TickerProviderStateMixin {
  double _fontSize = 2;
  double _containerSize = 1.5;
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;

  AnimationController? _controller;
  Animation<double>? animation1;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    animation1 = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
        parent: _controller!, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {
          _textOpacity = 1.0;
        });
      });

    _controller!.forward();

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _fontSize = 1.06;
      });
    });

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _containerSize = 2;
        _containerOpacity = 1;
      });
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return BlocConsumer<CategoryBloc, CategoryState>(
      listener: (context, state) {
        if (state is LoadedCategoyState || state is OfflineCategoyState) {
          Navigator.pushReplacement(
              context, PageTransition(const HomeLayout()));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.deepPurple,
          body: buildbodySplashScreen(_height, _width),
        );
      },
    );
  }

  Stack buildbodySplashScreen(double _height, double _width) {
    return Stack(
      children: [
        Column(
          children: [
            AnimatedContainer(
                duration: const Duration(milliseconds: 2000),
                curve: Curves.fastLinearToSlowEaseIn,
                height: _height / _fontSize),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 1000),
              opacity: _textOpacity,
              child: Text(
                'E-Commerce',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: animation1!.value,
                ),
              ),
            ),
          ],
        ),
        Center(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 2000),
            curve: Curves.fastLinearToSlowEaseIn,
            opacity: _containerOpacity,
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 2000),
                curve: Curves.fastLinearToSlowEaseIn,
                height: _width / _containerSize,
                width: _width / _containerSize,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Image(
                    image: AssetImage('assets/images/mobile-shop.png'))),
          ),
        ),
      ],
    );
  }
}
