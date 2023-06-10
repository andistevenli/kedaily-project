import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constant/my_color.dart';

class Kedaily extends StatelessWidget {
  const Kedaily({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: MyColor.whiteColor,
        ),
        initialRoute: null,
        routes: {},
      ),
    );
  }
}
