

import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:flutter/material.dart';

class onboarding extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: FancyOnBoarding(
        doneButtonText: "Done",
        skipButtonText: "Skip",
        pageList: pageList,
        onDoneButtonPressed: () =>
            Navigator.of(context).pushReplacementNamed('/fine_login1'),
        onSkipButtonPressed: () =>
            Navigator.of(context).pushReplacementNamed('/fine_login1'),
      ),
    );
  }

  final pageList = [
    PageModel(
        color: Colors.deepOrangeAccent,
        heroAssetPath: 'assets/img_wizard_1.png',
        title: Text('Hotels',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 34.0,
            )),
        body: Text('All hotels and hostels are sorted by hospitality rating',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
        iconAssetPath: 'assets/img_wizard_1.png'),
    PageModel(
        color: Colors.cyan,
        heroAssetPath: 'assets/img_wizard_2.png',
        title: Text('Banks',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 34.0,
            )),
        body: Text(
            'We carefully verify all banks before adding them into the app',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
        iconAssetPath: 'assets/img_wizard_4.png'),
    PageModel(
      color: Colors.greenAccent,
      heroAssetPath: 'assets/img_wizard_4.png',
      title: Text('Store',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 34.0,
          )),
      body: Text('All local stores are categorized for your convenience',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          )),
      iconAssetPath: 'assets/img_wizard_3.png',
    ),
  ];
}