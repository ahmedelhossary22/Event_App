import 'dart:async';

import 'package:event_app/core/routes/page_routes_name.dart';
import 'package:event_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed(PageRoutesName.onBoarding);
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: Center(
        child: Assets.images.eventLogo.image(
          width: mediaQuery.size.width * 0.5,
        ),
      ),
    );
  }
}
