import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import 'package:my_flutter_gallery/model/gallert_model.dart';

class GalleryViewModel with ChangeNotifier {
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);
  ValueNotifier<List<GalleryModel>> galleryListNotifier = ValueNotifier([]);
  LocalStorage storage = LocalStorage('myStorage');

  Future<void> init() async {
    await storage.ready;
    List<dynamic> data = storage.getItem('myGalleryKey');
    if (data != null) {
      List<GalleryModel> galleryList = data
          .asMap()
          .map((index, x) {
            return MapEntry(index, GalleryModel.fromJson(x));
          })
          .values
          .toList();

      galleryListNotifier.value = galleryList;
      galleryListNotifier.notifyListeners();
    }
  }

  void addImageToGallery(String imageName, String imagePath) {
    DateTime now = DateTime.now();

    GalleryModel gallery = GalleryModel(
      id: "$imageName-${now.toIso8601String()}",
      name: imageName,
      imagePath: imagePath,
    );

    galleryListNotifier.value.add(gallery);
    galleryListNotifier.notifyListeners();
    updateCache();
  }

  void removeImageFromGallery(String imageId) {
    galleryListNotifier.value.removeWhere((element) => element.id == imageId);
    galleryListNotifier.notifyListeners();
    updateCache();
  }

  Future<void> updateCache() async {
    await storage.ready;
    await storage.setItem(
        "myGalleryKey",
        galleryListNotifier.value
            .asMap()
            .map((key, value) => MapEntry(key, value.toJson()))
            .values
            .toList());
  }
}
