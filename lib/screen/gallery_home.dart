import 'package:flutter/material.dart';
import 'package:my_flutter_gallery/component/camera_view.dart';
import 'package:my_flutter_gallery/component/custom_appbar.dart';
import 'package:my_flutter_gallery/component/image_preview.dart';
import 'package:my_flutter_gallery/model/gallert_model.dart';
import 'package:my_flutter_gallery/viewModel/gallery_view_model.dart';
import 'package:provider/provider.dart';

class GalleryHomeScreen extends StatefulWidget {
  const GalleryHomeScreen({Key key}) : super(key: key);

  @override
  _GalleryHomeScreenState createState() => _GalleryHomeScreenState();
}

class _GalleryHomeScreenState extends State<GalleryHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppbar(
          title: "Gallery Home",
        ),
        body: Consumer<GalleryViewModel>(
            builder: (context, GalleryViewModel viewModel, child) {
          return LayoutBuilder(
            builder: (context, constraints) => ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: IntrinsicHeight(
                child: Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: ValueListenableBuilder(
                      valueListenable: viewModel.galleryListNotifier,
                      builder:
                          (context, List<GalleryModel> galleryList, child) {
                        if (galleryList.isEmpty) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.1),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image_outlined,
                                  size: 50,
                                  color: Colors.grey.withOpacity(0.7),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Photos you take on your device will show up here",
                                  style: theme.textTheme.headline6
                                      .copyWith(color: Colors.grey),
                                  textScaleFactor: 0.9,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        }

                        return SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 15),
                          child: GridView.count(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              physics: NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              shrinkWrap: true,
                              children: galleryList.reversed
                                  .toList()
                                  .asMap()
                                  .map((index, gallery) => MapEntry(
                                      index, ImagePreview(gallery: gallery)))
                                  .values
                                  .toList()),
                        );
                      }),
                ),
              ),
            ),
          );
        }),
        floatingActionButton: Align(
          alignment: Alignment(0, 0.95),
          child: CameraView(),
        ),
      ),
    );
  }
}
