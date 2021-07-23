import 'package:flutter/material.dart';
import 'package:my_flutter_gallery/component/router.dart';
import 'package:my_flutter_gallery/viewModel/gallery_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<GalleryViewModel>.value(value: GalleryViewModel())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fluuter Gallery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: MyRouter.initialRoute,
      onGenerateRoute: MyRouter.generateRoute,
    );
  }
}
