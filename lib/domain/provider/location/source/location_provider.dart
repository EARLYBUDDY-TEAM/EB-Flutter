import 'dart:developer';
import 'package:earlybuddy/domain/domain_model/domain_model.dart';
import 'package:geolocator/geolocator.dart';

// 37.487548, 127.10202381181418, 수서역
class LocationProvider {
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
