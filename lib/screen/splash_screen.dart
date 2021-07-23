import 'package:flutter/material.dart';
import 'package:my_flutter_gallery/viewModel/gallery_view_model.dart';
import 'package:provider/provider.dart';
import '../component/router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initSplashScreen();
    });
  }

  void initSplashScreen() {
    GalleryViewModel galleryViewModel = Provider.of(context, listen: false);
    galleryViewModel.init();
    Future.delayed(Duration(milliseconds: 1000), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          MyRouter.galleryHomeScreenRoute, ModalRoute.withName('/'));
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Text(
            "Flutter Gallery",
            style:
                theme.textTheme.headline5.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
