class GalleryModel {
  String id;
  String name;
  String imagePath;


  GalleryModel({
    this.id,
    this.name,
    this.imagePath,
  });

  GalleryModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json["id"];
      name = json['name'];
      imagePath = json['imagePath'];
    } catch (e) {
      print(e);
    }
  }


  Map<String, dynamic> toJson() {
    final json = {
      "id": id,
      "name": name,
      "imagePath": imagePath,
    };
    return json;
  }
}