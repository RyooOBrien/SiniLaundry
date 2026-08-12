import 'dart:async';

import 'package:geolocator/geolocator.dart';

class LocationService {
  // ======================================================
  // CEK APAKAH LAYANAN LOKASI AKTIF
  // ======================================================

  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  // ======================================================
  // REQUEST PERMISSION
  // ======================================================

  Future<LocationPermission> requestPermission() async {
    LocationPermission permission =
        await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return permission;
  }

  // ======================================================
  // AMBIL LOKASI GPS SAAT INI
  // ======================================================

  Future<Position?> getCurrentLocation() async {
    try {
      // 1. Cek layanan lokasi
      final serviceEnabled =
          await isLocationServiceEnabled();

      if (!serviceEnabled) {
        print('LOCATION ERROR: Location service tidak aktif.');
        return null;
      }

      // 2. Cek / minta permission
      final permission = await requestPermission();

      print('LOCATION PERMISSION: $permission');

      if (permission == LocationPermission.denied) {
        print('LOCATION ERROR: Permission ditolak.');
        return null;
      }

      if (permission == LocationPermission.deniedForever) {
        print(
          'LOCATION ERROR: Permission ditolak permanen.',
        );
        return null;
      }

      // 3. Ambil posisi GPS
      print('LOCATION: Mengambil posisi...');

      final position =
          await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      ).timeout(
        const Duration(seconds: 15),
      );

      print(
        'LOCATION SUCCESS: '
        '${position.latitude}, ${position.longitude}',
      );

      return position;
    } on TimeoutException {
      print(
        'LOCATION ERROR: Timeout. '
        'Lokasi tidak berhasil didapat dalam 15 detik.',
      );

      return null;
    } catch (e) {
      print('LOCATION ERROR: $e');

      return null;
    }
  }
}