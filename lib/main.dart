import 'package:flutter/material.dart';
import 'package:my_flutter_gallery/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: MyRouter.initialRoute,
      onGenerateRoute: MyRouter.generateRoute,
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
