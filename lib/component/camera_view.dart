import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:my_flutter_gallery/viewModel/gallery_view_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class CameraView extends StatefulWidget {
  const CameraView({Key key}) : super(key: key);

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  final ImagePicker _picker = ImagePicker();
  XFile imageFile;
  LocationData currentPosition;
  ValueNotifier<Address> addressNotifier = ValueNotifier(Address());
  GoogleMapController mapController;
  Marker marker;
  Location location = Location();

  @override
  void initState() {
    super.initState();
    initLocation();
  }

  Future<void> initLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    getLoc();
  }

  Future<void> updateLocation() async {
    currentPosition = await location.getLocation();
    addressNotifier.value =
        await getAddress(currentPosition.latitude, currentPosition.longitude);
  }

  Future<void> getLoc() async {
    await updateLocation();

    location.onLocationChanged.listen((LocationData currentLocation) async {
      if ((currentLocation.latitude - currentPosition.latitude).abs() >
              0.0005 ||
          (currentLocation.longitude - currentPosition.longitude).abs() >
              0.0005) {
        currentPosition = currentLocation;
        addressNotifier.value = await getAddress(
            currentPosition.latitude, currentPosition.longitude);
      }
    });
  }

  Future<Address> getAddress(double lat, double lang) async {
    final coordinates = Coordinates(lat, lang);
    List<Address> add =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return add.first;
  }

  void _onImageButtonPressed(
    ImageSource source, {
    BuildContext context,
  }) async {
    try {
      updateLocation();

      final pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 100,
      );

      final Directory extDir = await getApplicationDocumentsDirectory();

      final fileName = addressNotifier.value.addressLine;
      String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
      String newPath = '${extDir.path}/${timestamp()}$fileName';
      await pickedFile.saveTo(newPath);

      GalleryViewModel galleryViewModel = Provider.of(context, listen: false);
      galleryViewModel.addImageToGallery(fileName, newPath);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () =>
            _onImageButtonPressed(ImageSource.camera, context: context),
        child: Container(
          margin: EdgeInsets.only(left: 30),
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(1), blurRadius: 15)
              ],
              color: Colors.blue),
          child: Icon(
            Icons.camera_alt_outlined,
            size: 28,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
