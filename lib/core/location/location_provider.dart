import 'dart:developer';
import 'package:earlybuddy/shared/eb_model/entity/entity.dart';
import 'package:geolocator/geolocator.dart';

enum LocationStatus {
  offDeivceGPS,
  deiniedPermission,
  active,
}

// 37.487548, 127.10202381181418, 수서역
class LocationProvider {
  static final LocationProvider shared = LocationProvider();

  Future<LocationStatus> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    switch (permission) {
      case (LocationPermission.whileInUse || LocationPermission.always):
        return LocationStatus.active;
      default:
        return LocationStatus.deiniedPermission;
    }
  }

  Future<bool> checkOnDeviceGPS() async {
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    return serviceEnable;
  }

  Future<Coordi> getCurrentLocation() async {
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      return Future.error('Location Services are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return Coordi(
        x: position.longitude.toString(),
        y: position.latitude.toString(),
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
