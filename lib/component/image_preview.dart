import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_flutter_gallery/model/gallert_model.dart';
import 'package:my_flutter_gallery/viewModel/gallery_view_model.dart';
import 'package:provider/provider.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({
    Key key,
    @required this.gallery,
  }) : super(key: key);

  final GalleryModel gallery;

  @override
  Widget build(BuildContext context) {
    GalleryViewModel galleryViewModel = Provider.of(context, listen: false);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () => Navigator.of(context).pop(),
                    child: Dialog(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(),
                      elevation: 0,
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Tooltip(
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: Colors.grey.withOpacity(0.8)),
                                message: gallery.name,
                                child: Image(
                                  image: FileImage(File(gallery.imagePath)),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 25),
                            InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                galleryViewModel.removeImageFromGallery(gallery.id);
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white, width: 1.5),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular((100)),
                                  ),
                                ),
                                padding: EdgeInsets.all(3),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Tooltip(
          margin: EdgeInsets.symmetric(horizontal: 15),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.grey.withOpacity(0.8)),
          message: gallery.name ?? "N/A",
          child: FadeInImage(
            fit: BoxFit.cover,
            placeholder: AssetImage("assets/logo.png"),
            image: FileImage(
              File(gallery.imagePath),
              scale: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
