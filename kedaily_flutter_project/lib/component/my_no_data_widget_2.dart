import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyNoDataWidget2 extends StatelessWidget {
  const MyNoDataWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset('assets/lotties/123936-empty-ghost.json',
          fit: BoxFit.contain),
    );
  }
}
