import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyNoDataWidget extends StatelessWidget {
  const MyNoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset('assets/lotties/86045-no-data-found-json.json',
          width: 300, height: 300),
    );
  }
}
